# ----- rworkflows Dockerfile ----- 
# For an example of how to use containers, see the following vignette: 
# https://neurogenomics.github.io/rworkflows/articles/docker.html
# 
#### --Step 1--: Specify the base image ####
FROM {BASE_IMAGE}
#### --Step 2--: Create a buildzone folder ####
# BiocCheck requires the buildzone to have the same name as the R package
ARG PKG
RUN echo $PKG
RUN mkdir -p /$PKG
ADD . /$PKG
WORKDIR /$PKG
#### --Step 3--: Install rworkflows ####
RUN Rscript -e 'if(!require("remotes")) install.packages("remotes"); \ 
                if(!require("rworkflows")) remotes::install_github("neurogenomics/rworkflows@dev");'
#### --Step 4--: Install system dependencies ####
RUN sysreqs=$(Rscript -e 'rworkflows::dependencies_linux()') \ 
    sudo -s eval "$sysreqs"
#### --Step 5--:Install package dependencies ####
RUN Rscript -e 'options(crayon.enabled=TRUE, timeout={TIMEOUT}); \ 
                if(!require("BiocManager",quietly=TRUE)) install.packages("BiocManager"); \ 
                repos <- BiocManager::repositories(); \ 
                remotes::install_local(repos=repos, dependencies=TRUE, build_vignettes=FALSE, upgrade=TRUE, force=TRUE);' 
RUN rm -rf /$PKG
