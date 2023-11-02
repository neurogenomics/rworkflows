#' Infer Docker registry organisation name
#' 
#' Infer Docker registry organisation name from DESCRIPTION file.
#' @inheritParams use_vignette_docker
#' @inheritParams use_workflow
#' @inheritDotParams get_description
#' @returns Docker registry organisation name.
#' 
#' @export
#' @examples
#' infer_docker_org(docker_org="myorg", docker_registry="ghcr.io")
infer_docker_org <- function(docker_org=NULL,
                             docker_registry,
                             verbose=TRUE,
                             ...){
  if(!is.null(docker_org)){
    return(docker_org)
  } else if(is.null(docker_org) && 
     grepl("ghcr.io",docker_registry)){
    ## Infer docker_org from DESCRIPTION
    desc_file <- get_description(verbose = verbose,
                                 ...)
    gh_url <- get_github_url_desc(desc_file = desc_file[[1]])
    if(!is.null(gh_url)){
      docker_org <- rev(strsplit(gh_url,"/")[[1]])[2]
      return(docker_org)
    } else {
      stopper("docker_org must be supplied.")
    }
  } else {
    stopper("docker_org must be supplied.")
  }
}