check_bioc_version <- function(bioc){
  
  opts <- bioc_r_versions(return_opts = TRUE)
  bioc <- tolower(as.character(bioc))
  if(bioc %in% c("release_*",
                 "release*",
                 "release")){
    bioc <- "release"
  } else {
    bioc <- gsub("_",".",gsub("RELEASE_","",bioc, ignore.case = TRUE))
  } 
  if(!bioc %in% opts){
    stopper(paste0("bioc=",shQuote(bioc)),
            "bioc version must be one of:",
            paste("\n -",shQuote(opts),collapse = ""))
  } else {
    return(bioc)
  }
}