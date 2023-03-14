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
#' hex_url <- get_hex(refs=c("neurogenomics/rworkflows",
#'                           "neurogenomics/echolocatoR"))
get_hex <- function(refs=NULL,
                    paths=here::here("DESCRIPTION"),
                    hex_path="inst/hex/hex.png",
                    branch=c("master","main","dev"),
                    hex_height=300,
                    check_url=TRUE,
                    add_html=TRUE,
                    verbose=TRUE){
  # devoptera::args2vars(get_hex)
  
  if(!is.null(refs)) {
    messager("Finding hex sticker(s) for",
             formatC(length(refs),big.mark = ","),"package(s).",v=verbose)
  }
  if(!is.null(refs)){
    if(length((paths))!=length(refs)){
      messager("When refs is provided, paths must have the same length",
               "(or be set to NULL).","Setting paths=NULL.",v=verbose)
      paths <- NULL
    }
  }
  if(isTRUE(hex_path)){
    hex_path <- "inst/hex/hex.png"
  } 
  dl <- get_description(refs = refs,
                        paths = paths)
  #### Iterate over refs ####
  hexes <- lapply(stats::setNames(seq_len(length(dl)),
                                  names(dl)),
                  function(i){
    d <- dl[[i]]
    ref <- refs[[i]]
    if(!is.null(d)){
      pkg <- d$get_field("Package")
      URL <- get_github_url_desc(desc_file = d)
    } else {
      URL <- NULL
    } 
    #### Make a guess as a last resort ####
    if(is.null(URL) && 
       !is.null(ref) &&
       ## Check if ref contains both owner/repo
       length(strsplit(ref,"/")[[1]])>1){ 
      URL <- paste0("https://github.com/", ref)
    } else if(is.null(URL)){
      messager("Cannot find hex URL domain name. Returning NULL.",
               v=verbose)
      return(NULL)
    }
    hex_url_opts <- paste(URL,"raw",branch,hex_path,sep="/")
    if(isTRUE(check_url)){
      hex_url <- NULL
      for(h in hex_url_opts){
        if(url_exists(h)){
          hex_url <- h
          break()
        }
      } 
    } else {
      hex_url <- hex_url_opts
    }
    #### Check that the file exists ####
    if(is.null(hex_url)){
      messager("Hex URL does not exist (or is not public).",
               "Returning NULL.",v=verbose)
      return(NULL) 
    }
    #### Add HTML ####
    if(isTRUE(add_html)){
      img <- paste0("<img src=",shQuote(hex_url),
                    " title=",shQuote(paste("Hex sticker for",pkg)),
                    " height=",shQuote(hex_height),">")
      return(img)
    } else {
      return(hex_url)
    }
  })
  if(length(hexes)==0) {
    return(NULL)
  } else {
    return(hexes)
  }
 
}
