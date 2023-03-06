#' Infer biocViews
#' 
#' Infer the best terms to fill the \code{biocViews} field in
#'  your \emph{DESCRIPTION} file based on the code within your R package.
#' Please see the 
#' \href{https://www.bioconductor.org/packages/release/BiocViews}{
#' Bioconductor website} for more details.
#' @param type Which element of the \link[biocViews]{recommendBiocViews} 
#' results list to return.
#' If a vector is supplied, only the first value will be used.
#' @param include_branch Whether to include the \code{branch} argument as one 
#' of the returned \code{biocViews}.
#' @param biocviews User-supplied \code{biocViews} terms to include in
#' addition to the automated recommendations. 
#' @param verbose Print messages.
#' @inheritParams biocViews::recommendBiocViews
#' 
#' @export
#' @importFrom biocViews recommendBiocViews
#' @importFrom here here
#' @examples 
#' ## Don't run simply bc biocViews::recommendBiocViews is unable 
#' ## to find the DESCRIPTION file when running examples.
#' \dontrun{
#' biocviews <- infer_biocviews()
#' }
infer_biocviews <- function(pkgdir=here::here(),
                            branch = c("Software", 
                                       "AnnotationData", 
                                       "ExperimentData")[1],
                            type = c("recommended",
                                     "current",
                                     "remove"),
                            include_branch = TRUE,
                            biocviews = NULL,
                            verbose = TRUE){
  # templateR:::args2vars(infer_biocviews)
  branch <- branch[1]
  type <- type[1]
  
  #### Check args ####
  ## branch_opts
  branch_opts <- eval(formals(biocViews::recommendBiocViews)$branch)
  if(!branch %in% branch_opts){
    stp1 <- paste("branch must be one of:",
                  paste("\n -",shQuote(branch_opts),collapse = ""))
    stop(stp1)
  }
  ## type_opts
  type_opts <- eval(formals(infer_biocviews)$type)
  if(!type %in% type_opts){
    stp2 <- paste("type must be one of:",
                  paste("\n -",shQuote(type_opts),collapse = ""))
    stop(stp2)
  } 
  #### Infer biocViews ####
  messager("Inferring biocViews.",v=verbose)
  bioc_recc <- biocViews::recommendBiocViews(
    pkgdir = pkgdir,
    branch = branch
  )
  out <- unique(c(biocviews,bioc_recc[[type]]))
  out <- out[out!=""]
  #### Add the name of the branch itself ####
  if(isTRUE(include_branch)){
    out <- unique(c(branch,out))
  }
  #### Report ####
  if(length(out)==0) {
    messager("0 biocViews inferred. Returning NULL.",v=verbose)
    return(NULL)
  } else {
    messager(length(out),"biocViews inferred:",
             paste("\n -",out,collapse = ""),
             v=verbose)
    return(out)
  }
}
