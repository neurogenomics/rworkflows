check_cont_dockerhub <- function(cont,
                                 domain = 
                                   "https://hub.docker.com/v2/repositories/",
                                 verbose = TRUE){
  requireNamespace("jsonlite")
  for(co in cont){
    if(is.null(co)) next()
    co <- gsub("docker\\.io/","",co) 
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
    }) 
    #### Check tag exists #### 
    tags <- sapply(js$results ,function(x){x$name}) 
    check_tags(tags = tags, 
               splt = splt,
               verbose = verbose)
  }
}