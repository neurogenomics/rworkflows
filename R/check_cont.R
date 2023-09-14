#' Check containers exist
#' 
#' Check that a list of containers are valid.
#' @inheritParams construct_runners
#' @param domain Container repository API domain.
#' @returns NUll
#' 
#' @keywords internal
check_cont <- function(cont,
                       domain = "https://hub.docker.com/v2/repositories/",
                       verbose = TRUE){
  
  requireNamespace("jsonlite")
  for(co in cont){
    if(is.null(co)) next()
    if(isFALSE(grepl("/",co))){
      stopper("Container must be specificied in the following format:",
              "'owner/repo:tag'")
    } 
    splt <- strsplit(co,":")[[1]]
    URL <- paste(domain, splt[1],
                 "tags?page_size=1000",sep="/"
    ) 
    #### Check repo exists ####
    messager("Checking public container repository exists:",shQuote(splt[1]),
             v=verbose)
    js <- tryCatch({
      jsonlite::read_json(URL)
    }, error=function(e){
      stopper("Unable to find public container:",co)
    }
    ) 
    #### Check tag exists #### 
    if(length(splt)==2){
      messager("Checking tag exists:",shQuote(splt[2]),
               v=verbose) 
      tags <- sapply(js$results ,function(x){x$name}) 
      if(!splt[2] %in% tags){
        stopper("The tag", shQuote(splt[2]),
                "does not exist in the repo",shQuote(splt[1]))
      }
    }
  }
}
