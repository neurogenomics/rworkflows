construct_runners_check_args <- function(os,
                                         bioc,
                                         r,
                                         cont,
                                         versions_explicit=FALSE,
                                         verbose=TRUE){
  
  
  #### Fill names ####
  args <- list(os=os, bioc=bioc, r=r, cont=cont)
  args2 <- lapply(stats::setNames(names(args),
                                  names(args)), 
         function(nm){
           if(nm=="os") return(args[[nm]])
           if(length(args[[nm]])==length(args$os)){
             if(is.null(names(args[[nm]]))){
               names(args[[nm]]) <- args$os
             }
             return(args[[nm]])
           } else {
             if(length(args[[nm]])==1){
               messager("Applying the same",shQuote(nm),
                        "parameter to all",length(os),"'os':",
                        shQuote(args[[nm]]),
                        v=verbose)
               stats::setNames(as.list(rep(args[[nm]],length(os))),
                               args$os)
             } else {
               stopper("The length of",shQuote(nm),
                       "must match the length of 'os' or be of length 1.")
             }
           }
         } 
  )
  #### Check names #### 
  if(!all(os %in% names(args2$bioc))){
    stp <- paste(
      "All `os` must be names of elements in `bioc_version` argument.")
    stop(stp)
  }
  if(!all(os %in% names(args2$r))){
    stp <- paste(
      "All `os` must be names of elements in `r` argument.")
    stop(stp)
  }
  if(!all(os %in% names(args2$cont))){
    stp <- paste(
      "All `os` must be names of elements in `cont` argument.")
    stop(stp)
  }
  #### Return ####
  return(args2)
}

