# rworkflows 0.99.7

## New features

* New function: `fill_description`
* New function: `infer_deps`
* Add yaml file to test workflow *rworkflows_dev*  
* Run `BiocCheck` in rworkflow yamls.
* Make all `require()` calls in *action.yml* quiet.
* Further increase code coverage.

## Bug fixes

* Add `biocViews: WorkflowManagement`
* Try to fix *NEWS.md* formatting for all platforms.
* Lengthen Description field.
* `get_hex`: Remove extra breaks

# rworkflows 0.99.6

## New features

* Improve code coverage.
  - Remove `is_default` as it is never used. Document in gist for later use:
    https://gist.github.com/bschilder/f02a5b564977f52fd665728a22c0d005
* `use_badges`:
  - Pass up `pkg` arg for explicit package specification.
  - Make default hex height 300.
  - Make CRAN badge color yellow.
* New function:
  - `get_description`

## Bug fixes

* `use_badges`:
  - Enable alternative ways of getting DESCRIPTION. 
  - Use `ref` and `pkg` explicitly in relevant functions to avoid inference.
* Remove embedded HTML from *depgraph.Rmd* vignette, 
  as it induces a NOTE in CRAN checks that the package is too large.

# rworkflows 0.99.5

## New features

* Use actions:
  - `r-lib/setup-r-dependencies`
  - `r-lib/setup-tinytex`
  - `grimbough/bioc-actions/setup-bioc`
* New workflow args:
  - `timeout`
* Update *rworkflows_static.yml*
* Remove unnecessary lines from *.Rbuildignore*, 
  as this is now taken care of internally by `r-lib/setup-r-dependencies`
  - `node_modules$`
  - `package-lock\.json$`
  - `package\.json$` 

## Bug fixes

* Add `no-check-CRAN` arg to `BiocCheck` step to allow using bioc checks for 
  packages already on CRAN.
* Remove redundant "Install package" step (now handled within Dockerfile).
* Fix `get_hex` in cases where multiple links in *DESCRIPTION* URL.
* Fix CodeCov checking and upload step.

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
