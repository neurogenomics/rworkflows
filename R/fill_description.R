#' Fill \emph{DESCRIPTION}
#' 
#' Fill out a \emph{DESCRIPTION} file, such as (but not limited to) 
#' the one provided by the 
#' \href{https://github.com/neurogenomics/templateR}{templateR} 
#' R package template. 
#' For any given field, set its corresponding argument as follows 
#' to get certain behaviour:
#' \itemize{
#' \item{\code{NULL}: }{Keeps the current value.}
#' \item{\code{NA}: }{Removes the field from the 
#' \emph{DESCRIPTION} file entirely.}
#' }
#' @param package The name of your R package.
#' @param title The title of your R package.
#' @param description The description of your R package.
#' @param authors A list of authors who contributed to your R package,
#'  each provided as objects of class \link[utils]{person}.
#' @param github_repo The name of your R package's GitHub repository.
#' @param github_owner The owner of your R package's GitHub repository.
#' @param depends R package Depends. 
#' Defaults to the version of R that the current 
#' Bioconductor release depends on.
#' @param imports R package Imports.
#' These dependencies will be automatically installed with your R package.
#' @param suggests R package Suggests.
#' These dependencies will NOT be automatically installed with your R package,
#' unless otherwise specified by users during installation
#' @param remotes R package Remotes
#' @param version The current version of your R package (e.g 0.99.0).
#' @param license R package license.
#'  See \href{https://choosealicense.com/}{here for guidance}.
#' @param encoding R package Encoding.
#' @param vignettebuilder R package VignetteBuilder.
#' @param biocviews BiocViews fields for Bioconductor packages. 
#' Defaults to "recommended", which will automatically recommend terms 
#' based on your package contents via \link[biocViews]{recommendBiocViews}.
#' @param url URL where your R package is distributed from
#'  (e.g. GitHub repository, Bioconductor page, and/or CRAN page). 
#' Can be a single character string or a character vector.
#' @param bugreports A URL where users of your package should go 
#' if they encounter bugs or have feature requests.
#' @param save_path Path to save the updated \emph{DESCRIPTION} file to.
#' Defaults to overwriting the input file (\code{path}). 
#' @param verbose Print messages.
#' @param fields A named list of additional fields to fill the
#'  \emph{DESCRIPTION} file with: e.g. \code{list(RoxygenNote=7.2.3)}
#' @inheritParams get_description
#' @returns An object of class \link[desc]{description}.
#' 
#' @export
#' @import desc
#' @importFrom here here
#' @examples
#' #### Get example DESCRIPTION file ####
#' url <- "https://github.com/neurogenomics/templateR/raw/master/DESCRIPTION" 
#' path <- tempfile(pattern = "DESCRIPTION")
#' utils::download.file(url,path)
#' 
#' #### Fill out DESCRIPTION file ####
#' d <- fill_description(
#'   path = path,
#'   package = "MyPackageName",
#'   title = "This Package Does Awesome Stuff",
#'   description = paste(
#'     "MyPackageName does several awesome things.",
#'     "Describe thing1.",
#'     "Describe thing2.",
#'     "Describe thing3."
#'   ),
#'   github_owner = "OwnerName",
#'   biocviews = c("Genetics", "SystemsBiology"))
fill_description <- function(path = here::here("DESCRIPTION"),
                             package,
                             title,
                             description,
                             github_owner,
                             github_repo=package,
                             authors =  c( 
                               utils::person(
                                 given = "yourGivenName",
                                 family = "yourFamilyName",
                                 role = c("cre"),
                                 email = "yourEmail@email.com",
                                 comment = c(ORCID = "yourOrcidId"))
                             ), 
                             depends = paste0(
                               "R ","(>=",bioc_r_versions()$release$r,")"
                             ),
                             imports = infer_deps(which = "Imports"),
                             suggests = infer_deps(which = "Suggests"),
                             remotes = NULL,
                             version = NULL,
                             license = NULL,
                             encoding = NULL,
                             vignettebuilder = NULL,
                             biocviews = "recommended",  
                             url = paste0("https://github.com/",
                                          github_owner,"/",github_repo),
                             bugreports = paste0(url,"/issues"),
                             save_path = path,
                             verbose = TRUE,
                             fields = list()
                             ){
  # templateR:::args2vars(fill_description); bugreports = paste0(url,"/issues")
  force(authors)
  force(title)
  force(description)
  force(github_repo)
  force(github_owner)
  
  #### Get automatically recommended biocViews ####
  if(all(biocviews=='recommended')){
    messager("Finding recommended biocViews.",v=verbose)
    requireNamespace("biocViews")
    biocviews <- biocViews::recommendBiocViews(
      pkgdir = here::here(), 
      branch = c("Software", "AnnotationData", "ExperimentData")[1]
    )$recommended
  }
  #### Import DESCRIPTION file #####
  d <- get_description(path = path)
  #### Set each field #####
  field_list <- list(Package=package,
                     Title=title,
                     Description=description,
                     Authors=authors,
                     Depends=depends,
                     Suggests=suggests,
                     Remotes=remotes,
                     Version=version,
                     License=license,
                     Encoding=encoding,
                     VignetteBuilder=vignettebuilder,
                     biocViews=biocviews,
                     URL=url,
                     BugReports=bugreports
                )
  field_list <- c(field_list,fields)
  #### Set simple Fields ####
  for(f in names(field_list)){
    val <- field_list[[f]]
    if(!is.null(val)){
      #### Delete field ####
      if(all(is.na(val))) {
        messager("Deleting field:",f,v=verbose)
        d$del(keys = f)
      #### Update field ####
      } else {
        messager("Updating",f,"-->",val,v=verbose)
        if(f=="Authors"){
          d$set_authors(authors = val)  
        } else {
          d$set_list(key = f,
                     list_value = val)
        } 
      }  
    }
  }   
  #### Return description obj ####
  return(d)
} 
