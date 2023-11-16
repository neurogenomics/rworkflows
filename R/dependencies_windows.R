#' Windows dependencies
#' 
#' Construct a command to install system dependencies for the 
#' Windows environment. 
#' @inheritParams dependencies_linux
#' @returns Command to install system dependencies.
#' 
#' @export
#' @examples
#' dependencies_windows()
dependencies_windows <- function(extra=c("curl"),
                                 prefix="npm install",
                                 verbose=TRUE){ 
  # devoptera::args2vars(windows_dependencies)  
  
  cmd <- paste(prefix,paste(extra,collapse=" ")) 
  messager(cmd,v=verbose)
  cat(cmd)
}
