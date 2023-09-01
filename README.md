<img src='https://github.com/neurogenomics/rworkflows/raw/master/inst/hex/hex.png' title='Hex sticker for rworkflows' height='350'><br>
[![](https://www.r-pkg.org/badges/version/rworkflows?color=black)](https://cran.r-project.org/package=rworkflows)
[![CRAN
checks](https://badges.cranchecks.info/summary/rworkflows.svg)](https://cran.r-project.org/web/checks/check_results_rworkflows.html)
[![](http://cranlogs.r-pkg.org/badges/last-month/rworkflows?color=black)](https://cran.r-project.org/package=rworkflows)
[![](http://cranlogs.r-pkg.org/badges/grand-total/rworkflows?color=black)](https://cran.r-project.org/package=rworkflows)
[![License:
GPL-3](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://cran.r-project.org/web/licenses/GPL-3)
<br>
[![](https://img.shields.io/badge/devel%20version-0.99.12-black.svg)](https://github.com/neurogenomics/rworkflows)
[![](https://img.shields.io/github/languages/code-size/neurogenomics/rworkflows.svg)](https://github.com/neurogenomics/rworkflows)
[![](https://img.shields.io/github/last-commit/neurogenomics/rworkflows.svg)](https://github.com/neurogenomics/rworkflows/commits/master)
<br> [![R build
status](https://github.com/neurogenomics/rworkflows/workflows/rworkflows/badge.svg)](https://github.com/neurogenomics/rworkflows/actions)
[![R build
status](https://github.com/neurogenomics/rworkflows/workflows/rworkflows_static/badge.svg)](https://github.com/neurogenomics/rworkflows/actions)
[![R build
status](https://github.com/neurogenomics/rworkflows/workflows/rworkflows_dev/badge.svg)](https://github.com/neurogenomics/rworkflows/actions)
[![](https://codecov.io/gh/neurogenomics/rworkflows/branch/master/graph/badge.svg)](https://app.codecov.io/gh/neurogenomics/rworkflows)
<br>
<a href='https://app.codecov.io/gh/neurogenomics/rworkflows/tree/master' target='_blank'><img src='https://codecov.io/gh/neurogenomics/rworkflows/branch/master/graphs/icicle.svg' title='Codecov icicle graph' width='200' height='50' style='vertical-align: top;'></a>  
<h4>  
Authors: <i>Brian Schilder, Alan Murphy, Nathan Skene</i>  
</h4>
<h4>  
README updated: <i>Sep-01-2023</i>  
</h4>

## Intro

[**GitHub Actions**](https://docs.github.com/en/actions) are a powerful
way to automatically launch workflows every time you push changes to a
GitHub repository. This is a form of [**Continuous Integration
(CI)**](https://docs.github.com/en/actions/automating-builds-and-tests/about-continuous-integration),
which helps ensure that your code is always working as expected (without
having to manually check each time).

Here, we have designed a robust, reusable, and flexible **action**
specifically for the development of R packages. We also provide an R
function to automatically generate a **workflow file** that calls the
`rworkflows` composite action:

Currently, `rworkflows` **action** performs the following tasks:

1.  Builds a Docker container to run subsequent steps within.
2.  Builds and checks your R package (with
    [**CRAN**](https://cran.r-project.org/) and/or
    [**Bioconductor**](https://bioconductor.org/) checks).  
3.  Runs [unit tests](https://testthat.r-lib.org/).  
4.  Runs [code coverage tests](https://covr.r-lib.org/) and uploads the
    results to [**Codecov**](https://about.codecov.io/).  
5.  (Re)builds and launches a documentation website for your R
    package.  
6.  Pushes an [**Rstudio**](https://posit.co/)
    [**Docker**](https://www.docker.com/) container to
    [**DockerHub**](https://hub.docker.com/) with your R package and all
    its dependencies pre-installed.

Importantly, this **workflow** is designed to work with any R package
out-of-the-box. This means you won’t have to manually edit any yaml
files, just run the `rworkflows::use_workflow()` function and you’re
ready to go!

> **Note**: `rworkflows` uses, was inspired by, and benefits from the
> work of many other projects, especially:  
> [`biocthis`](https://github.com/lcolladotor/biocthis),
> [`usethis`](https://github.com/r-lib/usethis),
> [`actions/`](https://github.com/actions),
> [`r-lib/actions`](https://github.com/r-lib/actions),
> [`bioc-actions`](https://github.com/grimbough/bioc-actions),
> [`JamesIves/github-pages-deploy-action`](https://github.com/JamesIves/github-pages-deploy-action),
> [`docker/build-push-action`](https://github.com/docker/build-push-action),
> [`bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker).
> For more details on how these projects relate to `rworkflows`, please
> see [below](#acknowledgments).

## Quickstart

Install and create the workflow in your R package’s project folder.

``` r
## in R

#### Install rworkflows R package ####
### For the stable CRAN release
if(!require("rworkflows")) install.packages("rworkflows")
### Or, for the latest development version
# if(!require("rworkflows")) remotes::install_github("neurogenomics/rworkflows")

### Create workflow file
path <- rworkflows::use_workflow()
```

Push to GitHub, and let everything else run automatically! You can check
the status of your workflow by clicking on the *Actions* tab in your
GitHub repo.

``` bash
## in the Terminal
git add .
git commit -m "Added rworkflows"
git push
```

**Note**: If you want to skip running **GitHub Actions** on a particular
push, simply add “\[skip ci\]” somewhere in the commit message, e.g.:
`git commit -m "Update README [skip ci]"`

## Documentation

### [Vignettes](https://neurogenomics.github.io/rworkflows/articles)

#### [Get started](https://neurogenomics.github.io/rworkflows/articles/rworkflows.html)

Introductory vignette for using `rworkflows`.

#### [Docker/Singularity](https://neurogenomics.github.io/rworkflows/articles/docker)

Copy-and-paste instructions for creating a **Docker** or **Singularity**
container with the `rworkflows` R package pre-installed.

#### [Dependency graph](https://neurogenomics.github.io/rworkflows/articles/depgraph).

Interactive graph showing all the GitHub repos that currently use the
`rworkflows` action.

### [Videos](https://www.youtube.com/@NeurogenomicsLab)

#### [rworkflows: taming the Wild West of R packages](https://youtu.be/nLIG2prEmCg)

Talk on the background, motivation, and utility of `rworkflows`.

#### [Getting into the flow with rworkflows: an introductory tutorial](https://youtu.be/vcpMsil3EAU)

Step-by-step tutorial showing how to use `rworkflows` in an R package.

### GitHub Secrets

To use certain features of `rworkflows`, you may need to set up one or
more [GitHub
Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets):

- `PAT_GITHUB` \[Optional\]: Can grant access to
  private repos on GitHub Actions. You can generate your very own
  Personal Authentication Token with `usethis::create_github_token()`.
  See the [GitHub docs](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
  for details.  
- `DOCKER_TOKEN` \[Optional\]: Allows GitHub Actions to push to a
  [DockerHub](https://hub.docker.com) account.

## Citation

If you use `rworkflows`, please cite:

<!-- Modify this by editing the file: inst/CITATION  -->

> Brian M. Schilder, Alan E. Murphy, & Nathan G. Skene (2023) The
> rworkflows suite: automated continuous integration for quality
> checking, documentation website creation, and containerised deployment
> of R packages, *Research Square*;
> <https://doi.org/10.21203/rs.3.rs-2399015/v1>

## Acknowledgments

`rworkflows` builds upon the work of many others, especially the
following:

### [`biocthis`](https://github.com/lcolladotor/biocthis)

This workflow is largely inspired by the workflow generated by the
[`use_bioc_github_action()`](https://lcolladotor.github.io/biocthis/articles/biocthis.html)
function within the
[`biothis`](http://www.bioconductor.org/packages/release/bioc/html/biocthis.html)
package, developed by @lcolladotor.

#### Key changes in `rworkflows`

- Uses dynamic variables to specify R/Bioconductor versions
  (e.g. `r: "latest"`) and the name of your R package, as opposed to
  static names that are likely to become outdated (e.g. `r: "4.0.1"`).  
- Additional error handling and dependencies checks.  
- Re-renders `README.Rmd` before rebuilding the documentation website.

### [`usethis`](https://github.com/r-lib/usethis)

`biocthis` was in turn inspired by `usethis`.

### [`actions/`](https://github.com/actions)

A general set of **GitHub Actions** maintained by the core GitHub team.

### [`r-lib/actions`](https://github.com/r-lib/actions)

A set of **GitHub Actions** for R development maintained by the
Rstudio/Posit team.

### [`bioc-actions`](https://github.com/grimbough/bioc-actions)

[Bioconductor](https://www.bioconductor.org/)-oriented **GitHub
Actions** created by @grimbough.

### [`JamesIves/github-pages-deploy-action`](https://github.com/JamesIves/github-pages-deploy-action)

Builds and deploys the **GitHub Pages** documentation website in the
`rworkflows` GHA workflows.

### [`docker/build-push-action`](https://github.com/docker/build-push-action)

A set of **GitHub Actions** for building/pushing **Docker** containers.

### [`bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker)

Uses the official
[`bioconductor/bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker)
**Docker** container.

**NOTE**: Whenever a new version of Bioconductor is released, the
`bioconductor/bioconductor_docker` container will often lag behind the
actual Bioconductor releases for up to several days, due to the time it
takes to update the container. This means that sometimes “devel” in
`Bioconductor/bioconductor_docker` is actually referring to the current
“release” version of Bioconductor (i.e. the previous Bioc version’s
“devel”). For further details, see this
[Issue](https://github.com/Bioconductor/bioconductor_docker/issues/37),
and the [Bioconductor release
schedule](https://www.bioconductor.org/about/release-announcements/).

### [`scFlow`](https://github.com/combiz/scFlow)

This Dockerfile was partly adapted from the [scFlow
Dockerfile](https://github.com/combiz/scFlow/blob/master/Dockerfile).
Unlike other Dockerfiles, this one **does not require any manual editing
when applying to different R packages**. This means that users who are
unfamiliar with **Docker** do not have to troubleshoot making this file
correctly. It also means that it will continue to work even if your R
package dependencies change.

### [`act`](https://github.com/nektos/act)

A very useful command line tool for testing **GitHub Actions** locally.

# Session Info

<details>

``` r
utils::sessionInfo()
```

    ## R version 4.2.1 (2022-06-23)
    ## Platform: x86_64-apple-darwin17.0 (64-bit)
    ## Running under: macOS Big Sur ... 10.16
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] here_1.0.1          rprojroot_2.0.3     digest_0.6.31      
    ##  [4] utf8_1.2.3          BiocFileCache_2.6.1 R6_2.5.1           
    ##  [7] stats4_4.2.1        RSQLite_2.3.1       evaluate_0.21      
    ## [10] httr_1.4.6          ggplot2_3.4.2       pillar_1.9.0       
    ## [13] yulab.utils_0.0.6   rworkflows_0.99.12  biocViews_1.66.3   
    ## [16] rlang_1.1.1         curl_5.0.0          data.table_1.14.8  
    ## [19] rstudioapi_0.14     whisker_0.4.1       blob_1.2.4         
    ## [22] DT_0.28             RUnit_0.4.32        rmarkdown_2.22     
    ## [25] desc_1.4.2          readr_2.1.4         stringr_1.5.0      
    ## [28] htmlwidgets_1.6.2   dlstats_0.1.7       BiocPkgTools_1.16.1
    ## [31] igraph_1.5.0.1      RCurl_1.98-1.12     bit_4.0.5          
    ## [34] munsell_0.5.0       compiler_4.2.1      xfun_0.39          
    ## [37] pkgconfig_2.0.3     BiocGenerics_0.44.0 rorcid_0.7.0       
    ## [40] htmltools_0.5.5     tidyselect_1.2.0    tibble_3.2.1       
    ## [43] httpcode_0.3.0      XML_3.99-0.14       fansi_1.0.4        
    ## [46] dplyr_1.1.2         tzdb_0.4.0          dbplyr_2.3.2       
    ## [49] bitops_1.0-7        rappdirs_0.3.3      crul_1.4.0         
    ## [52] grid_4.2.1          RBGL_1.74.0         jsonlite_1.8.4     
    ## [55] gtable_0.3.3        lifecycle_1.0.3     DBI_1.1.3          
    ## [58] magrittr_2.0.3      scales_1.2.1        graph_1.76.0       
    ## [61] cli_3.6.1           stringi_1.7.12      cachem_1.0.8       
    ## [64] renv_0.17.3         fauxpas_0.5.2       xml2_1.3.4         
    ## [67] rvcheck_0.2.1       filelock_1.0.2      generics_0.1.3     
    ## [70] vctrs_0.6.2         gh_1.4.0            RColorBrewer_1.1-3 
    ## [73] tools_4.2.1         bit64_4.0.5         Biobase_2.58.0     
    ## [76] glue_1.6.2          hms_1.1.3           fastmap_1.1.1      
    ## [79] yaml_2.3.7          colorspace_2.1-0    BiocManager_1.30.20
    ## [82] rvest_1.0.3         memoise_2.0.1       badger_0.2.3       
    ## [85] knitr_1.43

</details>
