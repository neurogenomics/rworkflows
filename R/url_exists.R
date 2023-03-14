url_exists <- function(url_in,
                       t=2){
  sapply(url_in, function(x){
    con <- url(x)
    check <- suppressWarnings(try(open.connection(con,open="rt",
                                                  timeout=t),
                                  silent=TRUE)[1])
    suppressWarnings(try(close.connection(con),silent=TRUE))
    ifelse(is.null(check),TRUE,FALSE)
  })
}