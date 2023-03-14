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
#' @param path Path to the \emph{DESCRIPTION} file.
#' @param package The name of your R package.
#' @param title The title of your R package.
#' @param description The description of your R package.
#' @param authors A list of authors who contributed to your R package,
#'  each provided as objects of class \link[utils]{person}.
#' By default, if an \code{Authors} field already exists in the 
#' \emph{DESCRIPTION} file, the original values are kept.
#' Otherwise, a template \link[utils]{person} list is created using the 
#' \link[rworkflows]{construct_authors}.
#' @param github_repo The name of your R package's GitHub repository.
#' @param github_owner The owner of your R package's GitHub repository.
#' Can be inferred from the \code{URL} field in the \emph{DESCRIPTION} file if
#' this has already been filled out.
#' @param depends R package Depends. 
#' Defaults to the version of R that the current 
#' development version of Bioconductor depends on.
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
#' @param biocviews Standardised 
#' \href{https://www.bioconductor.org/packages/release/BiocViews.html}{
#' biocViews} terms used to describe your package.
#' Defaults to automatically recommending terms 
#' using the \link[rworkflows]{infer_biocviews} function.
#' Note that non-Bioconductor packages (e.g. CRAN) can also use this field.
#' @param url URL where your R package is distributed from
#'  (e.g. GitHub repository, Bioconductor page, and/or CRAN page). 
#' Can be a single character string or a character vector.
#' @param bugreports A URL where users of your package should go 
#' if they encounter bugs or have feature requests.
#' @param save_path Path to save the updated \emph{DESCRIPTION} file to.
#' Defaults to overwriting the input file (\code{path}). 
#' Set to \code{NULL} if you wish to only return the \link[desc]{description}
#'  object without writing to any file.
#' @param verbose Print messages.
#' @param fields A named list of additional fields to fill the
#'  \emph{DESCRIPTION} file with: e.g. \code{list(RoxygenNote=7.2.3)}
#' @returns An object of class \link[desc]{description}.
#' 
#' @export
#' @import desc
#' @importFrom here here
#' @examples
#' #### Get example DESCRIPTION file ####
#' url <- "https://github.com/neurogenomics/templateR/raw/master/DESCRIPTION" 
#' path <- tempfile(fileext = "DESCRIPTION")
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
                             github_owner = NULL,
                             github_repo=package,
                             authors = construct_authors(authors = NULL), 
                             depends = paste0(
                               "R ",
                               "(>= ",bioc_r_versions(bioc_version = "devel", 
                                                     depth = 2)$r,
                               ")"
                             ),
                             imports = infer_deps(which = "Imports",
                                                  add_newlines = TRUE),
                             suggests = infer_deps(which = "Suggests",
                                                   add_newlines = TRUE),
                             remotes = NULL,
                             version = NULL,
                             license = NULL,
                             encoding = NULL,
                             vignettebuilder = NULL,
                             biocviews = infer_biocviews(pkgdir = dirname(path),
                                                         add_newlines = TRUE),  
                             url = paste0("https://github.com/",
                                          github_owner,"/",github_repo),
                             bugreports = paste0(url,"/issues"),
                             save_path = path,
                             verbose = TRUE,
                             fields = list()
                             ){
  # package="mypackage"; devoptera::args2vars(fill_description); 
  # bugreports = paste0(url,"/issues"); description=NA;
  
  force(authors)
  force(title)
  force(description)
  force(github_repo)
  force(github_owner)
  
  #### Import DESCRIPTION file #####
  d <- get_description(paths = path[1], 
                       use_repos = FALSE)[[1]]
  if(is.null(d)) stop("Cannot import DESCRIPTION file.")
  if(is.null(github_owner)){
    stp <- paste(
      "github_owner could not be inferred from URL field.",
      "Please provide the github_owner argument directly."
    )
    URL <- grep("github.com",d$get_urls(), value = TRUE)[1]
    if(is.na(URL)){ 
      stop(stp)
    } else {
      github_owner <- basename(dirname(URL))
    }
  }
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
        if(f=="Authors"){
          ## Don't overwrite Authors if it already exists AND
          ## the user-provided value is the default template.
          if(d$has_fields("Authors") &&
             val==construct_authors()){
            messager('Keeping existing Authors field.',v=verbose) 
          } else {
            messager("Updating:",f,"-->",paste(val,collapse = ","),v=verbose)
            d$set_authors(authors = val)   
          }
        } else {
          messager("Updating:",f,"-->",paste(val,collapse = ", "),v=verbose)
          d$set_list(key = f,
                     list_value = val)
        } 
      }  
    }
  }   
  #### Save new file ####
  if(!is.null(save_path)){
    messager("Saving updated file:",save_path,v=verbose)
    dir.create(dirname(save_path),showWarnings = FALSE, recursive = TRUE)
    d$write(save_path) 
  }
  #### Return description obj ####
  return(d)
} 
