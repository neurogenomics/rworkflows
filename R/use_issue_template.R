#' Use Issue Template
#' 
#' Creates one or more Issue Templates to be used in a GitHub repository.
#' @inheritParams use_dockerfile
#' @returns Path to Issue Templates.
#' 
#' @export
#' @importFrom utils download.file
#' @importFrom here here
#' @examples 
#' path <- use_issue_template(save_dir=tempdir())
use_issue_template <- function(templates=c("bug_report.md",
                                           "feature_request.md"),
                               save_dir=here::here(".github",
                                                   "ISSUE_TEMPLATE"),
                               path=file.path(save_dir,templates),
                               force_new=FALSE,
                               show=FALSE,
                               verbose=TRUE){
  for(p in path){ 
    if(file.exists(p) &&
       isFALSE(force_new)){
      messager("Using existing Issue Template:",p,v=verbose)
    } else {
      messager("Creating new Issue Template ==>",p,v=verbose)
      dir.create(dirname(p), showWarnings = FALSE, recursive = TRUE) 
      file.copy(from = system.file("templates",basename(p),
                                   package = "rworkflows"), 
                to = p,  
                overwrite = TRUE)
    }
    if(isTRUE(show)){
      messager("Issue Template preview:",v=verbose)
      cat(paste(readLines(p),collapse ="\n"))
    }
  }
  return(path)
}
