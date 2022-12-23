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
#' @returns Named list of Bioc/R versions
#' 
#' @export
#' @importFrom yaml read_yaml
#' @examples 
#' ver <- bioc_r_versions(bioc_version="devel")
bioc_r_versions <- function(bioc_version=NULL){
  
  yml <- yaml::read_yaml("https://bioconductor.org/config.yaml")
  info <- list(
    devel=list(
      bioc=package_version(yml$devel_version), 
      r=package_version(yml$r_version_associated_with_devel)),
    release=list(
      bioc=package_version(yml$release_version), 
      r=package_version(yml$r_version_associated_with_release))
    )
  info[["r_ver_for_bioc_ver"]] <- yml$r_ver_for_bioc_ver
  if(is.null(bioc_version)){
    return(info)
  } else if (bioc_version=="devel") {
    return(info$devel)
  } else if (bioc_version=="release") {
    return(info$release)
  } else if (bioc_version %in% names(info$r_ver_for_bioc_ver)){ 
    return(list(bioc=package_version(bioc_version),
                r=package_version(
                  info$r_ver_for_bioc_ver[[as.character(bioc_version)]]
                )
                ))
  }
  # info[["r_latest"]] <- package_version(rversions::r_release()$version)
  # info[["r_devel"]] <- package_version(rversions::r_release()$version)
)  return(info)
}