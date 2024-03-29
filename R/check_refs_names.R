check_refs_names <- function(dl){
  ### Make sure it gets a name ####
  if(is.null(unlist(dl))) return(NULL)
  for(i in seq(length(dl))){
    nm <- names(dl[i])
    if(is.null(nm) || nm=="NULL"){
      if(methods::is(dl[[i]],"description")){
        names(dl)[i] <- dl[[i]]$get_field("Package")  
      } else if(is.character(dl[[i]])){
        names(dl)[i] <- dl[[i]]
      } 
    } 
    # else if(!is.null(names(dl[i])) && !is.null(dl[[i]]) &&
    #           basename(names(dl[i]))!=dl[[i]]$get_field("Package")){
    #   messager(
    #     "Mismatch between requested package and package name in DESCRIPTION.",
    #     "Setting entry to NULL.",v=verbose)
    #   dl[[i]] <- NULL
    # }
  } 
  return(dl)
}
