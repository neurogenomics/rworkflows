#' Get DESCRIPTION
#' 
#' Find the DESCRIPTION file for a package
#'  through a variety of alternative methods.
#' @param path Path to DESCRIPTION file of an R package.
#' @inheritParams badger::badge_last_commit
#' @returns \code{packageDescription} object
#' 
#' @export
#' @importFrom desc desc
#' @importFrom utils packageDescription download.file
#' @examples 
#' d <- get_description(ref="neurogenomics/rworkflows")
get_description <- function(ref=NULL,
                            path="./DESCRIPTION"){
  
  wrn <- "Cannot find DESCRIPTION file."
  path_ <- file.path("..",path)
  if(!is.null(path) && 
     file.exists(path)){
    d <- desc::desc(file = path)
  } else if(!is.null(path) && 
            file.exists(path_)){
    d <- desc::desc(file = path_)
  } else if(!is.null(ref)){
    remote <- paste0("https://github.com/",ref,"/raw/master/DESCRIPTION")
    if(url_exists(remote)){
      tmp <- tempfile(fileext = "DESCRIPTION")
      utils::download.file(remote,tmp)
      d <- desc::desc(file = tmp)  
    } else if (!all(is.na( 
      suppressWarnings(utils::packageDescription(basename(ref)))
      )) ){
      d <- utils::packageDescription(basename(ref))
      return(NULL)
    } else {
      messager(wrn)
      return(NULL)
    }
  } else {
    messager(wrn)
    return(NULL)
  } 
}
