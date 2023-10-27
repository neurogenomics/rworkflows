get_github_url_desc <- function(desc_file){
  ## These fields sometimes contain >1 link.
  ## Find the one that's actually for the GitHub repo.
  if(is.null(desc_file)) return (desc_file)
  check_gh_url <- function(URL){
    if(sum(grepl("https://github.com",URL))==0) {
      return(NULL)
    } else {
      return(URL)
    }
  }
  get_gh <- function(URL){
    urls <- trimws(strsplit(URL,",")[[1]])
    (
      grep("https://github.com", urls, value = TRUE)[1] |>
        strsplit("#") |>
        gsub(pattern="issues$",replacement="") |>
        trimws(whitespace = "/")
    )[[1]][1] |>
      check_gh_url()
  }
  #### Parse ####
  ## From URL field
  if(desc_file$has_fields("URL")){ 
    gh_url <- get_gh(desc_file$get_field("URL"))
    if(!is.null(gh_url)) return(gh_url)
  } 
  ## From BugReports field
  if (desc_file$has_fields("BugReports")){
    gh_url <- get_gh(desc_file$get_field("BugReports"))
    if(!is.null(gh_url)) return(gh_url)
  } 
  ## From git_url field
  if (desc_file$has_fields("git_url")){
    gh_url <- paste("https://github.com",
                    strsplit(desc_file$get_field("git_url"),"[.]")[[1]][[2]],
                    basename(desc_file$get_field("git_url")),sep="/")
    gh_url <- check_gh_url(gh_url)
    if(!is.null(gh_url)) return(gh_url)
  } else {
    return(NULL)
  }
}
