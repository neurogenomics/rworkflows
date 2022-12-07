#' Use badges
#' 
#' Create one or more badges showing the status of your R package.
#' Uses the package 
#' \href{https://github.com/GuangchuangYu/badger}{\pkg{badger}}.
#' @param add_github_version Add package version with 
#' \link[badger]{badge_github_version}.
#' @param add_actions The name of one or more GitHub Actions to show the 
#' status for with \link[badger]{badge_github_actions}
#'  (e.g. c("rworkflows","rworkflows_static")).
#' @param add_commit Add the last GitHub repo commit date with
#' \link[badger]{badge_last_commit}.
#' 
#' @param add_hex Add a hex sticker. 
#' If \code{add_hex=TRUE}, will assume the sticker is located at the following
#'  relative path: "inst/hex/hex.png". 
#'  If \code{add_hex} is a character string, this will instead
#' be used as the relative hex path (e.g. \code{"/images/mysticker.png"}). 
#' @param add_codecov Add CodeCov status with
#' \link[badger]{badge_codecov}.
#' @param add_code_size Add code size with
#' \link[badger]{badge_code_size}.
#' @param add_license Add license info with
#' \link[badger]{badge_license}.
#' @param add_doi Add the DOI of a given package or publication 
#' associated with the package. Must be provided as a character string.
#' @param add_authors Add author names inferred from 
#' the \code{DESCRIPTION} file.
#' 
#' @param add_bioc_release Add Bioc release version with 
#' \link[badger]{badge_bioc_release}.
#' @param add_bioc_download_month Add the number of Bioc downloads last month 
#' \link[badger]{badge_bioc_download}.
#' @param add_bioc_download_total Add the number of Bioc downloads total
#' \link[badger]{badge_bioc_download}.
#' @param add_bioc_download_rank Add the download rank of the package on Bioc
#' \link[badger]{badge_bioc_download_rank}.
#' 
#' @param add_cran_release Add Bioc release version with 
#' \link[badger]{badge_cran_release}.
#' @param add_cran_checks Add whether package is passing all checks on CRAN 
#' with \link[badger]{badge_cran_checks}.
#' @param add_cran_download_month Add the number of CRAN downloads last month 
#' \link[badger]{badge_cran_download}.
#' @param add_cran_download_total Add the number of CRAN downloads total
#' \link[badger]{badge_cran_download}.
#' 
#' @param as_list Return the header as a named list (\code{TRUE}), 
#' or a collapsed text string (default: \code{FALSE}).
#' @param sep Character to separate each item in the list with 
#' using \link[base]{paste}.
#' @param branch Name of the GitHub repository branch to use.
#' @param verbose Print messages.
#' @param colors Colors to assign to each group of badges (when possible).
#' @param hex_height Height of the hex sticker in pixels
#' (when \code{add_hex=TRUE}). 
#' @inheritParams badger::badge_github_actions
#' 
#' @export
#' @import badger
#' @examples
#' ## Causes issues bc examples can't find the  the DESCRIPTION file.
#'  \dontrun{
#'  rworkflows::use_badges() 
#'  }
use_badges <- function(ref = NULL,
                       add_hex = TRUE,
                       add_actions = "rworkflows",
                       add_doi = NULL, 
                       ## GitHub
                       add_github_version = TRUE,
                       add_commit = TRUE,
                       add_code_size = TRUE,
                       add_codecov = TRUE,
                       add_license = TRUE, 
                       add_authors = TRUE,
                       ## Bioc-specific
                       add_bioc_release = FALSE,
                       add_bioc_download_month = FALSE,
                       add_bioc_download_total = FALSE,
                       add_bioc_download_rank = FALSE,
                       ## CRAN-specific
                       add_cran_release = FALSE,
                       add_cran_checks = FALSE,
                       add_cran_download_month = FALSE,
                       add_cran_download_total = FALSE,
                       ## etc.
                       branch = "master", 
                       as_list = FALSE,
                       sep = "\n",
                       hex_height = 600,
                       colors = list("github"="black",
                                     "bioc"="green",
                                     "cran"="blue",
                                     "default"="blue"),
                       verbose = TRUE){
  
  h <- list() 
  #### Hex ####
  if(isTRUE(add_hex)){
    h["hex"] <- get_hex(branch = branch, 
                        hex_height = hex_height,
                        verbose = verbose)
  }
  #### GitHub ####
  if(isTRUE(add_github_version)){
    messager("Adding version.",v=verbose)
    h["version"] <- badger::badge_github_version(color = colors$github)
  }
  if(!is.null(add_actions) &&
     !isFALSE(add_actions) && 
     is.character(add_actions)){
    messager("Adding actions.",v=verbose)
    for(action in add_actions){
      h[paste0("actions_",action)] <- 
        badger::badge_github_actions(action = action)
    } 
  }
  if(isTRUE(add_commit)){
    messager("Adding commit.",v=verbose)
    h["commit"] <- badger::badge_last_commit(branch = branch)
  }
  #### Other metadata ####
  if(isTRUE(add_code_size)){
    messager("Adding code size",v=verbose)
    h["codesize"] <- badger::badge_code_size(ref = ref)
  }
  if(isTRUE(add_codecov)){
    messager("Adding codecov.",v=verbose)
    h["codecov"] <- badger::badge_codecov(branch = branch)
  }
  if(isTRUE(add_license)){
    messager("Adding license.",v=verbose)
    h["license"] <-  badger::badge_license(color = colors$default) 
  } 
  if(!is.null(add_doi)){
    messager("Adding DOI.",v=verbose)
    h["doi"] <-  badger::badge_doi(doi = add_doi,
                                   color = colors$default) 
  }  
  #### Bioc-specific badges #####  
  if(isTRUE(add_bioc_release)){
    messager("Adding Bioconductor release version.",v=verbose)
    h["bioc_release"] <-  badger::badge_bioc_release(color = colors$bioc)
  }  
  if(isTRUE(add_bioc_download_month)){
    messager("Adding Bioc downloads: by month",v=verbose)
    h["bioc_download_month"] <-  badger::badge_bioc_download(
      by = "month",
      color = colors$bioc) 
  }  
  if(isTRUE(add_bioc_download_total)){
    messager("Adding Bioc downloads: by total",v=verbose)
    h["bioc_download_total"] <-  badger::badge_bioc_download(
      by = "total",
      color = colors$bioc) 
  }  
  if(isTRUE(add_bioc_download_rank)){
    messager("Adding license.",v=verbose)
    h["bioc_download_rank"] <-  badger::badge_bioc_download_rank() 
  }   
  #### CRAN-specific badges #####
  if(isTRUE(add_cran_release)){
    messager("Adding CRAN release version.",v=verbose)
    h["cran_release"] <- badger::badge_cran_release(color = colors$cran) 
  } 
  if(isTRUE(add_cran_checks)){
    messager("Adding CRAN checks.",v=verbose)
    h["cran_checks"] <- badger::badge_cran_checks() 
  } 
  if(isTRUE(add_cran_download_month)){
    messager("Adding CRAN downloads: last-month",v=verbose)
    h["cran_download_month"] <-  badger::badge_cran_download(
      type = "last-month", 
      color = colors$cran) 
  } 
  if(isTRUE(add_cran_download_total)){
    messager("Adding CRAN downloads: grand-total",v=verbose)
    h["cran_download_total"] <-  badger::badge_cran_download(
      type = "grand-total",
      color = colors$cran) 
  }  
  #### Authors ####
  if(isTRUE(add_authors)){
    messager("Adding authors.",v=verbose)
    h["authors"] <- get_authors(add_html = TRUE)
  }
  #### Return ####
  if(isTRUE(as_list)){
    return(h)
  } else {
    #### Add a break after the first item (usually hex sticker) ####
    hc <- paste(paste0(h[1],"<br><br>"),
                paste(h[-1],collapse=sep), 
                sep=sep) 
    cat(hc)
    return(hc)
  }
}
