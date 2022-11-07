rworkflows
================
<img src='https://github.com/neurogenomics/rworkflows/raw/master/inst/hex/hex.png' height='300'><br><br>
[![](https://img.shields.io/badge/devel%20version-0.99.0-black.svg)](https://github.com/neurogenomics/rworkflows)
[![R build
status](https://github.com/neurogenomics/rworkflows/workflows/R-CMD-check-bioc/badge.svg)](https://github.com/neurogenomics/rworkflows/actions)
[![](https://img.shields.io/github/last-commit/neurogenomics/rworkflows.svg)](https://github.com/neurogenomics/rworkflows/commits/master)
[![](https://app.codecov.io/gh/neurogenomics/rworkflows/branch/master/graph/badge.svg)](https://app.codecov.io/gh/neurogenomics/rworkflows)
[![License:
GPL-3](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://cran.r-project.org/web/licenses/GPL-3)
¶ <h4> ¶ Authors: <i>Brian Schilder, Alan Murphy</i> ¶ </h4>
<h4> ¶ README updated: <i>Nov-07-2022</i> ¶ </h4>

## Intro

[GitHub Actions](https://docs.github.com/en/actions) are a powerful way
to automatically launch workflows every time you push changes to a
GitHub repository. This is a form of [Continuous Integration
(CI)](https://docs.github.com/en/actions/automating-builds-and-tests/about-continuous-integration),
which helps ensure that your code is always working as expected (without
having to manually check each time).

Here, we have designed robust and flexible workflows specifically for
the development of R packages.

Currently, these workflows perform the following tasks:

1.  Build a Docker container to run subsequent steps within.
2.  Build and check your R package (with CRAN and Bioconductor
    checks).  
3.  Run units tests.  
4.  Run code coverage tests and upload the results to
    [Codecov](https://about.codecov.io/).  
5.  (Re)build and launch a documentation website for your R package.  
6.  Push an [Rstudio](https://www.rstudio.com/)
    [Docker](https://www.docker.com/) container to
    [DockerHub](https://hub.docker.com/) with your package and all its
    dependencies pre-installed.

Importantly, these files are designed to work with any R package
out-of-the-box. This means you won’t have to manually edit any of the
files provided here, simply copy and paste them into the appropriate
folders.

## Documentation

### [Website](https://neurogenomics.github.io/rworkflows)

### [Docker/Singularity](https://neurogenomics.github.io/rworkflows/articles/docker)

## Setup

### 1. Create your R package

If you haven’t already [created your R
package](https://support.rstudio.com/hc/en-us/articles/200486488-Developing-Packages-with-the-RStudio-IDE),
you can use [`templateR`](https://github.com/neurogenomics/templateR) as
a CRAN/Bioconductor-ready template.

### 2. Setup GitHub Secrets

GitHub now lets you store “Secrets” within each repo. These are
basically hidden variables that no one but the repo admins can see/edit.

See here for instructions on how to create [GitHub
Secrets](https://docs.github.com/en/codespaces/managing-codespaces-for-your-organization/managing-encrypted-secrets-for-your-repository-and-organization-for-github-codespaces)
and [GitHub Organization
Secrets](https://docs.github.com/en/codespaces/managing-codespaces-for-your-organization/managing-encrypted-secrets-for-your-repository-and-organization-for-github-codespaces#adding-secrets-for-an-organization).

You will need to store the following variables as Secrets in your GitHub
repo.

- `PAT_GITHUB`: \<Your GitHub Personal Authentication Token generated
  [via the following
  instructions](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)\>  
- `DOCKER_USERNAME`: \<Your DockerHub username. [Create an
  account](https://hub.docker.com/signup) if you haven’t already\>  
- `DOCKER_ORG`: \<Your DockerHub organization name
  (e.g. “neurogenomicslab”). If you’re pushing to your personal
  DockerHub account instead, this will be the same as
  `DOCKER_USERNAME`\>  
- `DOCKER_TOKEN`: \<Your DockerHub access token generated [via the
  following
  instructions](https://docs.docker.com/docker-hub/access-tokens/)\>

### 3. Copy files

Copy the following folders/files into the folder where your R package’s
project folder.

    mkdir -p <my_package_folder>/.github/

    scp https://github.com/neurogenomics/rworkflows/raw/master/.github/workflows/test.yml <my_package_folder>/.github/workflows/

    scp https://github.com/neurogenomics/rworkflows/raw/master/test-document-deploy/Dockerfile <my_package_folder>/.github/workflows/

**NOTE**: When copying files, you will need to use the exact folder
structure used in this repo, including the fact that `.github/` starts
with a `.`. This means it will be a “hidden” folder, but you can still
view it within the “Files” window in Rstudio, or by running `ls -lah`
within the command line.

## Push to GitHub

Now, these workflows will automatically be run every time you push
changes to your GitHub repo.

    git add .
    git commit -m "<commit message>"
    git push

You can then monitor the progress and view the results of your workflows
via the *“Actions”* tab of your GitHub repo.

**NOTE**: If you do not see an *“Actions”* tab, go to *Settings –\>
Actions* and make sure “Actions permissions” is activated.

## File descriptions

<details>

### `.github/workflows/check-bioc-docker.yml`

Steps 1-5 [above](https://github.com/neurogenomics/rworkflows#Intro).

This workflow is derived from the workflow generated by the
[`use_bioc_github_action()`](https://lcolladotor.github.io/biocthis/articles/biocthis.html)
function within the
[`biothis`](http://www.bioconductor.org/packages/release/bioc/html/biocthis.html)
package. This workflow takes advantage of several key features:

- Uses the official
  [`Bioconductor/bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker)
  Docker container (to minimise errors due to versioning
  conflicts/missing dependencies).  
- Uses the package
  [AnVIL](https://bioconductor.org/packages/release/bioc/html/AnVIL.html)
  to more rapidly install R packages from binaries.

However, I have modified the `bioc` workflow to make a number of
improvements:

- Uses dynamic variables to specify R/Bioconductor versions
  (e.g. `r: "latest"`) and the name of your R package, as opposed to
  static names that are likely to become outdated (e.g. `r: "4.0.1"`).  
- Additional error handling and dependencies checks.  
- Re-renders `README.Rmd` before rebuilding the documentation website.

### `.github/workflows/dockerhub.yml`

Step 6 [above](https://github.com/neurogenomics/rworkflows#Intro).

Uses the official
[`Bioconductor/bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker)
Docker container.

**NOTE**: The `Bioconductor/bioconductor_docker` container often lags
behind the actual Bioconductor releases. This means that sometimes
“devel” in `Bioconductor/bioconductor_docker` is actually referring to
the “release” version of Bioconductor. See this
[Issue](https://github.com/Bioconductor/bioconductor_docker/issues/37)
for details.

### `Dockerfile`

### Key features

This Dockerfile is designed for developers of any R package stored on
GitHub. Unlike other Dockerfiles, this one **does not require any manual
editing when applying to different R packages**. This means that users
who are unfamiliar with Docker do not have to troubleshoot making this
file correctly. It also means that it will continue to work even if your
R package dependencies change.

It runs several steps:

1.  Pulls the official bioconductor Docker container (which includes
    Rstudio).  
2.  Runs CRAN checks on the R package.  
3.  Runs all Bioconductor checks on the R package.  
4.  Installs the R package and all of its dependencies (including
    `Depends`, `Imports`, and `Suggests`).

**NOTE**: If any of the CRAN/Bioconductor checks do not pass, the Docker
container will not be pushed to DockerHub. This means you don’t have to
worry about a faulty version of your package accidentally being deployed
to DockerHub.

This Dockerfile should be used with the
[`dockerhub.yml`](https://github.com/neurogenomics/rworkflows/blob/master/.github/workflows/dockerhub.yml)
workflow file, as you must first checkout the R package from GitHub,
along with several other GitHub Actions.

If the R package passes all checks, the `dockerhub.yml` workflow will
subsequently push the Docker container to DockerHub (using the username
and token credentials stored as GitHub Secrets).

</details>

# Session Info

<details>

``` r
utils::sessionInfo()
```

    ## R version 4.2.1 (2022-06-23)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.5 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/liblapack.so.3
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] rmarkdown_2.17
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] knitr_1.40          magrittr_2.0.3      dlstats_0.1.5      
    ##  [4] munsell_0.5.0       colorspace_2.0-3    R6_2.5.1           
    ##  [7] rlang_1.0.6         fastmap_1.1.0       fansi_1.0.3        
    ## [10] stringr_1.4.1       tools_4.2.1         grid_4.2.1         
    ## [13] gtable_0.3.1        xfun_0.34           utf8_1.2.2         
    ## [16] cli_3.4.1           badger_0.2.1        htmltools_0.5.3    
    ## [19] rprojroot_2.0.3     yaml_2.3.6          digest_0.6.30      
    ## [22] tibble_3.1.8        lifecycle_1.0.3     BiocManager_1.30.19
    ## [25] RColorBrewer_1.1-3  ggplot2_3.3.6       yulab.utils_0.0.5  
    ## [28] vctrs_0.5.0         glue_1.6.2          evaluate_0.17      
    ## [31] stringi_1.7.8       compiler_4.2.1      pillar_1.8.1       
    ## [34] desc_1.4.2          rvcheck_0.2.1       scales_1.2.1       
    ## [37] jsonlite_1.8.3      pkgconfig_2.0.3

</details>
