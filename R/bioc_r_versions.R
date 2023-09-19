#' Bioconductor / R versions
#' 
#' Get the respective version of R for a given version of 
#' \href{https://bioconductor.org/}{Bioconductor}.
#' @param bioc_version Version of Bioc to return info for.
#' Can be:
#' \itemize{
#' \item{"devel"}{Get the current development version of Bioc.}
#' \item{"release"}{Get the current release version of Bioc.}
#' \item{<numeric>}{A specific Bioc version number (e.g. \code{3.16}).}
#' \item{NULL}{Return info for all Bioc versions.}
#' }
#' @param depth How many levels deep into the R version to include.
#' For example, is the R version number is "4.2.0", 
#' the following depths would return:
#' \itemize{
#' \item{\code{depth=NULL}: }{"4.2.0"}
#' \item{\code{depth=1}: }{"4"}
#' \item{\code{depth=2}: }{"4.2"}
#' \item{\code{depth=3}: }{"4.2.0"}
#' }
#' @param return_opts Return a character vector of all valid Bioc version names.
#' @returns Named list of Bioc/R versions
#' 
#' @export
#' @importFrom yaml read_yaml
#' @examples 
#' ver <- bioc_r_versions(bioc_version="devel")
bioc_r_versions <- function(bioc_version = NULL,
                            depth = NULL,
                            return_opts = FALSE){
  # devoptera::args2vars(bioc_r_versions)
  
  yml <- yaml::read_yaml("https://bioconductor.org/config.yaml")
  info <- list(
    devel=list(
      bioc=parse_version(yml$devel_version), 
      r=parse_version(yml$r_version_associated_with_devel, depth = depth)
      ),
    release=list(
      bioc=parse_version(yml$release_version), 
      r=parse_version(yml$r_version_associated_with_release, depth = depth)
      )
    )
  ### Parse subversions ####
  info[["r_ver_for_bioc_ver"]] <- lapply(yml$r_ver_for_bioc_ver, 
                                         function(v){
                                           parse_version(v, depth=depth)
                                         }) 
  #### Handler ####
  if(isTRUE(return_opts)){
    opts <- c(names(info)[seq(2)], rev(names(info$r_ver_for_bioc_ver)))
    return(opts)
  } else if(is.null(bioc_version)){
    return(info)
  } else if (bioc_version %in% c("devel","dev")) {
    return(info$devel)
  } else if (bioc_version %in% c("release","latest")) {
    return(info$release)
  } else if (bioc_version %in% names(info$r_ver_for_bioc_ver)){ 
    if(grepl("RELEASE_",bioc_version,ignore.case = TRUE)){
      bioc_version <- gsub("_",".",
                           gsub("RELEASE_","",bioc_version,ignore.case = TRUE)
                           )
    }
    info_v <- list(bioc=parse_version(bioc_version),
                   r=parse_version(info$r_ver_for_bioc_ver[[
                       as.character(bioc_version)
                     ]],
                     depth = depth)
                 )
    return(info_v)
  }
  # info[["r_latest"]] <- package_version(rversions::r_release()$version)
  # info[["r_devel"]] <- package_version(rversions::r_release()$version)
  return(info) 
}
