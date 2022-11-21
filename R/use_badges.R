#' Use badges
#' 
#' Create one or more badges showing the status of your R package.
#' Uses the package 
#' \href{https://github.com/GuangchuangYu/badger}{\pkg{badger}}.
#' @param add_version Add package version with 
#' \link[badger]{badge_github_version}.
#' @param add_actions Add GitHub Actions status with
#' \link[badger]{badge_github_actions}.
#' @param add_commit Add the last GitHub repo commit date with
#' \link[badger]{badge_last_commit}.
#' @param add_codecov Add CodeCov status with
#' \link[badger]{badge_codecov}.
#' @param add_license Add license info with
#' \link[badger]{badge_license}.
#' @param add_authors Add author names inferred from 
#' the \code{DESCRIPTION} file.
#' @param as_list Return the header as a named list (\code{TRUE}), 
#' or a collapsed text string (default: \code{FALSE}).
#' @param sep Character to separate each item in the list with 
#' using \link[base]{paste}.
#' @param action GitHub Actions workflow to create status badge for.
#' @param branch Name of the GitHub repository branch to use.
#' @param verbose Print messages.
#' @inheritParams badger::badge_github_actions
#' 
#' @export
#' @examples
#' ## Causes issues bc examples can't find the  the DESCRIPTION file.
#'  \dontrun{
#'  rworkflows::use_badges() 
#'  }
use_badges <- function(ref = NULL,
                       add_version = TRUE,
                       add_actions = TRUE,
                       add_commit = TRUE,
                       add_codecov = TRUE,
                       add_license = TRUE,
                       add_authors = TRUE,
                       action = "rworkflows",
                       branch = "master", 
                       as_list = FALSE,
                       sep = "\n",
                       verbose = TRUE){
  
  requireNamespace("badger")
  
  h <- list() 
  if(isTRUE(add_version)){
    messager("Adding version.",v=verbose)
    h["version"] <- badger::badge_github_version(color = 'black')
  }
  if(isTRUE(add_actions)){
    messager("Adding actions.",v=verbose)
    h["version"] <- badger::badge_github_actions(action = action)
  }
  if(isTRUE(add_commit)){
    messager("Adding commit.",v=verbose)
    h["commit"] <- badger::badge_last_commit(branch = branch)
  }
  if(isTRUE(add_codecov)){
    messager("Adding codecov.",v=verbose)
    h["codecov"] <- badger::badge_codecov(branch = branch)
  }
  if(isTRUE(add_license)){
    messager("Adding license.",v=verbose)
    h["license"] <-  badger::badge_license() 
  } 
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
