# ----- R Package Dockerfile -----
#
# This Dockerfile is designed for developers of any R package stored on GitHub.
#
# It runs several steps:
#   1. Pulls the official bioconductor Docker container (which includes Rstudio).
#   2. Runs CRAN checks on the R package.
#   3. Installs the R package and all of its dependencies (including Depends, Imports, and Suggests).
#
# You can then create an image of the Docker container in any command line:
#   docker pull <DockerHub_repo_name>/<package_name>
# Once the image has been created, you can launch it with:
#   docker run -d -e ROOT=true -e PASSWORD=bioc -v ~/Desktop:/Desktop -v /Volumes:/Volumes --rm -p 8788:8787 <DockerHub_repo_name>/<package_name>
# Finally, launch the containerised Rstudio by entering the following URL in any web browser:
#   http://localhost:8788/
#
# The username will be "rstudio" by default,
# and you can set the password to whatever you like,
#
# This DockerFile was partly adapted from the [scFlow Dockerfile](https://github.com/combiz/scFlow/blob/master/Dockerfile).
FROM {BASE_IMAGE}
RUN apt-get update && \
    apt-get install -y \
    git-core \
    libcurl4-openssl-dev \
    libgit2-dev \
    libicu-dev \
    libssl-dev \
    make pandoc \
    pandoc-citeproc \
    zlib1g-dev \
  	xfonts-100dpi \
  	xfonts-75dpi \
  	biber \
  	libsbml5-dev \
  	qpdf \
  	cmake \
  	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# Create a buildzone folder named after the R package
# BiocCheck requires the buildzone to have the same name as the R package
ARG PKG
RUN echo $PKG
RUN mkdir -p /$PKG
ADD . /$PKG
WORKDIR /$PKG
#### Install package dependencies ####
RUN Rscript -e 'options(download.file.method="libcurl", crayon.enabled=TRUE, timeout=2000); \
                if(!require("BiocManager")) install.packages("BiocManager"); \
                if(!require("remotes")) install.packages("remotes");
                repos <- BiocManager::repositories()
                remotes::install_local(repos=repos, dependencies=TRUE, build_vignettes=FALSE, upgrade=TRUE, force=TRUE)'
RUN rm -rf /$PKG
