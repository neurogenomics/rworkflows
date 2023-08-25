#' Get \emph{DESCRIPTION} files for R repos
#' 
#' Get the \emph{DESCRIPTION} file information in
#'  \link[data.table]{data.table} format for all R packages 
#' in standard R repositories (CRAN, Bioc).
#'  Can return a subset of results for specific packages as well.
#' @inheritParams get_description
#' @inheritParams BiocPkgTools::biocPkgList
#' @returns Named list of \link[desc]{desc} objects.
#' 
#' @keywords internal
#' @import BiocPkgTools
#' @importFrom BiocManager version
get_description_repo <- function(refs = NULL,
                                 repo = c("BioCsoft", "BioCann", "BioCexp",
                                           "BioCworkflows", "CRAN"),
                                 version = BiocManager::version(),
                                 verbose = TRUE){
  # devoptera::args2vars(get_description_repo, reassign = TRUE)
  
  Package <- NULL;
  force(refs)
  messager("Searching for DESCRIPTION file(s) in R repositories:",
           paste(repo,collapse = ", "),v=verbose)
  tmp_dir <- file.path(tempdir(),"BiocPkgTools")
  dir.create(tmp_dir,showWarnings = FALSE, recursive = TRUE)
  #### Import each database ####
  db <- lapply(stats::setNames(repo,repo), function(x){
    messager("Importing database:",x,v=verbose)
    #### Cache a local copy ####
    tmp <- file.path(tmp_dir,paste0(x,".rds"))
    if(file.exists(tmp)){
      db_i <- readRDS(tmp)
    } else {
      db_i <- BiocPkgTools::biocPkgList(repo=x,
                                        version = version) |>
        suppressMessages() 
      saveRDS(db_i, tmp)
    }
    return(db_i)
  }) |> data.table::rbindlist(fill = TRUE, use.names = TRUE, idcol = "r_repo")
  
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
  dt_to_desc(db = db,
             refs = refs,
             verbose = verbose)
  
  # tools::CRAN_package_db() 
  # report <- BiocPkgTools::biocBuildReport() 
  # BiocPkgTools::githubDetails(pkgs = "bschilder/scKirby") 
  # dep_df = buildPkgDependencyDataFrame()
  # g = buildPkgDependencyIgraph(dep_df)
  # g2 = subgraphByDegree(g, "orthogene",degree = 1)
  # library(visNetwork)
  # data <- toVisNetworkData(g2)
  # visNetwork(nodes = data$nodes, edges = data$edges, height = "500px") |>
  #   visEdges(arrows='from') 
  
  
  # fields <- pkgsearch::cran_package(name = pkg)   
  # miniCRAN::addPackageListingGithub(repo = ) 
  # deepdep::deepdep(package = "rworkflows",depth = 2,bioc = TRUE)
  # d <- deepdep::get_description(package = "rworkflows") 
  # deepdep::plot_downloads("htmltools")
}
