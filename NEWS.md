# rworkflows 0.99.15

## New features

* Add *.devcontainer/devcontainer.json*

# rworkflows 0.99.14

## New features

* Add step to enable conda envs: #78
  - Add subfunction: `gha_python_versions()` within `construct_runners`
  - Add new *action.yml* args:
    - `miniforge_variant`
    - `miniforge_version`
    - `activate_environment`
    - `environment_file`
    - `channels`
  - New function to construct conda env yaml files:
    - `construct_conda_yml`
  - New unit tests to test `construct_conda_yml` and building conda envs 
  from the generated yamls.
* `fill_yaml` 
  - Add subfunction `is_default`
* *actions.yml*:
  - Add `force=TRUE` to the `remotes::install_local` steps. #86
  - Add `runforesight/workflow-telemetry-action` step.
  - Avoid setting `rspm` explicitly by default.
* `construct_cont`:
  - Make registry explicit.
  - New arg: `default_registry`
  - New subfunction: `check_registry`
* Add `docker_registry` arg to let users choose which registry to push to. 
  Defaults to "ghcr.io" instead of "docker.io" so that no additional credentials 
  are needed.
  - *actions.yml*
  - `use_workflow`
* `get_github_url_desc`
  - Improve logic to catch more GH URLs.
* *vignettes/depgraph.Rmd*
  - Update plots with new data and resave PNG.
* New arg `free_diskspace`
  - *actions.yml*
  - `use_workflow`
* `use_workflow`
  - `template` arg can now be "rworkflows_static:dev" to use the "dev" branch's 
  version of *action.yml* as a workflow template.

## Bug fixes

* `no visible global function definition for internal function check_miniconda_args`
  - This weird error only came up during Rstudio R CMD checks. 
  The function `check_miniconda_args` was clearly defined in its own file. 
  The only way to fix it was copying the function into the same one where it
  was called `fill_yaml`.
  - Thought it might be a permissions issues with *check_miniconda_args.R* but 
  the permissions are identical with all the others.
* *action.yml*
  - Remove unnecessary  export:`echo "GITHUB_TOKEN=${{ inputs.GITHUB_TOKEN }}" >> $GITHUB_ENV`
  - Fix `runforesight/workflow-telemetry-action` step and move to top.

# rworkflows 0.99.13

## New features

* Merge PR #66 by @js2264 to eliminate the PAT_GITHUB secret setup step.
* Merge PR #71 by @js2264 to skip vignettes when building if `run_vignettes`.
* Add fun emojis to action.
* Add vignette for checking Sweave (.Rnw) files can be rendered. 
* *action.yml*
  - Add new args to control latex: 
    `tinytex_installer`, `tinytex_version`, `pandoc_version`
  - Install extra latex deps using one step for all OS via `tinytex` R package.
* `construct_runners`
  - Simplify arguments so that user doesn't have to pass OS names.
  - When an arg like `bioc` is of length one, the same value is automatically
    applied across all 3 OS.
* *bioconductor.Rmd*
  - Add vignette specifically for Bioconductor packages.
* `use_workflow`
  - Split `name` arg into two args: `name` + `template`, 
    so that you can create multiple separate workflow files 
    using the same template.
  - Add new args to control latex: 
    `tinytex_installer`, `tinytex_version`, `pandoc_version`
  - New internal subfunctions:
    - `save_yaml`
    - `check_bioc_version`
    - `check_r_version`
  - New exported subfunction: `construct_cont`
* Transition `BiocPkgTools` + `biocViews` to Suggests
  - Based on recc from CRAN maintainers, as they do not consistently 
    install/update Bioc packages on the CRAN server.
* `fill_yaml`
  - Simplify code.
  - Add subfunction `omit_if_default` to omit tinytex args from yaml.
* `is_rstudio`: new interal helper function.
* Update *rworkflows_static.yml*
* Sync Docker vignettes with registry #99

## Bug fixes

* Add "devel" as trigger branch in all 3 workflows.
* Harmonise `github_token` parameter docs between 
  *action.yml* and `use_workflow`.
