get_description_check <- function(dl){
  ### Make sure it gets a name ####
  if(is.null(dl)) return(NULL)
  for(i in seq_len(length(dl))){
    if(is.null(names(dl[i])) && 
       methods::is(dl[[i]],"description") ){
      names(dl)[i] <- dl[[i]]$get_field("Package")
    }
  } 
  return(dl)
}