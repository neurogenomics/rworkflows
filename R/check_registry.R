#' @title Check registry
#' 
#' @description Check that the registry is valid.
#' @param registry A character vector of registry names.
#' @returns A single registry name.
#' 
#' @keywords internal
check_registry <- function(registry){
  
  if(!is.null(registry)){
    registry <- registry[1]
    if(!grepl("/$",registry)){
      registry <- paste0(registry,"/")
    }
    return(registry)
  } else {
    return(NULL)
  }
}