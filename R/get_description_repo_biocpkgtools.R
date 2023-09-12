get_description_repo_biocpkgtools <- function(refs = NULL,
                                              repo = c("BioCsoft",
                                                       "BioCann", 
                                                       "BioCexp",
                                                       "BioCworkflows", 
                                                       "CRAN"), 
                                              force_new = FALSE,
                                              verbose = TRUE){
  Package <- NULL;
  
  #### Use updated file ####
  requireNamespace("BiocPkgTools")
  tmp_dir <- file.path(tempdir(),"BiocPkgTools")
  dir.create(tmp_dir,showWarnings = FALSE, recursive = TRUE)
  #### Import each database ####
  db <- lapply(stats::setNames(repo,repo), function(x){
    messager("Importing database:",x,v=verbose)
    #### Cache a local copy ####
    tmp <- file.path(tmp_dir,paste0(x,".rds"))
    if(file.exists(tmp) && isFALSE(force_new)){
      db_i <- readRDS(tmp)
    } else {
      db_i <- BiocPkgTools::biocPkgList(repo=x,
                                        version = version) |>
        suppressMessages() 
      saveRDS(db_i, tmp)
    }
    return(db_i)
  }) |> data.table::rbindlist(fill = TRUE, 
                              use.names = TRUE, 
                              idcol = "r_repo")
  refs <- check_refs_names(dl = refs)
  if(!is.null(refs)) db <- db[Package %in% basename(names(refs)),]
  if(nrow(db)==0) {
    messager("0 DESCRIPTION files found in CRAN/Bioc.",
             "Returning NULL.",v=verbose)
    return(NULL)
  }
  #### Parse GitHub URL #####
  db <- get_github_url_db(db = db, 
                          return_dt = TRUE) 
  #### Split GitHub URL ####
  db <- cbind(db,BiocPkgTools::githubURLParts(urls = db$url_github))
  data.table::setnames(db,c("user_repo","user"),c("owner_repo","owner"),
                       skip_absent = TRUE)
  return(db)
}