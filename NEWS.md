# rworkflows 0.99.2

## New features

* `add_badges`
  - Check whether hex URL actually exists first.
* New functions:
  - `use_readme`
  - `use_vignette_docker`
  - `use_vignettte_getstarted`
* New vignettes:
  - *depgraph*: Plot which R packages use the `rworkflow` action.
  - *repos*: Evaluate how R packages are distributed, 
    and get data on most downloaded packages.
* Only require R >4.1 (instead of 4.2) 
  bc that's when the native pipe `|>` was introduced.
* Add new arg `has_latex`
  - Added to action
  - Add to `use_workflow`
  

## Bug fixes

* Make `badger` a *Import*
* Use Dockerfile stored in *inst/templates* instead of getting from GitHub.
* Fix `vignette` field in `use_vignette_*` functions.
* Fix pdflatex-related errors on all 3 OS.

# rworkflows 0.99.1

## New features

* Renamed workflow args:
  - `run_crancheck` --> `run_rcmdcheck`
  - `DOCKER_ORG` --> `docker_org`
  - `DOCKER_USERNAME` --> `docker_user`
* Added new args:
  - `as_cran`: separate from `run_rcmdcheck`
  - `tag`: specify action version.
* Set default: `use_workflow(run_docker=FALSE)` 
* Removed unused args: `repository`
* Add 'RELEASE_**' as one of the default trigger branches (for Bioconductor).
* New function: `badge`


## Bug fixes

* Make sure all docker args actually get modified in template.
* Set default docker_org/docker_user to 

# rworkflows 0.99.0

## New features

* Added a `NEWS.md` file to track changes to the package.
