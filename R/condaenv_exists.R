condaenv_exists <- function(...){
  requireNamespace("reticulate")
 utils::getFromNamespace("condaenv_exists","reticulate")(...) 
}
