#' Get authors
#' 
#' Get author names from the an R package DESCRIPTION file.
#' @param add_html Add HTML styling to certain fields (e.g "authors").
#' @inheritParams badger::badge_last_commit
#' @returns Authors as a raw text or HTML string.
#' 
#' @keywords internal
#' @importFrom desc desc_fields desc_get_field
get_authors <- function(ref=NULL,
                        add_html=FALSE){
  
  d <- get_description(refs = ref[1])[[1]] 
  if(is.null(d)) return(NULL)
  field <- grep("Authors",d$fields(),value = TRUE)[[1]] 
  if(length(field)>0){
   authors <- d$get_field(field)
   auths <- eval(parse(text = gsub('person','c',authors)));
   authors <- paste(auths[names(auths)=='given'],
                    auths[names(auths)=='family'], collapse = ', ')
   if(isTRUE(add_html)){
     return(paste0("<h4>Authors: <i>",authors,"</i></h4>"))
   } else {
     return(authors)
   }
  } else {
    return(NULL)
  } 
}