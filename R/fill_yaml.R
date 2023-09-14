fill_yaml <- function(yml,
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
                      github_token,
                      docker_user,
                      docker_org,
                      docker_token,
                      cache_version,
                      enable_act){
  # devoptera::args2vars(use_workflow)
  
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
  #### Supply variables as "with:" or "env:" ####
  nonarg_list <- c("yml","name","template","tag","on","branches","runners")
  args_list <- names(formals(fill_yaml))
  args_list <- args_list[!args_list %in% nonarg_list]
  omit_list <- c("tinytex_installer","tinytex_version","pandoc_version")
  #### Omit certain variables when equal to default ####
  ## Don't do this for rworkflows_static as this setup has no default values.
  for(a in args_list){
    nm <- if(a %in% c("github_token","docker_token")) toupper(a) else a
    with2[nm] <- if(a %in% omit_list &&
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
