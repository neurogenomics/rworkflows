conda_installed <- function(verbose = FALSE){
  # if(is_gha()){
  #   if(Sys.getenv("CONDA")!=""){
  #     messager("Using CONDA=",Sys.getenv("CONDA"), v=verbose)
  #     return(TRUE)
  #   } else if(Sys.getenv("CONDA_EXE")!=""){
  #     messager("Using CONDA_EXE=",Sys.getenv("CONDA_EXE"), v=verbose)
  #     return(TRUE)
  #   } else {
  #     messager("CONDA not found.", v=verbose)
  #     return(FALSE)
  #   }
  #   # reticulate::use_miniconda(conda=Sys.getenv("CONDA_EXE"))
  # } else {
    requireNamespace("reticulate")
    utils::getFromNamespace("conda_installed","reticulate")()
  # }
}