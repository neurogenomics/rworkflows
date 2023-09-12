#' Get DESCRIPTION
#' 
#' The \href{https://en.wikipedia.org/wiki/Taken_(film)}{Liam Neeson}
#'  of \emph{DESCRIPTION} file functions.
#' \enumerate{
#' \item{I will look for you,}
#' \item{I will find you,}
#' \item{---and I will import you into a neatly parsed R object.}
#' }
#' Uses a variety of alternative methods, including searching locally and on
#' GitHub (whenever possible). Prioritises the fastest methods that do
#' not involve downloading files first.
#' @param refs Reference for one or more GitHub repository in owner/repo format
#'  (e.g.\code{"neurogenomics/rworkflows"}), or an R package name 
#' (e.g. \code{"rworkflows"}).
#' @param paths Paths to \emph{DESCRIPTION} file(s)  R package(s).
#' @param cache_dir Directory where to cache downloaded files.
#' @param force_new Ignore cached files and re-download them instead.
#' @param verbose Print messages.
#' @param use_wd Search the local working directory (and the one above it)
#' for \emph{DESCRIPTION} files.
#' @param use_repos Use R standard R package repositories like CRAN and Bioc
#' to find \emph{DESCRIPTION} files.
#' @inheritParams get_description_repo
#' @returns A named list of \code{packageDescription} objects.
#' 
#' @export
#' @importFrom desc desc
#' @importFrom here here
#' @importFrom methods is
#' @importFrom utils download.file
#' @importFrom tools R_user_dir
#' @examples 
#' d <- get_description(refs="neurogenomics/rworkflows")
get_description <- function(refs=NULL,
                            paths=here::here("DESCRIPTION"),
                            db=NULL,
                            cache_dir=tools::R_user_dir(package = "rworkflows",
                                                        which = "cache"),
                            force_new=FALSE,
                            use_wd=TRUE,
                            use_repos=FALSE,
                            verbose=TRUE){
  # devoptera::args2vars(get_description)
  
  paths <- check_paths(refs = refs,
                       paths = paths, 
                       verbose = verbose)
  refs <- refs_to_list(refs = refs)
  paths <- refs_to_list(refs = paths) 
  if(methods::is(refs[[1]],"description")) {
    refs <- check_refs_names(dl = refs) 
    return(refs)
  }
  if(methods::is(paths[[1]],"description")) {
    paths <- check_refs_names(dl = paths) 
    return(paths) 
  }
  if(all(is.na(refs))) refs <- NULL
  #### Method 1 ####
  if(isFALSE(use_repos) || 
     is.null(refs)){
    dl1 <- get_description_manual(refs=refs,
                                  paths=paths,
                                  cache_dir=cache_dir,
                                  force_new=force_new,
                                  use_wd=use_wd,
                                  verbose=verbose)
    dl1 <- check_refs_names(dl = dl1) 
    return(dl1)
    refs <- names(dl1)
    # if(!is.null(unlist(dl1))){
    #   if(all(basename(unlist(refs)) %in% basename(names(dl1)))) {
    #     return(dl1)
    #   } 
    # }
  } else {
  #### Method 2 #### 
    dl2 <- get_description_repo(refs = refs,
                                db = db,   
                                verbose = verbose)
    dl2 <- check_refs_names(dl = dl2) 
    return(dl2)
  } 
}
