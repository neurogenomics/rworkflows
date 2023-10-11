conda_installed <- function(){
  requireNamespace("reticulate")
  utils::getFromNamespace("conda_installed","reticulate")()
}