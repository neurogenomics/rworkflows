#' Latex dependencies
#' 
#' Install extra latex package dependencies.
#' @param install Install the packages with \link[tinytex]{tlmgr_install}
#'  (\code{TRUE}). Otherwise, return a character vector of the packages to
#'  install.
#' @inheritParams dependencies_linux
#' @inheritDotParams tinytex::tlmgr_install
#' @returns A character vector of extra latex packages.
#' 
#' @export
#' @examples
#' dependencies_latex(install=FALSE)
dependencies_latex <- function(extra=c("bera",
                                       "nowidow",
                                       "parnotes",
                                       "marginfix",
                                       "etoolbox",
                                       "titlesec",
                                       "sectsty",
                                       "framed",
                                       "enumitem",
                                       "parskip",
                                       "soul",
                                       "placeins",
                                       "footmisc",
                                       "changepage",
                                       "xstring",
                                       "caption",
                                       "mathtools",
                                       "fancyhdr",
                                       "preprint",
                                       "ragged2e",
                                       "pdfcrop",
                                       "titling",
                                       "silence",
                                       "everysel"),
                               install=TRUE,
                               ...){
  requireNamespace("tinytex")
  
  if(isTRUE(install)){
    tinytex::tlmgr_install(pkgs = unique(extra),
                           ...)
  } else {
    extra
  }
}