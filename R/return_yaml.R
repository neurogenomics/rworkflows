return_yaml <- function(yml,
                        path,
                        return_path,
                        handlers=NULL,
                        verbose=TRUE, 
                        ...){
  if(!is.null(path)){  
    save_yaml(yml=yml,
              path=path,
              handlers=handlers,
              verbose=verbose,
              ...)
    #### Return ####
    if(isTRUE(return_path)){
      return(path)
    } else {
      yml <- yaml::read_yaml(path)
      return(yml)
    }
  } else {
    return(yml)
  }
}