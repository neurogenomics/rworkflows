url_exists <- function(url_in,
                       t=2){
  con <- url(url_in)
  check <- suppressWarnings(try(open.connection(con,open="rt",
                                                timeout=t),
                                silent=TRUE)[1])
  suppressWarnings(try(close.connection(con),silent=T))
  ifelse(is.null(check),TRUE,FALSE)
}