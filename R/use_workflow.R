#' Use GitHub Actions workflow
#' 
#' Create workflow that calls an 
#' \href{https://github.com/neurogenomics/rworkflows}{rworkflows}
#' \href{https://github.com/features/actions}{GitHub Actions (GHA)}  
#' @param template Workflow template name.
#' \itemize{
#' \item{"rworkflows"}{A short workflow script that calls
#'  the GitHub action from the GitHub Marketplace.
#' The action is continually updated 
#' so users do not need to worry about maintaining it.}
#' \item{"rworkflows_static"}{A longer workflow scripts that 
#' explicitly copies all steps from the \pkg{rworkflows} action
#' into a static file. Users may need to update this file themselves over time,
#' though this does allow for a fully customisable workflow.}
#' }
#' @param name An arbitrary name to call the workflow.
#' @param tag Which version of the \code{rworkflows} action to use. 
#' Can be a branch name on the
#'  \href{https://github.com/neurogenomics/rworkflows/branches}{
#'  GitHub repository} (e.g. "\@master"), 
#'  or a \href{https://github.com/neurogenomics/rworkflows/tags}{Release Tag} 
#'  (e.g. "\@v1").
#' @param on GitHub trigger conditions.
#' @param branches GitHub trigger branches.
#' @param runners Runner configurations for multiple Operating Systems (OS), 
#' including R versions, Bioc versions, and container sources.
#' Can use the \link[rworkflows]{construct_runners} functions to assist 
#' in constructing customized runners configurations.
#' @param run_bioccheck Run Bioconductor checks using
#' \href{https://doi.org/doi:10.18129/B9.bioc.BiocCheck}{
#' \code{BiocCheck::BiocCheck()}}. 
#' Must pass in order to continue workflow.
#' @param run_rcmdcheck Run R CMD checks using 
#' \href{https://rcmdcheck.r-lib.org/}{\code{rcmdcheck::rcmdcheck()}}. 
#' Must pass in order to continue workflow.
#' @param as_cran When running R CMD checks, 
#' use the '--as-cran' flag to apply CRAN standards
#' @param has_testthat Run unit tests and report results.
#' @param run_covr Run code coverage tests and publish results to codecov.
#' @param run_pkgdown Knit the \emph{README.Rmd} (if available), 
#' build documentation website, and deploy to \emph{gh-pages} branch.
#' @param has_runit Run R Unit tests.
#' @param run_docker Whether to build and push a Docker container to DockerHub.
#' @param has_latex Install a suite of LaTeX dependencies used for 
#' rendering Sweave (.rnw) and other documentation files.
#' @param tinytex_installer  Which release of tinytex (bundles of LaTeX
#'  packages) to use. All options can be found 
#'  \href{https://github.com/rstudio/tinytex-releases/}{here}.
#'  Note, 'TinyTeX-2' is only available for \code{tinytex_version='daily'}.
#' @param tinytex_version  Which version of tinytex to use. 
#' When set to '', uses the latest daily build.
#' All versions can be found 
#' \href{https://github.com/rstudio/tinytex-releases/releases}{here}.
#' @param pandoc_version Which version of pandoc to use.
#' For details see  
#' \href{https://github.com/r-lib/actions/tree/v2-branch/setup-pandoc}{here}.
#' @param github_token GitHub authentication token with permissions to push 
#' to the R package's GitHub repository. 
#' Also used to bypass GitHub download limits.
#' By default, uses \{\{ secrets.GITHUB_TOKEN \}\}
#' which is automatically set up by GitHub. 
#' However users can also choose to pass a custom GitHub secret variable
#' (e.g. \{\{ secrets.PAT_GITHUB \}\}) which allows access to private
#'  repositories.
#' Read 
#' \href{https://docs.github.com/en/actions/security-guides/automatic-token-authentication}{
#' here for more details}.
#' @param docker_user DockerHub username.
#' @param docker_org DockerHub organization name. 
#' Is the same as \code{docker_user} by default.
#' @param docker_token DockerHub token.
#' @param force_new If the GHA workflow yaml already exists, 
#' overwrite with new one (default: \code{FALSE}).
#' 
#' @param save_dir Directory to save workflow to.
#' @param return_path Return the path to the saved \emph{yaml} workflow file
#' (default: \code{TRUE}), or return the \emph{yaml} object directly.
#' @param cache_version Name of the cache sudirectory to be used
#'  when reinstalling software in GHA.
#' @param run_vignettes Build and check R package vignettes.
#' @param enable_act Whether to add extra lines to the yaml to 
#' enable local workflow checking with 
#' \href{https://github.com/nektos/act}{act}.
#' @param miniforge_variant If provided, this variant of Miniforge will be
#'  downloaded and installed. If \code{miniforge_variant=false}, 
#'  Miniforge will not be installed at all.
#'  If \code{miniforge_variant=""}, the "Miniforge3" variant will be installed.
#'  If \code{miniforge_version} is not provided, the \code{latest} 
#'  version will be used.
#'  Currently-known values: - "Miniforge3" (default) - "Miniforge-pypy3" -
#'  "Mambaforge" - "Mambaforge-pypy3".
#'  Visit
#'  https://github.com/conda-forge/miniforge/releases/ for more information on
#'  available variants.
#' @param miniforge_version If provided, this version of the given Miniforge
#'  variant will be downloaded and installed. If \code{miniforge_variant} is 
#'  not provided, "Miniforge3" will be used. Visit
#'  https://github.com/conda-forge/miniforge/releases/ for more information on
#'  available versions.
#' @param activate_environment Environment name (or path) to activate on all 
#' shells. Default is "test" which will be created in \emph{$CONDA/envs/test}. 
#' If an empty string is used, no environment is activated by default 
#' (For "base" activation see the \code{auto-activate-base} option). 
#' If the environment does not exist, it will
#' be created and activated. If \code{environment-file} is used and you want 
#' that to be the environment used, you need to explicitly provide the name of
#' that environment on \code{activate-environment}. 
#' If using \code{sh/bash/cmd.exe}
#' shells please read the IMPORTANT! section on the README.md! to properly
#' activate conda environments on these shells.
#' @param environment_file Path or URL to a .yml file to build the 
#' conda environment with. For more information see
#' \href{https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-from-an-environment-yml-file}{
#' here}.
#' @param channels  Conda configuration. Comma separated list of channels 
#' to use in order of priority. See
#' \href{https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/}{here}
#' for more information.
#' @param preview Print the yaml file to the R console.
#' @param verbose Print messages.
#' @returns Path or yaml object.
#' 
#' @source \href{https://github.com/vubiostat/r-yaml/issues/5}{
#' Issue reading in "on:"/"y","n" elements}.
#' @source \href{https://github.com/vubiostat/r-yaml/issues/123}{
#' Issue writing "on:" as "'as':"}
#' 
#' @export
#' @importFrom here here
#' @importFrom yaml as.yaml read_yaml write_yaml yaml.load
#' @examples
#' path <- use_workflow(save_dir = file.path(tempdir(),".github","workflows"))
use_workflow <- function(## action-level args
                         template="rworkflows",
                         name=template,
                         tag="@master",
                         on=c("push","pull_request"),
                         branches=c("master","main","devel","RELEASE_**"),
                         runners=construct_runners(),
                         ## workflow-level args
                         ### General
                         github_token="${{ secrets.GITHUB_TOKEN }}",
                         cache_version="cache-v1",
                         enable_act=FALSE,
                         ### Checks
                         run_bioccheck=FALSE,
                         run_rcmdcheck=TRUE, 
                         as_cran=TRUE,
                         run_vignettes=TRUE,
                         has_testthat=TRUE, 
                         has_runit=FALSE,
                         run_covr=TRUE, 
                         ### Latex
                         has_latex=FALSE,
                         tinytex_installer='TinyTeX-1',
                         tinytex_version=NULL, 
                         pandoc_version='2.19',
                         ### Site 
                         run_pkgdown=TRUE,   
                         ### Container
                         run_docker=FALSE,  
                         docker_user=NULL,
                         docker_org=docker_user,
                         docker_token="${{ secrets.DOCKER_TOKEN }}",
                         ### Miniconda
                         miniforge_variant=FALSE,
                         miniforge_version=NULL,
                         activate_environment="test",
                         environment_file=NULL,
                         channels=NULL,
                         ## function-level args
                         save_dir=here::here(".github","workflows"),
                         return_path=TRUE,
                         force_new=FALSE,
                         preview=FALSE,
                         verbose=TRUE){
  
  # devoptera::args2vars(use_workflow);  docker_org <- eval(docker_org)   

  #### Construct yaml path ####
  path <-if(is.null(save_dir)){
    NULL
  } else {
    file.path(save_dir,paste0(name,".yml"))
  }
  #### Check for existing yaml ####
  if(!is.null(path) && 
     file.exists(path) &&
     isFALSE(force_new)){
    messager("Using existing workflow file:",path,v=verbose) 
    yml <- yaml::read_yaml(path)
    #### Preview ####
    if(isTRUE(preview)){
      cat(yaml::as.yaml(yml)) 
    }
    #### Return ####
    if(isTRUE(return_path)){
      return(path)
    } else {
      return(yml)
    }
  }
  #### Read yaml template ####
  yml <- get_yaml(template = template)
  #### Fill yaml template ####
  yml <- fill_yaml(yml=yml,
                   ## action-level args
                   name=name,
                   template=template,
                   tag=tag,
                   on=on,
                   branches=branches,
                   runners=runners,
                   ## workflow-level args
                   run_bioccheck=run_bioccheck,
                   run_rcmdcheck=run_rcmdcheck, 
                   as_cran=as_cran,
                   run_vignettes=run_vignettes,
                   has_testthat=has_testthat, 
                   run_covr=run_covr, 
                   run_pkgdown=run_pkgdown, 
                   has_runit=has_runit, 
                   has_latex=has_latex,
                   tinytex_installer=tinytex_installer,
                   tinytex_version=tinytex_version,
                   pandoc_version=pandoc_version,
                   run_docker=run_docker,  
                   github_token=github_token,
                   docker_user=docker_user,
                   docker_org=docker_org,
                   docker_token=docker_token,
                   miniforge_variant=miniforge_variant,
                   miniforge_version=miniforge_version,
                   activate_environment=activate_environment,
                   environment_file=environment_file,
                   channels=channels,
                   cache_version=cache_version,
                   enable_act=enable_act)
  #### Preview ####
  if(isTRUE(preview)){
    preview_yaml(yml=yml) 
  }
  #### Save yaml #### 
  handlers <- list('bool#yes' = function(x){"${{ true }}"},
                   'bool#no' = function(x){"${{ false }}"})
  path_or_yaml <- return_yaml(yml=yml,
                              path=path,
                              return_path=return_path,
                              handlers=handlers,
                              verbose=verbose)
  return(path_or_yaml)
}
