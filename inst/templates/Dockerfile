# ----- rworkflows Dockerfile ----- 
# For an example of how to use containers, see the following vignette: 
# https://neurogenomics.github.io/rworkflows/articles/docker.html
# 
#### --Step 1--: Specify the base image ####
FROM {BASE_IMAGE}
<<<<<<< HEAD
#### --Step 2--: Install rworkflows ####
RUN Rscript -e 'if(!require("remotes")) install.packages("remotes"); \ 
                if(!require("rworkflows")) remotes::install_github("neurogenomics/rworkflows@dev");'
#### --Step 3--: Install system dependencies ####
RUN sysreqs=$(Rscript -e 'rworkflows::dependencies_linux(package="rworkflows")') && \ 
    sudo -s eval "$sysreqs"
# Cleanup unnecessary apt files
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*
#### --Step 4--: Create a buildzone folder ####
=======
RUN apt-get update && \
    apt-get install -y \
    git-core \
    libcurl4-openssl-dev \
    libgit2-dev \
    libicu-dev \
    libssl-dev \
    make pandoc \
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
>>>>>>> master
# BiocCheck requires the buildzone to have the same name as the R package
ARG PKG
RUN echo $PKG
RUN mkdir -p /$PKG
ADD . /$PKG
WORKDIR /$PKG
#### --Step 5--: Install package dependencies ####
RUN Rscript -e 'options(crayon.enabled=TRUE, timeout={TIMEOUT}); \ 
                if(!require("BiocManager",quietly=TRUE)) install.packages("BiocManager"); \ 
                repos <- BiocManager::repositories(); \ 
                remotes::install_local(repos=repos, dependencies=TRUE, build_vignettes=FALSE, upgrade=TRUE, force=TRUE);' 
RUN rm -rf /$PKG
