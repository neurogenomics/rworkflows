#' Use Dockerfile
#' 
#' Creates a Docker file to be used with the GitHub Actions (GHA) workflows
#' distributed by \pkg{rworkflows}.
#' @param base_image Base Docker image to use.
#' @param save_dir Directory to save the Docker file to.
#' @param path Path to the Docker file.
#' @param force_new If a Docker file already exists, overwrite it 
#' (default: \code{FALSE}).
#' @inheritParams use_workflow
#' @returns Path to Docker file.
#' 
#' @export
#' @importFrom utils download.file
#' @importFrom here here
#' @examples 
#' path <- use_dockerfile(save_dir=tempdir())
use_dockerfile <- function(save_dir=here::here(),
                           path=file.path(save_dir,"Dockerfile"),
                           base_image=construct_cont()[[1]],
                           force_new=FALSE,
                           timeout=2000,
                           preview=FALSE,
                           verbose=TRUE){
  # devoptera::args2vars(use_dockerfile)
  
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
    txt <- readLines(path)
    txt <- gsub("^FROM \\{BASE_IMAGE\\}",paste("FROM",base_image),txt)
    txt <- gsub("\\{TIMEOUT\\}",timeout,txt)
    writeLines(txt,path)
  }
  if(isTRUE(preview)){
    messager("Docker file preview:",v=verbose)
    cat(paste(readLines(path),collapse ="\n"))
  }
  return(path)
}
