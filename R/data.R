#' Static Bioc packages list
#' 
#' A static snapshot of all Bioconductor packages from 
#' \link[BiocPkgTools]{biocPkgList}.
#' Last updated: Sept. 06 2023
#' @source \code{
#' as_ascii <- function(dt,
#'                      cols=names(dt)){
#'   cols <- cols[cols %in% names(dt)]
#'   func <- function(v){
#'     Encoding(v) <- "latin1"
#'     iconv(v, "latin1", "UTF-8")
#'   }
#'   for(col in cols){
#'     if(is.character(dt[[col]])){
#'       dt[[col]] <- func(dt[[col]])
#'     }
#'   }
#'   return(dt)
#' }
#' biocpkgtools_db <- get_description_repo_biocpkgtools(repo="BioCsoft")
#' biocpkgtools_db <-  as_ascii(biocpkgtools_db[seq(100)])
#' usethis::use_data(biocpkgtools_db, overwrite = TRUE)
#' }
#' @usage data("biocpkgtools_db")
"biocpkgtools_db" 