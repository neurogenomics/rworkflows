<img src='https://github.com/neurogenomics/rworkflows/raw/master/inst/hex/hex.png' title='Hex sticker for rworkflows' height='350'><br>
[![](https://www.r-pkg.org/badges/version/rworkflows?color=black)](https://cran.r-project.org/package=rworkflows)
[![](http://cranlogs.r-pkg.org/badges/last-month/rworkflows?color=black)](https://cran.r-project.org/package=rworkflows)
[![](http://cranlogs.r-pkg.org/badges/grand-total/rworkflows?color=black)](https://cran.r-project.org/package=rworkflows)
[![License:
GPL-3](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://cran.r-project.org/web/licenses/GPL-3)
[![](https://img.shields.io/badge/doi-https://doi.org/10.5281/zenodo.10048573-blue.svg)](https://doi.org/https://doi.org/10.5281/zenodo.10048573)
<br>
[![](https://img.shields.io/badge/devel%20version-1.0.7-black.svg)](https://github.com/neurogenomics/rworkflows)
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
README updated: <i>Jan-23-2025</i>  
</h4>

[![CRAN
checks](https://badges.cranchecks.info/worst/rworkflows.svg)](https://cran.r-project.org/web/checks/check_results_rworkflows.html)

## 📘 Citation

If you use `rworkflows`, please cite:

<!-- Modify this by editing the file: inst/CITATION  -->

> Schilder, B.M., Murphy, A.E. & Skene, N.G. rworkflows: automating
> reproducible practices for the R community. Nat Commun 15, 149 (2024).
> <https://doi.org/10.1038/s41467-023-44484-5>

### 📖 Background

`rworkflows` is a suite of tools to make it easy for R developers to
implement reproducible best practices on GitHub.

It includes three main components:  
1. [**`templateR`
template**](https://github.com/neurogenomics/templateR): a
`CRAN`/`Bioc`-compatible R package template that automatically generates
essential documentation using package metadata.  
2. [**`rworkflows` R
package**](https://github.com/neurogenomics/rworkflows/blob/master/DESCRIPTION):
a lightweight `CRAN` package to automatically set up short, customisable
workflows that trigger the `rworkflows` action.  
3. [**`rworkflows`
action**](https://github.com/neurogenomics/rworkflows/blob/master/action.yml):
an open-source action available on the [GitHub Actions
Marketplace](https://github.com/marketplace/actions/rworkflows).

### ⚙️ `rworkflows` action steps

[**GitHub Actions**](https://docs.github.com/en/actions) are a powerful
way to automatically launch workflows every time you push changes to a
GitHub repository. This is a form of [**Continuous
Integration/Deployment
(CI/CD)**](https://docs.github.com/en/actions/automating-builds-and-tests/about-continuous-integration),
which helps ensure that your code is always working as expected (without
having to manually check each time).

Here, we have designed a robust, reusable, and flexible **action**
specifically for the development of R packages. We also provide an R
function to automatically generate a **workflow file** that calls the
`rworkflows` composite action:

Currently, `rworkflows` **action** can perform the following tasks (with
options to enable/disable/modify each step):

1.  🐳 Builds a Docker container to run subsequent steps within.
2.  🐍 Builds and/or activates a custom `conda` environment.
3.  🛠️ Installs system dependencies
4.  🛠️ Installs LaTeX dependencies.
5.  🛠 Installs R dependencies.
6.  ✅ Builds and checks your R package (with
    [**CRAN**](https://cran.r-project.org/) and/or
    [**Bioconductor**](https://bioconductor.org/) checks).  
7.  📋 Runs [unit tests](https://testthat.r-lib.org/).  
8.  📋 Runs [code coverage tests](https://covr.r-lib.org/) and uploads
    the results to [**Codecov**](https://about.codecov.io/).  
9.  🚀 (Re)builds and launches a documentation website for your R
    package.  
10. 🐳 Pushes a [**Docker**](https://www.docker.com/) container (with
    [**Rstudio**](https://posit.co/) and all dependencies pre-installed)
    to your choice of container registry (e.g. [**GitHub Container
    Registry**](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry),
    [**DockerHub**](https://hub.docker.com/)).
11. 🔭 Generates [workflow
    telemetry](https://github.com/catchpoint/workflow-telemetry-action)
    report.  
12. 🎖 Updates relevant badges added to your README with
    `rworkflows::use_badges()`.

Importantly, this **workflow** is designed to work with any R package
out-of-the-box. This means you won’t have to manually edit any yaml
files, just run the `rworkflows::use_workflow()` function and you’re
ready to go within seconds!

> **🙏 Acknowledgements**: `rworkflows` uses, was inspired by, and
> benefits from the work of [many other projects](#acknowledgments),
> especially: [`biocthis`](https://github.com/lcolladotor/biocthis),
> [`usethis`](https://github.com/r-lib/usethis),
> [`actions/`](https://github.com/actions),
> [`r-lib/actions`](https://github.com/r-lib/actions),
> [`bioc-actions`](https://github.com/grimbough/bioc-actions),
> [`JamesIves/github-pages-deploy-action`](https://github.com/JamesIves/github-pages-deploy-action),
> [`docker/build-push-action`](https://github.com/docker/build-push-action),
> [`bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker).

## ⏩ Quickstart

Install and create the workflow in your R package’s project folder.

In R (only need to do once per repository):

``` r
### 1. Install stable CRAN release
if(!require("rworkflows")) install.packages("rworkflows")
### Or, install latest development version
# if(!require("rworkflows")) remotes::install_github("neurogenomics/rworkflows")

### 2. Create workflow file
path <- rworkflows::use_workflow()
```

Then, in the Terminal:

``` bash
### 3. Push to GitHub
git add .
git commit -m "Added rworkflows" # Arbitrary commit message
git push
```

Now you can let everything run on GitHub automatically! You can check
the status of your workflow by clicking on the [*Actions*
tab](https://github.com/neurogenomics/rworkflows/actions) in your GitHub
repo.

### 🤫 Special commit messages

Including special keywords in your commit message will have a certain
effect:  
- `"[skip ci]"`: will skip running the workflow on this push.  
- `"[nodocker]"`: will skip any Docker registry steps.  
- `"[noncache]"`: will not use any cached installations or files.

For example: `git commit -m "Update README [skip ci]"` will skip running
any GitHub Actions.

### 🔐 GitHub Secrets

To use certain features of `rworkflows`, you may need to set up one or
more [GitHub
Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets):

- `PAT_GITHUB` \[Optional\]: Can grant access to private repos on GitHub
  Actions. You can generate your very own Personal Authentication Token
  with `usethis::create_github_token()`. [See
  more](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).  
- `DOCKER_TOKEN` \[Optional\]: Allows GitHub Actions to push to a
  [DockerHub](https://hub.docker.com) account. [See
  more](https://docs.docker.com/security/for-developers/access-tokens/).  
- `CODECOV_TOKEN` \[Optional\]: Bypasses issues that occasionally arise
  from GitHub API limits. [See
  more](https://docs.codecov.com/reference/overview).
- `GitHub Variables` \[Optional\]: These are default variables that are
  automatically set by GitHub Actions. [See
  more](https://docs.github.com/en/actions/reference/environment-variables#default-environment-variables).

## 📚 Documentation

### [🧑‍🎓 Vignettes](https://neurogenomics.github.io/rworkflows/articles/)

- [📖 **Get
  started**](https://neurogenomics.github.io/rworkflows/articles/rworkflows.html):
  Introductory vignette for using `rworkflows`.  
- [🐳
  **Docker/Singularity**](https://neurogenomics.github.io/rworkflows/articles/docker):
  Copy-and-paste instructions for creating a **Docker** or
  **Singularity** container with the `rworkflows` R package
  pre-installed.  
- [🕸️ **Dependency
  graph**](https://neurogenomics.github.io/rworkflows/articles/depgraph):
  Interactive graph showing all the GitHub repos that currently use the
  `rworkflows` action.

### [🎥 Videos](https://www.youtube.com/@NeurogenomicsLab)

- [🤠 **rworkflows: taming the Wild West of R
  packages**](https://youtu.be/nLIG2prEmCg): Talk on the background,
  motivation, and utility of `rworkflows`.  
- [🌊 **Getting into the flow with rworkflows: an introductory
  tutorial**](https://youtu.be/vcpMsil3EAU): Step-by-step tutorial
  showing how to use `rworkflows` in an R package.

## 🙏 Acknowledgments

`rworkflows` builds upon the work of many others, especially the
following:

- [`biocthis`](https://github.com/lcolladotor/biocthis): This workflow
  is largely inspired by the workflow generated by the
  [`use_bioc_github_action()`](https://lcolladotor.github.io/biocthis/articles/biocthis.html)
  function within the
  [`biothis`](https://www.bioconductor.org/packages/release/bioc/html/biocthis.html)
  package, developed by @lcolladotor. Key changes in `rworkflows`
  - Uses dynamic variables to specify R/Bioconductor versions
    (e.g. `r: "latest"`) and the name of your R package, as opposed to
    static names that are likely to become outdated
    (e.g. `r: "4.0.1"`).  
  - Additional error handling and dependencies checks.  
  - Re-renders `README.Rmd` before rebuilding the documentation
    website.  
  - Conda support
  - Ability to change registry  
- [`usethis`](https://github.com/r-lib/usethis): `biocthis` was in turn
  inspired by `usethis`.  
- [`actions/`](https://github.com/actions): A general set of **GitHub
  Actions** maintained by the core GitHub team.  
- [`r-lib/actions`](https://github.com/r-lib/actions): A set of **GitHub
  Actions** for R development maintained by the Rstudio/Posit team.  
- [`bioc-actions`](https://github.com/grimbough/bioc-actions)
  [Bioconductor](https://www.bioconductor.org/)-oriented **GitHub
  Actions** created by @grimbough.  
- [`JamesIves/github-pages-deploy-action`](https://github.com/JamesIves/github-pages-deploy-action):
  Builds and deploys the **GitHub Pages** documentation website in the
  `rworkflows` GHA workflows.  
- [`docker/build-push-action`](https://github.com/docker/build-push-action):
  A set of **GitHub Actions** for building/pushing **Docker**
  containers.  
- [`bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker):
  Uses the official
  [`bioconductor/bioconductor_docker`](https://github.com/Bioconductor/bioconductor_docker)
  **Docker** container.
  - **Note**: Whenever a new version of Bioconductor is released, the
    `bioconductor/bioconductor_docker` container will often lag behind
    the actual. Bioconductor releases for up to several days, due to the
    time it takes to update the container. This means that sometimes
    “devel” in `Bioconductor/bioconductor_docker` is actually referring
    to the current “release” version of Bioconductor (i.e. the previous
    Bioc version’s “devel”). For further details, see this
    [Issue](https://github.com/Bioconductor/bioconductor_docker/issues/37),
    and the [Bioconductor release
    schedule](https://www.bioconductor.org/about/release-announcements/).  
- [`scFlow`](https://github.com/combiz/scFlow): The `rworkflows`
  Dockerfile template was partly adapted from the [scFlow
  Dockerfile](https://github.com/combiz/scFlow/blob/master/Dockerfile).
  Unlike other Dockerfiles, this one does not require any manual editing
  when applying to different R packages. This means that users who are
  unfamiliar with **Docker** do not have to troubleshoot making this
  file correctly. It also means that it will continue to work even if
  your R package dependencies change.
- [`act`](https://github.com/nektos/act): A very useful command line
  tool for testing **GitHub Actions** locally.
- [`actions/runner-images`](https://github.com/actions/runner-images):
  Runner images for each OS provided by GitHub.  
- [`actions/setup-miniconda`](https://github.com/marketplace/actions/setup-miniconda):
  GitHub Action to setup Miniconda and conda environments.

## ℹ Session Info

<details>

``` r
utils::sessionInfo()
```

    ## R version 4.4.2 (2024-10-31)
    ## Platform: aarch64-apple-darwin20
    ## Running under: macOS Sequoia 15.2
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRblas.0.dylib 
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## time zone: America/New_York
    ## tzcode source: internal
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] gtable_0.3.6        jsonlite_1.8.9      renv_1.0.11        
    ##  [4] dplyr_1.1.4         compiler_4.4.2      BiocManager_1.30.25
    ##  [7] tidyselect_1.2.1    rvcheck_0.2.1       scales_1.3.0       
    ## [10] yaml_2.3.10         fastmap_1.2.0       here_1.0.1         
    ## [13] ggplot2_3.5.1       R6_2.5.1            generics_0.1.3     
    ## [16] knitr_1.49          yulab.utils_0.1.9   tibble_3.2.1       
    ## [19] desc_1.4.3          dlstats_0.1.7       munsell_0.5.1      
    ## [22] rprojroot_2.0.4     pillar_1.10.1       RColorBrewer_1.1-3 
    ## [25] rlang_1.1.4         badger_0.2.4        xfun_0.50          
    ## [28] fs_1.6.5            cli_3.6.3           magrittr_2.0.3     
    ## [31] rworkflows_1.0.5    digest_0.6.37       grid_4.4.2         
    ## [34] rstudioapi_0.17.1   lifecycle_1.0.4     vctrs_0.6.5        
    ## [37] evaluate_1.0.1      glue_1.8.0          data.table_1.16.4  
    ## [40] colorspace_2.1-1    rmarkdown_2.29      tools_4.4.2        
    ## [43] pkgconfig_2.0.3     htmltools_0.5.8.1

</details>
