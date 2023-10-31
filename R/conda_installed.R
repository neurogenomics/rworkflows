conda_installed <- function(){
  if(is_gha()){
    if(Sys.getenv("CONDA")!=""){
      message("Using CONDA=",Sys.getenv("CONDA"))
      return(TRUE)
    } else if(Sys.getenv("CONDA_EXE")!=""){
      message("Using CONDA_EXE=",Sys.getenv("CONDA_EXE"))
      return(TRUE)
    } else {
      message("CONDA not found.")
      return(FALSE)
    }
    # reticulate::use_miniconda(conda=Sys.getenv("CONDA_EXE"))
  } else {
    requireNamespace("reticulate")
    utils::getFromNamespace("conda_installed","reticulate")()
  }
}