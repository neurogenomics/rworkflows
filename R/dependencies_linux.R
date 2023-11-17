#' Linux dependencies
#' 
#' Construct a command to install system dependencies for the 
#' Linux OS environment.
#' Includes all dependencies listed by \link[remotes]{system_requirements}, 
#' in addition to user-specified dependencies via \code{extra}.
#' Set to \code{NULL} to return a character vector of dependencies instead.
#' @param prefix Prefix to prepend to the command. 
#' @param extra Additional dependencies to install.
#' @param verbose Print messages.
#' @inheritParams remotes::system_requirements
#' @inheritDotParams remotes::system_requirements
#' @returns Command to install system dependencies.
#' 
#' @export
#' @examples
#' dependencies_linux(package="rworkflows")
dependencies_linux <- function(os = "ubuntu", 
                               os_release = "20.04",
                               extra=c("qpdf",
                                       "rsync",
                                       
                                       "git-core",
                                       "libicu-dev",
                                       "zlib1g-dev" ,
                                       "xfonts-100dpi",
                                       "xfonts-75dpi" ,
                                       "biber" ,
                                       "libsbml5-dev",
                                       "cmake",
                                       "pandoc" ,
                                       "pandoc-citeproc"),
                               prefix=paste("apt-get update -y",
                                            "apt-get install -y",
                                            sep=" && "),
                               verbose = TRUE,
                                ...
                                ){ 
  # devoptera::args2vars(linux_dependencies) 
  deps <- gsub("apt-get install -y ", "", 
                    remotes::system_requirements(os = os,
                                                 os_release = os_release,
                                                 ...)
               )
  deps <- sort(unique(c(deps,extra)))
  #### Return ####
  if(is.null(prefix)){
    return(deps)
  } else {
    cmd <- paste(prefix,paste(deps,collapse = " ")) 
    messager(cmd,v=verbose)
    cat(cmd)
  }
}
