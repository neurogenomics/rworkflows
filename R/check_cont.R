#' Check containers exist
#' 
#' Check that a list of containers are valid.
#' @inheritParams construct_runners
#' @param domain Container repository API domain.
#' @returns Null
#' 
#' @keywords internal 
check_cont <- function(cont, 
                       verbose = TRUE){
  # devoptera::args2vars(check_cont)
  # cont <- list("ghcr.io/bioconductor/bioconductor_docker:devel" )
  
  n_parts <- check_cont_general(cont)
  for(co in cont){
    if(is.null(co)) next()
    #### Check container ####
    if(grepl("ghcr.io",co)){
      check_cont_ghcr(cont = co,
                      verbose = verbose)
    } else if(grepl("docker.io",cont)){
      check_cont_dockerhub(cont = co,
                           verbose = verbose)
    } else if(n_parts==2){
      messager("Assuming container is on DockerHub.",v=verbose)
      check_cont_dockerhub(cont = co,
                           verbose = verbose)
    } else {
      warning(paste(
        "Unable to check registry for container",co,
        "Skipping check."
      ))
    }
  }
 
}
