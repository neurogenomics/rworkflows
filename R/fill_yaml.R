fill_yaml <- function(## function-level args
                      yml,
                      verbose=TRUE,
                      omit_defaults = c("tinytex_installer",
                                        "tinytex_version",
                                        "pandoc_version",
                                        "miniforge_variant",
                                        "miniforge_version",
                                        "activate_environment",
                                        "environment_file",
                                        "channels",
                                        "docker_registry",
                                        "cache_version"),
                      enable_act,
                      ## action-level args
                      name,
                      template,
                      tag,
                      on,
                      branches,
                      runners,
                      ## workflow-level args
                      run_bioccheck,
                      run_rcmdcheck, 
                      as_cran,
                      run_vignettes,
                      has_testthat, 
                      run_covr, 
                      run_pkgdown, 
                      has_runit, 
                      has_latex,
                      tinytex_installer,
                      tinytex_version,
                      pandoc_version,
                      run_docker,  
                      docker_registry,
                      github_token,
                      docker_user,
                      docker_org,
                      docker_token,
                      cache_version, 
                      miniforge_variant,
                      miniforge_version,
                      activate_environment,
                      environment_file,
                      channels){
  # devoptera::args2vars(use_workflow)
  
  docker_registry <- docker_registry[1]
  #### name ####
  yml$name <- name
  #### on ####
  on2 <- lapply(stats::setNames(on,on),
                function(x){list("branches"=branches)})
  yml$on <- on2
  #### set runners ####
  if(!is.null(runners)){
    yml$jobs[[1]]$strategy$matrix$config <- runners 
  }
  #### static workflow vs. action ####
  if(template=="rworkflows_static"){
    with2 <- as.list(yml$env)
  } else if(template=="rworkflows"){
    #### Set tag ####
    yml$jobs[[1]]$steps[[2]]$uses <- paste0("neurogenomics/",template,tag)   
    #### with: args #### 
    with2 <- yml$jobs[[1]]$steps[[2]]$with
    ### Enable running workflow locally with act ####
    if(isFALSE(enable_act)){
      yml$jobs[[1]]$steps[[1]] <- NULL
    }  
  }
  #### Check Miniconda args ####
  miniconda_args <- check_miniconda_args( 
    runners=runners,
    miniforge_variant=miniforge_variant,
    miniforge_version=miniforge_version,
    activate_environment=activate_environment,
    environment_file=environment_file,
    channels=channels,
    verbose=verbose)
  miniforge_variant <- miniconda_args$miniforge_variant
  miniforge_version <- miniconda_args$miniforge_version
  activate_environment <- miniconda_args$activate_environment
  environment_file <- miniconda_args$environment_file
  channels <- miniconda_args$channels  
  #### Supply variables as "with:" or "env:" ####
  nonarg_list <- c("yml","verbose","omit_defaults","enable_act",
                   "name","template","tag","on","branches","runners")
  args_list <- names(formals(fill_yaml))
  args_list <- args_list[!args_list %in% nonarg_list] 
  #### Omit certain variables when equal to default ####
  ## Don't do this for rworkflows_static as this setup has no default values.
  for(a in args_list){
    nm <- if(a %in% c("github_token","docker_token")) toupper(a) else a
    with2[nm] <- if(a %in% omit_defaults &&
                    template!="rworkflows_static") {
      omit_if_default(arg = a)
    } else {
      get(a)
    }
  }   
  #### static workflow vs. action ####
  if(template=="rworkflows_static"){
    yml$env <- with2
  } else if(template=="rworkflows"){ 
    #### replace with: args ####
    steps <- yml$jobs[[1]]$steps
    yml$jobs[[1]]$steps[[length(steps)]]$with <- with2
  }
  return(yml) 
}


#' Check Miniconda arguments
#' 
#' Check Miniconda arguments for compatibility with one another.
#' @inheritParams use_workflow
#' @returns Named list of updated args.
#' 
#' @keywords internal
check_miniconda_args <- function(runners, 
                                 miniforge_variant,
                                 miniforge_version,
                                 activate_environment,
                                 environment_file,
                                 channels,
                                 verbose=TRUE){
  
  for(a in c("miniforge_version",
             "environment_file",
             "activate_environment")){
    if(!is_default(arg=a, val=get(a), func="use_workflow") && 
       isFALSE(miniforge_variant)){
      messager(a,"supplied. Enabling miniforge.", v=verbose)
      miniforge_variant <- TRUE
    }
  }
  #### Check if python-version set ####
  if(isTRUE(miniforge_variant)) { 
    #### Check runners ####
    for(r in runners){
      if(is.null(r$`python-version`)){
        messager("python-version not set for runner",
                 paste0("os=",shQuote(r$os),"."),
                 "Using default.",v=verbose)
      }
    }
  }
  if(isTRUE(miniforge_variant)) miniforge_variant <- ""
  return(list( 
    miniforge_variant=miniforge_variant,
    miniforge_version=miniforge_version,
    activate_environment=activate_environment,
    environment_file=environment_file,
    channels=channels
  ))
}

