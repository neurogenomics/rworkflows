conda_installed <- function(){
  if(is_gha()){
    Sys.getenv("CONDA")!="" | Sys.getenv("CONDA_EXE")!=""
    # reticulate::use_miniconda(conda=Sys.getenv("CONDA_EXE"))
  } else {
    requireNamespace("reticulate")
    utils::getFromNamespace("conda_installed","reticulate")()
  }
}