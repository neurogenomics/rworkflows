check_r_version <- function(r){
  
  opts <- unname(unlist(bioc_r_versions()$r_ver_for_bioc_ver))
  opts <- c('auto','devel','release',opts)
  r <- tolower(as.character(r))
  if(r %in% c("release_*",
              "release*",
              "release")){
    r <- "release"
  } 
  if(!r %in% opts){
    stopper(paste0("r=",shQuote(r)),
            "r version must be one of:",
            paste("\n -",shQuote(opts),
                  collapse = ""))
  } else {
    return(r)
  }
}