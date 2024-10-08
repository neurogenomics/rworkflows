% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/infer_docker_org.R
\name{infer_docker_org}
\alias{infer_docker_org}
\title{Infer Docker registry organisation name}
\usage{
infer_docker_org(docker_org = NULL, docker_registry, verbose = TRUE, ...)
}
\arguments{
\item{docker_org}{Docker registry organization name. 
Can simply be your registry username instead.
If \code{NULL}, \code{docker_org} will be inferred as the R package's GitHub 
owner.}

\item{docker_registry}{Docker container registry to push to. 
Options include:
\describe{
 \item{"ghcr.io" : }{\href{https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry}{
 GitHub Container Registry}}  
 \item{"docker.io" : }{\href{https://hub.docker.com/}{DockerHub}}
}}

\item{verbose}{Print messages.}

\item{...}{
  Arguments passed on to \code{\link[=get_description]{get_description}}
  \describe{
    \item{\code{refs}}{Reference for one or more GitHub repository in owner/repo format
 (e.g.\code{"neurogenomics/rworkflows"}), or an R package name 
(e.g. \code{"rworkflows"}).}
    \item{\code{paths}}{Paths to \emph{DESCRIPTION} file(s)  R package(s).}
    \item{\code{cache_dir}}{Directory where to cache downloaded files.}
    \item{\code{force_new}}{Ignore cached files and re-download them instead.}
    \item{\code{use_wd}}{Search the local working directory (and the one above it)
for \emph{DESCRIPTION} files.}
    \item{\code{use_repos}}{Use R standard R package repositories like CRAN and Bioc
to find \emph{DESCRIPTION} files.}
    \item{\code{db}}{A \link[data.table]{data.table} of R package metadata generated by
\link[BiocPkgTools]{biocPkgList}.}
    \item{\code{repo}}{\code{character(1)} The requested Bioconductor repository. The default
is to pull from the "BioCsoft" repository. Possible repositories include
"BioCsoft", "BioCexp", "BioCworkflows", "BioCann", and "CRAN". Note that
not all repos are available for all versions, particularly older versions.}
  }}
}
\value{
Docker registry organisation name.
}
\description{
Infer Docker registry organisation name from DESCRIPTION file.
}
\examples{
infer_docker_org(docker_org="myorg", docker_registry="ghcr.io")
}
