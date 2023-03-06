parse_version <- function(v,
                          depth = NULL,
                          as_package_version = TRUE){
  # v="4.2.0"
  if(is.null(depth)) return(v)
  if(depth<1) stop("depth must be >0.")
  splt <- strsplit(as.character(v),"[.]")[[1]]
  #### Add extra 0s is greater depth than exists is requested ####
  if(length(splt)<depth) splt <- c(splt,rep("0",depth-length(splt)))
  #### Paste back together ####
  v2 <- paste(splt[seq_len(min(length(splt),depth))],collapse = ".")
  #### Convert to package_version obj (if possible) #####
  if(isTRUE(as_package_version)){
    if(is.null(depth) || depth>1){
      return(package_version(v2)) 
    } else {
      return(v2)
    }
  } else {
    return(v2)
  }
}