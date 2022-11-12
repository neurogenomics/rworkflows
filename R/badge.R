#' Create a badge
#' 
#' Create a badge showing the status of your R package in 
#' the \code{rworkflows} GitHub action.
#' Uses the package 
#' \href{https://github.com/GuangchuangYu/badger}{\pkg{badger}}.
#' @inheritParams badger::badge_github_actions
#' 
#' @export
#' @examples
#' ## Causes issues bc examples can't find the  the DESCRIPTION file.
#'  \dontrun{
#'  badger::badge_github_actions() 
#'  }
badge <- function(ref=NULL){
  requireNamespace("badger")
  badger::badge_github_actions(ref = ref, 
                               action = 'rworkflows')
}
