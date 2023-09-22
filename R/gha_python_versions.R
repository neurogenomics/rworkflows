#' GitHub Actions python versions
#' 
#' Retrieve all python versions available for GitHub Actions runners.
#' @inheritParams construct_runners
#' @returns Yaml with info for all versions of python,
#'  or a character string of one or more versions of python.
#'  
#' @keywords internal
#' @importFrom tools R_user_dir
#' @importFrom utils download.file
gha_python_versions <- function(
    python_version=NULL,
    ## versions_explicit must be TRUE for setup-miniconda to recognize it
    versions_explicit=TRUE,
    cache_dir=tools::R_user_dir(package = "rworkflows",
                                which = "cache"),
    verbose=TRUE){
  # devoptera::args2vars(gha_python_versions)
  
  #### Download versions path ####
  versions_url <- paste0(
    "https://raw.githubusercontent.com/actions/python-versions/",
    "main/versions-manifest.json")
  versions_path <- file.path(cache_dir,basename(versions_url))
  if(!file.exists(versions_path)){
    messager("Downloding python versions json.", v=verbose)
    dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
    utils::download.file(url = versions_url, destfile = versions_path)
  }
  ### Read yaml ####
  messager("Reading yaml.", v=verbose)
  yml <- yaml::read_yaml(versions_path)
  #### Check python_version ####
  if(!is.null(python_version)){
    messager("Validating python_version.",v=verbose)
    python_version <- as.character(python_version) 
    #### Get all versions (minor and major) ####
    versions <- sapply(yml, function(x){x$version}) 
    versions_major <- unique(sapply(strsplit(versions,'\\.'),
                                    function(x)paste(x[1],x[2],sep="."))
                             )
    versions_x <- unique(sapply(strsplit(versions,'\\.'),
                                function(x)paste(x[1],"x",sep="."))
    )
    versions_opts <- c(versions,versions_major,versions_x)
    #### Get devel version ####
    if(python_version %in% c("devel","dev")){
      if(isTRUE(versions_explicit)){
        python_version <- versions[sapply(yml, function(x){x$stable==FALSE})][1]
      } else {
        python_version <- "devel"
      } 
    #### Get release version ####
    } else if (python_version %in% c("latest","release")){
      if(isTRUE(versions_explicit)){
        python_version <- versions[sapply(yml, function(x){x$stable==TRUE})][1]
      } else {
        python_version <- "latest"
      }
    #### Get specific version ####
    } else if(python_version=="3"){
      python_version <- "3.x"
    }else {
      if(!python_version %in% versions_opts){
        stopper(paste0("python_version=",shQuote(python_version),
                       "is not available.",
                       "Must be one of:",
                       paste("\n - ",shQuote(versions_opts),collapse = "")))
      }  
    } 
    return(python_version)
  #### Or return entire yaml with all version info ####
  } else {
    return(yml)
  } 
}