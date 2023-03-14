#' Construct authors
#' 
#' Helper function to construct an author list for a \emph{DESCRIPTION} file.
#' Returns a template when \code{authors} is not provided (default).
#' @param template Default value to return when \code{authors=NULL}.
#' @inheritParams fill_description
#' @returns Named list in \link[utils]{person} format.
#' 
#' @export
#' @importFrom utils person
#' @examples 
#' authors <- construct_authors()
construct_authors <- function(authors=NULL,
                              template=c( 
  utils::person(
    given = "yourGivenName",
    family = "yourFamilyName",
    role = c("cre"),
    email = "yourEmail@email.com",
    comment = c(ORCID = "yourOrcidId"))
  )
){
  if(is.null(authors)){
    return(template)
  } else {
    return(authors)
  }
}