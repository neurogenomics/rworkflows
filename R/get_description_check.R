get_description_check <- function(dl,
                                  verbose=TRUE){
  ### Make sure it gets a name ####
  if(is.null(dl)) return(NULL)
  for(i in seq_len(length(dl))){
    if(is.null(names(dl[i])) && 
       methods::is(dl[[i]],"description") ){
      names(dl)[i] <- dl[[i]]$get_field("Package")
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