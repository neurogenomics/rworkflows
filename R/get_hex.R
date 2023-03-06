#' Get hex
#' 
#' Get the URL of a hex sticker for a given R package (if one exists).
#' @param hex_path Path to hex sticker file.
#' @param check_url Check whether the URL actually exists.
#' @param add_html Wrap the URL in an html "img" tag and
#'  set its height with \code{hex_height}.
#' @inheritParams use_badges
#' @inheritParams get_description
#' @returns URL
#' 
#' @export
#' @import desc
#' @examples 
#' hex_url <- get_hex(ref="neurogenomics/rworkflows")
get_hex <- function(ref=NULL,
                    path=here::here("DESCRIPTION"),
                    hex_path="inst/hex/hex.png",
                    branch="master",
                    hex_height=300,
                    check_url=TRUE,
                    add_html=TRUE,
                    verbose=TRUE){
  # templateR:::args2vars(get_hex)
  
  if(isTRUE(hex_path)){
    hex_path <- "inst/hex/hex.png"
  }
  pkg <- NULL;
  if(is.null(ref) ||
     ref==basename(ref)){
    wrn <- "URL key not found in DESCRIPTION file."
    d <- get_description(ref = ref,
                         path = path)
    if(is.null(d)){
      warning(wrn)
      return(NULL)
    }
    if(isTRUE(d$has_fields(keys = "URL"))){
      pkg <- d$get_field(key = "Package")
      URL <- d$get_field(key = "URL")
      URL <- grep("git",strsplit(URL,",")[[1]],value = TRUE)
      if(length(URL)==0) {
        warning(wrn)
        return(NULL)
      } else {
        ref <- gsub("https://github.com/|[/]$","",URL)
      }
    } else {
      warning(wrn)
      return(NULL)
    }
  } else {
    URL <- paste0("https://github.com/", ref)
  } 
  hex_url <- paste(URL,"raw",branch,hex_path,sep="/")
  #### Check that the file exists ####
  if(isTRUE(check_url) && 
     !url_exists(hex_url)){
    messager("Hex URL does not exist. Returning NULL.",v=verbose)
    return(NULL) 
  }
  if(is.null(pkg)) pkg <- gsub("[/]","",basename(URL))
  #### Add HTML ####
  if(isTRUE(add_html)){
    img <- paste0("<img src=",shQuote(hex_url),
                 " title=",shQuote(paste("Hex sticker for",pkg)),
                 " height=",shQuote(hex_height),">")
    return(img)
  } else {
    return(hex_url)
  }
}
