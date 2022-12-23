construct_runners_check_cont <- function(cont,
                                         versions_explicit){
  lapply(stats::setNames(names(cont),
                         names(cont)
  ),function(n){
    co <- cont[[n]]
    if(is.null(co)){
      return(NULL)
    } else if(!grepl(":",co) |
              !grepl("bioconductor/bioconductor_docker",co)) {
      return(co)
    } 
    splt <- strsplit(co,":")[[1]]
    bioc_version <- rev(splt)[[1]]  
    if(isTRUE(versions_explicit)){
      if(grepl(":",co)){
        info <- bioc_r_versions(bioc_version = bioc_version)
        return(
          paste0(splt[[1]],":RELEASE_",gsub("[.]","_",info$bioc))
        )
      } else {
        return(co)
      }
    } else if(tolower(bioc_version)=="release"){
        co <- gsub(":release",":latest",co) 
    } 
    return(co)    
  })  
}
