#' Is GitHub Action
#' 
#' Tests whether a function is currently being run within a GitHub Actions 
#' workflow or not.
#' @source \href{https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables}{
#' GitHub Actions docs}
#' @param var Environmental variable to check.
#' @param verbose Print messages.
#' 
#' @export
#' @examples 
#' is_gha()
is_gha <- function(var="GITHUB_ACTION",
                   verbose=TRUE){
  gha <- Sys.getenv(var)
  if(gha!=""){
    messager("Currently running on GITHUB_ACTION:",
             paste(gha,collapse = ","),v=verbose)
    return(TRUE)
  } else {
    return(FALSE)
  }
}