* CRAN checks:
  - Downgrade `BiocPkgTools`/`biocViews` to Suggests to 
    compensate for issues with the CRAN server: #65
* `fill_yaml`:
  - When `template="rworkflows_static"`, prevent `with2` from simplifying to vector.
* `construct_runners`
  - `rspm` wasn't getting added.
* `get_github_url_db`
  - Properly coalesce hits from multiple columns searched for GitHub URLs.

# rworkflows 0.99.12

## New features

* Reduce clutter by removing subaction folders (will eventually come back to this idea). 

## Bug fixes

* CRAN's VMs are having issues. 
* Reduce `docs` size by rendering PNG instead of html in `depgraph` vignette.
* Get code coverage back up to 91%+
* Revamp `get_hex` and `get_description` 
  - Use lists more consistently
  - More robust in general
* `get_description`
  - Actually use `use_repos` arg.
* Fix "Documented arguments not in \usage in documentation object 'get_description_repo': 'pkgs'""
* Ensure all documented functions have `@returns` in Roxygen notes.
* `action.yml`
  - "Install dependencies pass 1" step was calling `repos` before it was defined.

# rworkflows 0.99.11

## New features

* Switch to using `bibentry` for CITATION.

To compensate for this had to modify `test-bioc_r_versions`.

# rworkflows 0.99.10

## New features

* `use_workflow`
  - Add "devel" as a new default trigger `branch` to align with [Bioc's recent changes to their standards](https://blog.bioconductor.org/posts/2023-03-01-transition-to-devel/).
* Increase code coverage:
  - Expand `get_description` unit tests.
  - Add `construct_authors` unit tests.
  - Fix (sort of) `infer_biocviews` tests.
  
## Bug fixes

- Fixed parsing error when writing "rworkflows_static". #60
- Get args from 'env.' (for workflows) instead of 'inputs.' (for actions)
- Update links with redirects
- `codecov_graphs`: Fix link with redirect.

# rworkflows 0.99.9

## New features

* Pass `timeout` arg to R package installation steps too.

## Bug fix

* Remove explicit `AnVIL` usage, as the URLs are now deprecated and `BiocManager` uses the pre-compiled binaries by default.

# rworkflows 0.99.8

## New features
 
* `get_description`
  - Supplying a `description` obj directly to any argument returns that obj.
  - Reorder strategies so that local ones go first.
  - Add Liam Neeson reference.
  - Now caches DESCRIPTION files.
  - Add validation step at the end.
  - Upgrade to handle multiple `refs` at once 
  - Add another subroutine for getting DESCRIPTION files from CRAN/Bioc 
* `get_hex`
  - Now iterable
* Add `output` style arg to vignette functions.
* `use_vignette_docker`
  - Let users select `port_in` and `port_out`
  - Make default `port_out=8900` to align with the available 
    Imperial Private Cloud ports (8900-9000).

# rworkflows 0.99.7

## New features

* New functions: `fill_description`
* New function: `infer_deps`
* New function: `infer_biocviews`
* New function: `is_gha`
* Add yaml file to test workflow *rworkflows_dev*  
* Run `BiocCheck` in rworkflow yamls.
* Make all `require()` calls in *action.yml* quiet.
* Further increase code coverage.  
* `use_badges`
  - Add new arg for `add_codecov_graphs`
  - Subfunction `codecov_graphs` 
  - Rearrange badges in a logical order
  - Add more breaks
* `bioc_r_version`:
  - Add new arg `depth` and internal func `parse_version`
* `get_hex` / `use_badges`
  - When `add_hex` is a character string, interpret it as the hex path instead.
* `use_badges`
  - Add `add_lifecycle`: `badger::badge_lifecycle()`

## Bug fixes

* Add `biocViews: WorkflowManagement`
* Try to fix *NEWS.md* formatting for all platforms.
* Lengthen Description field.
* `get_hex`: Remove extra breaks
* Fix bad quotes in `if` statements when *rworkflows_static* gets saved.


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
