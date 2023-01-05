# rworkflows 0.99.5

## New features

- Use actions:
  - `r-lib/setup-r-dependencies`
  - `r-lib/setup-tinytex`
  - `grimbough/bioc-actions/setup-bioc`
- New workflow args:
  - `timeout`
- Update *rworkflows_static.yml*

## Bug fixes

* Add `no-check-CRAN` arg to `BiocCheck` step to allow using bioc checks for 
  packages already on CRAN.
* Remove redundant "Install package" step (now handled within Dockerfile).

# rworkflows 0.99.4

## New features

* New functions:
  - `use_issue_template`
* Remove unnecessary *Suggests*:
    - `rvest`
    - `UpSetR`
    - `githubinstall`
    - `BiocManager`
    
* Automatically synchronize R and Bioc versions:
  - `bioc_r_versions`
  - `construct_runners`

## Bug fixes

* Fix workflows not getting filled with custom parameters.
  - Add unit tests to ensure this can't happen.
* Replace `rcmdcheck` `\link` with `\href`
* `use_badges`: remove unnecessary `ref` arg.

# rworkflows 0.99.3

## New features

* Add new arg `has_latex`
  - Added to action
  - Add to `use_workflow`
* New vignettes:
  - *depgraph*: Plot which R packages use the `rworkflow` action.
  - *repos*: Evaluate how R packages are distributed, 
    and get data on most downloaded packages.

# rworkflows 0.99.2

## New features

* `add_badges`
  - Check whether hex URL actually exists first.
* New functions:
  - `use_readme`
  - `use_vignette_docker`
  - `use_vignettte_getstarted`
* Only require R >4.1 (instead of 4.2) 
  bc that's when the native pipe `|>` was introduced.

  

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
