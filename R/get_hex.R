get_hex <- function(ref=NULL,
                    branch="master",
                    hex_height=300,
                    check_url=TRUE,
                    add_html=TRUE,
                    verbose=TRUE){
  
  
  if(is.null(ref)){
    wrn <- "URL key not found in DESCRIPTION file."
    if("URL" %in% desc::desc_fields()){
      URL <- desc::desc_get_field(key = "URL")
      URL <- grep("git",strsplit(URL,",")[[1]],value = TRUE)
      if(length(URL)==0) {
        warning(wrn)
        return(NULL)
      }
    } else {
      warning(wrn)
      return(NULL)
    }
  } else {
    URL <- paste0("https://github.com/", ref)
  } 
  hex_url <- paste(URL,"raw",branch,"inst/hex/hex.png",sep="/")
  #### Check that the file exists ####
  if(isTRUE(check_url) && 
     !url_exists(hex_url)){
    messager("Hex URL does not exist. Returning NULL.",v=verbose)
    return(NULL) 
  }
  #### Add HTML ####
  if(isTRUE(add_html)){
    img <- paste("<img src=",shQuote(hex_url),
                 "height=",shQuote(hex_height),"><br><br>")
    return(img)
  } else {
    return(hex_url)
  }
}
