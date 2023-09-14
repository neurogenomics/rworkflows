#' Construct runners
#' 
#' Construct runner configurations across multiple Operating Systems (OS)
#'  for GitHub Actions workflow. 
#' @param os Which OS to launch GitHub Actions on. 
#' @param bioc Which Bioconductor version to use on each OS. 
#' See \link[rworkflows]{bioc_r_versions} documentation for all options.
#' @param r Which R version to use on each OS. 
#' @param cont Which Docker container to use on each OS
#'  (\code{NULL} means no container will be used for that OS).
#'  See 
#'  \href{https://hub.docker.com/r/bioconductor/bioconductor_docker/tags}{here}
#'   for a list of all official Bioconductor Docker container versions.
#' @param rspm Which R repository manager to use on each OS
#'  (\code{NULL} means the default will be used for that OS).
#' @param versions_explicit Specify R/Bioc versions explicitly
#'  (e.g. \code{r: 4.2.0, bioc: 3.16}) 
#'  as opposed to flexibly (e.g. \code{r: "latest", bioc: "release"}).
#' @param verbose Print messages. 
#' @inheritParams construct_cont
#' @returns Named list of configurations for each runner OS.
#' 
#' @export
#' @importFrom stats setNames
#' @examples 
#' runners <- construct_runners()
construct_runners <- function(os=c("ubuntu-latest",
                                   "macOS-latest",
                                   "windows-latest"),
                              bioc = list("devel",
                                          "release",
                                          "release"),
                              r = list("auto",
                                       "auto",
                                       "auto"),
                              versions_explicit = FALSE, 
                              run_check_cont = FALSE,
                              cont = construct_cont(
                                default_tag = bioc[[1]],
                                run_check_cont = run_check_cont), 
                              rspm = list(
                                paste0(
                                "https://packagemanager.rstudio.com/",
                                "cran/__linux__/latest/release"),
                                NULL,
                                NULL), 
                              verbose = TRUE
                              ){ 
  # devoptera::args2vars(construct_runners, reassign = TRUE)
  
  #### Check args ####
  args <- construct_runners_check_args(os = os, 
                                       bioc = bioc, 
                                       r = r, 
                                       cont = cont,
                                       rspm = rspm)   
  #### Set runners ####
  runners <- lapply(os, function(o){
    if(isTRUE(versions_explicit)){
      info <- bioc_r_versions(bioc_version = args$bioc[[o]])
    } else { 
      info <- list(bioc=check_bioc_version(bioc = args$bioc[[o]]), 
                   r=check_r_version(r = args$r[[o]])
                   )
    } 
    #### Check container settings ####
    if(isTRUE(run_check_cont)){
      cont <- check_cont(cont=cont, 
                         verbose=verbose)
    }
    #### Construct new list ####
    list(os = o,
         bioc = info$bioc,
         r = info$r,
         cont = args$cont[[o]],
         rspm = args$rspm[[o]]
         )
  })
  return(runners) 
}
