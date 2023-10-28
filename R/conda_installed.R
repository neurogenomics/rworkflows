conda_installed <- function(){
  if(is_gha()){
    Sys.getenv("CONDA")!=""
  } else {
    requireNamespace("reticulate")
    utils::getFromNamespace("conda_installed","reticulate")()
  }
}