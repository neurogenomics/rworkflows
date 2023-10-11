check_cont_ghcr <- function(cont,
                            verbose = TRUE){
  requireNamespace("rvest")
  
  for(co in cont){
    if(is.null(co)) next()
    # co <- "ghcr.io/bioconductor/bioconductor_docker:devel" 
    co_notag <- gsub("ghcr.io/","",strsplit(co,":")[[1]][1])
    ##### Only works if you have permissions to the repo #####
    # get_ghcr_tags <- function(container) {
    #   url <- paste0("https://ghcr.io/v2/", container, "/tags/list")
    #   response <- jsonlite::fromJSON(url)
    #   tags <- response$tags
    #   return(tags)
    # }
    # tags <- get_ghcr_tags("bioconductor/bioconductor_docker")
    #
    URL <- paste0(
      "https://github.com/",
      co_notag,
      "/pkgs/container/",basename(co_notag),
      "/versions?filters%5Bversion_type%5D=tagged"
    )
    #### Check if container exists ####
    x <- tryCatch({
      rvest::read_html(URL)
    }, error=function(e){
      stopper("Unable to find public container:",co)}
    )
    #### Check if container has tags ####
    tags <- x |> rvest::html_nodes(".Label") |> rvest::html_text()
    if(length(tags)==0){
      stopper("Unable to find tags for container:",co)
    } else {
      check_tags(tags = tags, 
                 splt = strsplit(co,":")[[1]][1],
                 verbose = verbose)
    }
  } 
}