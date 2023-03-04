#' Use README
#' 
#' Creates an rmarkdown README file that autofills using metadata from the 
#' R package \emph{DESCRIPTION} file.
#' @inheritParams use_vignette_docker
#' @returns Path to README file.
#' 
#' @export
#' @importFrom yaml read_yaml as.yaml
#' @importFrom here here
#' @examples
#' ## use default save_dir in practice
#' path <- use_readme(save_dir = tempdir()) 
use_readme <- function(save_dir=here::here(),
                       path=file.path(save_dir,
                                      "README.Rmd"),
                       force_new=FALSE,
                       show=FALSE,
                       verbose=TRUE){
  
  #### Check if file exists already ####
  path <- path[[1]]
  if(file.exists(path) &
     isFALSE(force_new)){
    messager("Using existing README file:",path,v=verbose)
  } else {
    messager("Creating new README file ==>",path,v=verbose)
    suppressWarnings(
      dir.create(dirname(path)[[1]], showWarnings = FALSE, recursive = TRUE)
    )
    #### get the template ####
    template_path <- system.file("templates","README.Rmd",
                                 package = "rworkflows")
    out <- file.copy(from = template_path,
                     to = path, 
                     overwrite = TRUE,
                     recursive = TRUE)
  }
  if(isTRUE(show)){
    messager("README file preview:",v=verbose)
    cat(paste(readLines(path),collapse ="\n"))
  }
  return(path)
}
