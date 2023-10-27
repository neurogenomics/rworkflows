condaenv_exists <- function(...){
  if(is_gha()){
    Sys.getenv("CONDA")!=""
  } else {
    requireNamespace("reticulate")
    utils::getFromNamespace("condaenv_exists","reticulate")(...) 
  }
}
