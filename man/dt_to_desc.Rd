% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dt_to_desc.R
\name{dt_to_desc}
\alias{dt_to_desc}
\title{\link[data.table]{data.table} to \link[desc]{desc}}
\usage{
dt_to_desc(db, refs = NULL, verbose = TRUE)
}
\arguments{
\item{db}{A \link[data.table]{data.table} where each row is a different R package
and each column is a field from the \emph{DESCROPTION} file.}

\item{refs}{Reference for one or more GitHub repository in owner/repo format
 (e.g.\code{"neurogenomics/rworkflows"}), or an R package name 
(e.g. \code{"rworkflows"}).}

\item{verbose}{Print messages.}
}
\value{
A named list of \link[desc]{desc} objects.
}
\description{
Convert \link[data.table]{data.table} containing the
 parsed \emph{DESCROPTION} file data and convert each of them to 
 to \link[desc]{desc} format.
}
\examples{
#### Updated data ####
# db <- BiocPkgTools::biocPkgList()
#### Static data ####
 db <- rworkflows::biocpkgtools_db
 dl <- dt_to_desc(db=db, refs="ABSSeq")
}
