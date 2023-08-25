get_description_manual <- function(refs=NULL,
                                   paths=here::here("DESCRIPTION"),
                                   cache_dir=tools::R_user_dir(
                                     package = "rworkflows",
                                     which = "cache"),
                                   force_new=FALSE,
                                   use_wd=TRUE,
                                   verbose=TRUE){
  try_desc <- function(package,
                       verbose=TRUE){
    tryCatch({
      desc::desc(package = package)
    }, error=function(e){
      messager("Cannot find DESCRIPTION for:",package,
               v=verbose); 
      NULL
    })
  } 
  iter <- max(length(refs), length(paths))
  lapply(stats::setNames(seq_len(iter),
                         refs),
         function(i){
    ref <- refs[[i]]
    path <- if(length(unlist(paths))==0) NULL else paths[[i]]
    wrn <- if(is.null(ref)){
      paste("Cannot import DESCRIPTION file:",paths)
    } else{
      paste("Cannot find DESCRIPTION file for:",ref)
    }
    
    path_is_default <- !is.null(path) && path.expand(path)==
      path.expand(eval(formals(get_description)$paths))
    path_ <- file.path("..",path)
    #### Cascade through options ####
    #### Search installed packages ####
    if (!is.null(ref) &&
        !is.null(try_desc(basename(ref),
                          verbose = verbose)) ){
      d <- desc::desc(package = basename(ref)) 
      #### Search in main directory ####
    } else if((isTRUE(use_wd) | isTRUE(path_is_default)) &&
              !is.null(path) && 
              file.exists(path)){
      d <- desc::desc(file = path)
      #### Search in one directory up directory ####
    } else if(isTRUE(use_wd) &&
              !is.null(path) && 
              file.exists(path_)){
      d <- desc::desc(file = path_) 
      #### Search on GitHub ####
    } else if(!is.null(ref) &&
              length(strsplit(ref,"/")[[1]])>1){
      remotes <- paste0("https://github.com/",ref,"/raw/",
                        c("main","master","dev"),
                        "/DESCRIPTION")
      remotes <- remotes[url_exists(remotes)] 
      if(length(remotes)>0){
        #### Download DESCRIPTION from GitHub #####
        tmp <- file.path(cache_dir,paste0(gsub("/",".",ref),"_DESCRIPTION"))
        if(!file.exists(tmp) | isTRUE(force_new)){
          dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
          utils::download.file(remotes[1],tmp, quiet = !verbose)
        } else{
          messager("Importing cached file:",tmp,v=verbose)
        }
        d <- desc::desc(file = tmp)   
      }  else {
        #### Give up ####
        messager(wrn,v=verbose)
        return(NULL)
      }
      #### Give up ####
    } else {
      messager(wrn,v=verbose)
      return(NULL)
    } 
    #### Check if package in the DESCRIPTION is the one you requested ####
    if(!is.null(ref) && d$has_fields("Package")){
      pkg_retrieved <- d$get_field("Package")
      approximate_match <- check_pkg_name_variants(
        ref = ref,
        pkg_retrieved = pkg_retrieved, 
        verbose = verbose && isFALSE(use_wd))  
      if(isTRUE(approximate_match)){
        return(d)
      } else {
        #### Try again with recursion ####
        # d <- get_description_manual(refs=ref,
        #                             path=path,
        #                             cache_dir=cache_dir,
        #                             force_new=force_new,
        #                             use_wd=FALSE,
        #                             verbose=verbose)
        return(NULL)
      } 
    }
    return(d)
  })
}