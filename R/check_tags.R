check_tags <- function(splt,
                       tags,
                       verbose=TRUE){
  if(length(splt)==2){
    messager("Checking tag exists:",shQuote(splt[2]),
             v=verbose) 
    if(!splt[2] %in% tags){
      stopper("The tag", shQuote(splt[2]),
              "does not exist in the repo",shQuote(splt[1]))
    }
  }
}