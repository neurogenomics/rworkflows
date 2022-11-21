get_hex <- function(branch,
                    hex_height){
  
  if("URL" %in% desc:::desc_fields()){
    URL <- desc::desc_get_field(key = "URL")
  } else {
    wrn <- "URL key not found in DESCRIPTION file."
    warning(wrn)
  }
  hex_url <- paste(URL,"raw",branch,"inst/hex/hex.png",sep="/")
  img <- paste("<img src=",shQuote(hex_url),
               "height=",shQuote(hex_height),"><br><br>")
  return(img)
}