#' Get GitHub URL: from database
#' 
#' Extract the GitHub URLs from a tabular database of
#'  \emph{DESCRIPTION} file data.
#' @param db Database.
#' @param return_dt Return data.table format.
#' @returns data.table or list
#' 
#' @keywords internal
#' @importFrom data.table :=
get_github_url_db <- function(db,
                              return_dt=FALSE){
  url_github <- NULL;
  ## These fields sometimes contain >1 link.
  ## Find the one that's actually for the GitHub repo.
  if(is.null(db)) return (db)
  get_gh <- function(db,
                     col){
    db[, url_github := lapply(
      strsplit(get(col), ","),
      function(x){
        if(all(is.na(x))){
          return(NA)
        } else {
          hits <- grep(".*http[s]?://github.com/(([^/]+)/([^/]+)).*", x, 
                       value = TRUE)[1]
          if(length(hits)==0) {
            return(NA)
          } else{
            hits |>
              gsub(pattern="/issues$",replacement="") |> 
              trimws() |>
              trimws(whitespace="\n")
          } 
        }
      }
    )|>unlist()]   
  }
  #### Parse ####
  cols <- c("URL","BugReports","git_url")
  cols <- cols[cols %in% names(db)][1]
  get_gh(db,cols) 
  if(isTRUE(return_dt)){
    return(db)
  }else{
    return(db$url_github) 
  }
}
