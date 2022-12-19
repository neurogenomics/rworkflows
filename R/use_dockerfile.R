#' Use Dockerfile
#' 
#' Creates a Docker file to be used with the GitHub Actions (GHA) workflows
#' distributed by \pkg{rworkflows}.
#' @param save_dir Directory to save the Docker file to.
#' @param path Path to the Docker file.
#' @param force_new If a Docker file already exists, overwrite it 
#' (default: \code{FALSE}).
#' @param show Print the contents of the Docker file in the R console.
#' @param verbose Print messages.
#' @returns Path to Docker file.
#' 
#' @export
#' @importFrom utils download.file
#' @importFrom here here
#' @examples 
#' path <- use_dockerfile(save_dir=tempdir())
use_dockerfile <- function(save_dir=here::here(),
                           path=file.path(save_dir,"Dockerfile"),
                           force_new=FALSE,
                           show=FALSE,
                           verbose=TRUE){
  
  if(file.exists(path) &&
     isFALSE(force_new)){
    messager("Using existing Docker file:",path,v=verbose)
  } else {
    messager("Creating new Docker file ==>",path,v=verbose)
    dir.create(dirname(path), showWarnings = FALSE, recursive = TRUE) 
    file.copy(from = system.file("templates","Dockerfile",
                                 package = "rworkflows"), 
              to = path,  
              overwrite = TRUE)
  }
  if(isTRUE(show)){
    messager("Docker file preview:",v=verbose)
    cat(paste(readLines(path),collapse ="\n"))
  }
  return(path)
}
