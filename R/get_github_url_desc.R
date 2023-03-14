get_github_url_desc <- function(desc_file){
  ## These fields sometimes contain >1 link.
  ## Find the one that's actually for the GitHub repo.
  if(is.null(desc_file)) return (desc_file)
  get_gh <- function(URL){
    urls <- trimws(strsplit(URL,",")[[1]])
    (
      grep("https://github.com", urls, value = TRUE)[1] |>
        strsplit("#")
    )[[1]][1]
  }
  #### Parse ####
  if(desc_file$has_fields("URL")){ 
    return(get_gh(desc_file$get_field("URL")))
  } else if (desc_file$has_fields("BugReports")){
    return(
      trimws(gsub("issues$","",get_gh(desc_file$get_field("BugReports"))),
             whitespace = "/") 
    )
  } else if (desc_file$has_fields("git_url")){
    return(
      paste("https://github.com",
            strsplit(desc_file$get_field("git_url"),"[.]")[[1]][[2]],
            basename(desc_file$get_field("git_url")),sep="/")
    ) 
  } else {
    return(NULL)
  }
}
