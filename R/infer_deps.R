#' Infer dependencies
#' 
#' Infers the R packages that your R package depends on.
#' @param which Which types of dependencies to return.
#' @param imports_thresh The minimum number of times that a package has to be 
#' called within your package to assign it as an Import.
#'  If is called less times than this threshold, 
#'  it will instead be assigned as a Suggest, 
#'  which means it will not be installed by default.
#' @param imports R packages that are exempt from the \code{suggests_thresh}
#' rule and are instead automatically assigned as Imports.
#' @param suggests R packages that are exempt from the \code{suggests_thresh}
#' rule and are instead automatically assigned as Suggests.
#' @param add_newlines Prefix each package name with a newline character 
#' and two spaces. This is useful for formatting \emph{DESCRIPTION} files.
#' @inheritParams renv::dependencies 
#' @returns A character vector of R package names.
#' 
#' @export
#' @importFrom desc desc
#' @importFrom renv dependencies
#' @examples 
#' #### Get example DESCRIPTION file ####
#' url <- "https://github.com/neurogenomics/templateR/raw/master/DESCRIPTION"
#' path <- tempfile(fileext = "DESCRIPTION")
#' utils::download.file(url,path)
#' 
#' deps <- infer_deps(path = path)
infer_deps <- function(path = here::here("DESCRIPTION"),
                       which = c("Imports","Suggests"),
                       imports_thresh = 2,
                       imports = NULL,
                       suggests = c("testthat","rmarkdown","markdown",
                                    "knitr","remotes","knitr","covr"),
                       errors = c("reported", "fatal", "ignored"),
                       dev = FALSE,
                       progress = TRUE,
                       add_newlines = FALSE){
  # devoptera::args2vars(infer_deps, reassign = TRUE)
  Package <- NULL;
  
  #### Check for packages that appear in multiple fields ####
  overlap <- intersect(imports, suggests)
  if(length(overlap)>0){
    stp <- paste(
      "R packages cannot be in both Imports and Suggests",
      "Please ensure the following packages only appear",
      "in one of the two fields:",
      paste("\n - ",shQuote(overlap))
    )
    stop(stp)
  }
  #### Search for deps ####
  dat <- renv::dependencies(path = path, 
                            progress = progress,
                            errors = errors,
                            dev = dev)
  #### Remove "R" ####
  dat <- subset(dat, Package!="R") 
  dfile <- grep("DESCRIPTION$",dat$Source, value = TRUE)[1]
  #### Remove the names of the package itself ####
  if(length(dfile)>0){
    if(file.exists(dfile)){
      pkg <- get_description(paths = dfile,
                             use_repos = FALSE)[[1]]$get_field(key = "Package")  
    } else {
      pkg <- basename(dirname(dfile))
    } 
    dat <- subset(dat, Package!=pkg)
  }
  counts <- sort(table(dat$Package), decreasing = TRUE)
  #### Get Imports ####
  imports_all <- unique(
    c(names(counts)[counts>=imports_thresh],
      imports)
  )
  ## Remove user-specified suggests
  imports_all <- imports_all[!imports_all %in% suggests]
  #### Get Suggests ####
  suggests_all<- unique(
    c(names(counts)[!names(counts) %in% imports_all],
      suggests
      )
  )
  deps <- list(Imports=imports_all, 
               Suggests=suggests_all)
  if(isTRUE(add_newlines)){
    deps <- lapply(deps, function(x){paste0("\n  ",x)})  
  }
  #### Return ####
  if(length(which)==1){
    return(deps[[which]])
  } else {
    return(deps[which])
  } 
}
