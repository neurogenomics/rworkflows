% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bioc_r_versions.R
\name{bioc_r_versions}
\alias{bioc_r_versions}
\title{Bioconductor / R versions}
\usage{
bioc_r_versions(bioc_version = NULL, depth = NULL, return_opts = FALSE)
}
\arguments{
\item{bioc_version}{Version of Bioc to return info for.
Can be:
\describe{
\item{"devel"}{Get the current development version of Bioc.}
\item{"release"}{Get the current release version of Bioc.}
\item{<numeric>}{A specific Bioc version number (e.g. \code{3.16}).}
\item{NULL}{Return info for all Bioc versions.}
}}

\item{depth}{How many levels deep into the R version to include.
For example, is the R version number is "4.2.0", 
the following depths would return:
\describe{
\item{\code{depth=NULL}: }{"4.2.0"}
\item{\code{depth=1}: }{"4"}
\item{\code{depth=2}: }{"4.2"}
\item{\code{depth=3}: }{"4.2.0"}
}}

\item{return_opts}{Return a character vector of all valid Bioc version names.}
}
\value{
Named list of Bioc/R versions
}
\description{
Get the respective version of R for a given version of 
\href{https://bioconductor.org/}{Bioconductor}.
}
\examples{
ver <- bioc_r_versions(bioc_version="devel")
}
