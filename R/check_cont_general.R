check_cont_general <- function(cont){
  lapply(cont, function(co){
    if(is.null(co)) return(NULL)
    if(!grepl("/",co)){
      stopper("Container must be specified in the following format:",
              "'registry/owner/repo:tag'")
    } 
    n_parts <- length(strsplit(gsub("[/]+","/",co),"/")[[1]])
    return(n_parts)
  }) 
}