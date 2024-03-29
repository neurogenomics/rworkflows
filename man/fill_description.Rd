% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fill_description.R
\name{fill_description}
\alias{fill_description}
\title{Fill \emph{DESCRIPTION}}
\usage{
fill_description(
  path = here::here("DESCRIPTION"),
  package,
  title,
  description,
  github_owner = NULL,
  github_repo = package,
  authors = construct_authors(authors = NULL),
  depends = paste0("R ", "(>= ", bioc_r_versions(bioc_version = "devel", depth = 2)$r,
    ")"),
  imports = infer_deps(path = path, which = "Imports", add_newlines = TRUE),
  suggests = infer_deps(path = path, which = "Suggests", add_newlines = TRUE),
  remotes = NULL,
  version = NULL,
  license = NULL,
  encoding = NULL,
  vignettebuilder = NULL,
  biocviews = infer_biocviews(pkgdir = dirname(path), add_newlines = TRUE),
  url = paste0("https://github.com/", github_owner, "/", github_repo),
  bugreports = paste0(url, "/issues"),
  save_path = path,
  verbose = TRUE,
  fields = list()
)
}
\arguments{
\item{path}{Path to the \emph{DESCRIPTION} file.}

\item{package}{The name of your R package.}

\item{title}{The title of your R package.}

\item{description}{The description of your R package.}

\item{github_owner}{The owner of your R package's GitHub repository.
Can be inferred from the \code{URL} field in the \emph{DESCRIPTION} file if
this has already been filled out.}

\item{github_repo}{The name of your R package's GitHub repository.}

\item{authors}{A list of authors who contributed to your R package,
 each provided as objects of class \link[utils]{person}.
By default, if an \code{Authors} field already exists in the 
\emph{DESCRIPTION} file, the original values are kept.
Otherwise, a template \link[utils]{person} list is created using the 
\link[rworkflows]{construct_authors}.}

\item{depends}{R package Depends. 
Defaults to the version of R that the current 
development version of Bioconductor depends on.}

\item{imports}{R package Imports.
These dependencies will be automatically installed with your R package.}

\item{suggests}{R package Suggests.
These dependencies will NOT be automatically installed with your R package,
unless otherwise specified by users during installation}

\item{remotes}{R package Remotes}

\item{version}{The current version of your R package (e.g 0.99.0).}

\item{license}{R package license.
See \href{https://choosealicense.com/}{here for guidance}.}

\item{encoding}{R package Encoding.}

\item{vignettebuilder}{R package VignetteBuilder.}

\item{biocviews}{Standardised 
\href{https://www.bioconductor.org/packages/release/BiocViews.html}{
biocViews} terms used to describe your package.
Defaults to automatically recommending terms 
using the \link[rworkflows]{infer_biocviews} function.
Note that non-Bioconductor packages (e.g. CRAN) can also use this field.}

\item{url}{URL where your R package is distributed from
 (e.g. GitHub repository, Bioconductor page, and/or CRAN page). 
Can be a single character string or a character vector.}

\item{bugreports}{A URL where users of your package should go 
if they encounter bugs or have feature requests.}

\item{save_path}{Path to save the updated \emph{DESCRIPTION} file to.
Defaults to overwriting the input file (\code{path}). 
Set to \code{NULL} if you wish to only return the \link[desc]{description}
 object without writing to any file.}

\item{verbose}{Print messages.}

\item{fields}{A named list of additional fields to fill the
\emph{DESCRIPTION} file with: e.g. \code{list(RoxygenNote=7.2.3)}}
}
\value{
An object of class \link[desc]{description}.
}
\description{
Fill out a \emph{DESCRIPTION} file, such as (but not limited to) 
the one provided by the 
\href{https://github.com/neurogenomics/templateR}{templateR} 
R package template. 
For any given field, set its corresponding argument as follows 
to get certain behaviour:
\describe{
\item{\code{NULL}: }{Keeps the current value.}
\item{\code{NA}: }{Removes the field from the 
\emph{DESCRIPTION} file entirely.}
}
}
\examples{
#### Get example DESCRIPTION file ####
url <- "https://github.com/neurogenomics/templateR/raw/master/DESCRIPTION" 
path <- tempfile(fileext = "DESCRIPTION")
utils::download.file(url,path)

#### Fill out DESCRIPTION file ####
d <- fill_description(
  path = path,
  package = "MyPackageName",
  title = "This Package Does Awesome Stuff",
  description = paste(
    "MyPackageName does several awesome things.",
    "Describe thing1.",
    "Describe thing2.",
    "Describe thing3."
  ),
  github_owner = "OwnerName",
  biocviews = c("Genetics", "SystemsBiology"))
}
