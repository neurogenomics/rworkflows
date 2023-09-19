gha_python_versions <- function(python_version=NULL){
  yml <- yaml::read_yaml(paste0(
    "https://raw.githubusercontent.com/actions/python-versions/",
    "main/versions-manifest.json")
    )
  
  if(!is.null(python_version)){
    python_version <- as.character(python_version[1]) 
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
      python_version <- versions[sapply(yml, function(x){x$stable==FALSE})][1]
    #### Get release version ####
    } else if (python_version %in% c("latest","release")){
      python_version <- versions[sapply(yml, function(x){x$stable==TRUE})][1]
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
  } else {
    return(yml)
  } 
}