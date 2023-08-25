check_paths <- function(refs,
                        paths,
                        verbose=TRUE){
  if(!is.null(refs)){
    if(length((paths))!=length(refs)){
      messager("When refs is provided, paths must have the same length",
               "(or be set to NULL).","Setting paths=NULL.",v=verbose)
      paths <- list(NULL)
    }
  }
  return(paths)
}