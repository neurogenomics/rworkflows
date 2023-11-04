#' Construct containers list
#' 
#' @param run_check_cont Check whether the requested container repo 
#' (and the tag, if specified) exist using \link[rworkflows]{check_cont}.
#' @param default_registry The default container registry to use.
#' Options include:
#' \describe{
#'  \item{"ghcr.io/" : }{\href{https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry}{GitHub Container Registry}}
#'  \item{"docker.io/" : }{\href{https://hub.docker.com/}{DockerHub}}
#'  \item{"mcr.microsoft.com/" : }{\href{https://github.com/microsoft/ContainerRegistry}{Microsoft Container Registry}}
#' }
#' @param default_cont The DockerHub container to default to.
#' Used when it's detected that only the tag has been given in one or more 
#' \code{cont} entry. 
#' @param default_tag The DockerHub container tag to default to.
#' @inheritParams construct_runners
#' @returns Named list of containers
#' 
#' @export
#' @importFrom stats setNames
#' @examples
#' cont <- construct_cont() 
construct_cont <- function(default_registry = c("ghcr.io/",
                                                "docker.io/",
                                                "mcr.microsoft.com/"),
                           default_cont = "bioconductor/bioconductor_docker",
                           default_tag = "devel",
                           cont = list(
                             paste(default_cont,default_tag,sep=":"),
                             NULL,
                             NULL),
                           versions_explicit = FALSE, 
                           run_check_cont = FALSE,
                           verbose = TRUE){
  # devoptera::args2vars(construct_cont)
  
  default_registry <- check_registry(registry = default_registry)
  #### Remove any trailing : (e.g. when default_tag=NULL) ####
  cont <- lapply(cont, function(x){
    if(is.null(x)) NULL else trimws(x,whitespace = ":")
  })
  #### Run QC ####
  cont2 <- lapply(cont,function(co){ 
    if(is.null(co)){
      return(NULL)
    } else if(!grepl("/",co) &&
              !is.null(default_cont)){
      messager("Only tag name supplied to 'cont'.",
               "Assuming default=",shQuote(default_cont),v=verbose)
      co <- paste(default_cont,co,sep=":")
    } else if(!grepl(":",co) |
              !grepl(default_cont,co)) {
      return(co)
    }  
    splt <- strsplit(co,":")[[1]]
    bioc_version <- rev(splt)[1]  
    if(isTRUE(versions_explicit)){
      if(grepl(":",co)){
        info <- bioc_r_versions(bioc_version = bioc_version)
        return(
          paste0(splt[[1]],":RELEASE_",gsub("[.]","_",info$bioc))
        )
      } else {
        return(co)
      }
    } else if(tolower(bioc_version)=="release"){
        co <- gsub(":release",":latest",co, ignore.case = TRUE) 
    } 
    return(co)    
  })
  #### Add registry ####
  if(!is.null(default_registry)){
    opts <- eval(formals(construct_cont)$default_registry)
    cont2 <- lapply(cont2, function(co){
      if(is.null(co)){
        return(NULL)
      } else if(!grepl(paste(paste0("^",opts),collapse = "|"),co)){
        return(paste0(default_registry,co))
      } else {
        return(co)
      }
    })
  } 
  #### Check that the Dockerhub repo exists ####
  if(isTRUE(run_check_cont)){
    check_cont(cont = cont2, 
               verbose = verbose)
  }   
  #### Return ####
  return(cont2)
}
