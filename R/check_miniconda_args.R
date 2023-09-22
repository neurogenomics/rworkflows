#' Check Miniconda arguments
#' 
#' @inheritParams use_workflow
#' @returns Named list of updated args
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
