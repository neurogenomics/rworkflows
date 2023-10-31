conda_path <- function(){
  ## Use sys var
  conda <- Sys.getenv("CONDA")
  if(file.exists(conda)){
    options(reticulate.conda_binary = conda)
    return(conda)
  } 
  ## Use reticulate
  conda <- reticulate::conda_binary()  
  if(file.exists(conda)){
    return(conda)
  } else {
    stop("Unable to find conda binary. Please set reticulate.conda_binary")
  }
}