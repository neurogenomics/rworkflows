#' Use GitHub Actions workflow
#' 
#' Create workflow that calls an 
#' \href{https://github.com/neurogenomics/rworkflows}{rworkflows}
#' \href{https://github.com/features/actions}{GitHub Actions (GHA)}  
#' @param name Workflow name.
#' @param on GitHub trigger conditions.
#' @param branches GitHub trigger branches.
#' @param run_bioccheck Run Bioconductor checks. 
#' Must pass in order to continue workflow.
#' @param run_crancheck Run CRAN checks. 
#' Must pass in order to continue workflow.
#' @param has_testthat Run unit tests and report results.
#' @param run_covr Run code coverage tests and publish results to codecov.
#' @param run_pkgdown Knit the \emph{README.Rmd} (if available), 
#' build documentation website, and deploy to \emph{gh-pages} branch.
#' @param has_runit Run R Unit tests.
#' @param run_docker Whether to build and push a Docker container to DockerHub.
#' @param repository GitHub repository to be checked.
#' @param github_token Token for the repo. 
#' Can be passed in using {{ secrets.PAT_GITHUB }}.
#' @param docker_username DockerHub username.
#' @param docker_org DockerHub organization name. 
#' Is the same as \code{docker_username} by default.
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
#' @param preview Print the yaml file to the R console.
#' @param verbose Print messages.
#' @returns Path or yaml object.
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
use_workflow <- function(name="rworkflows",
                         on=c("push","pull_request"),
                         branches=c("master","main"),
                         ## with: args ##
                         run_bioccheck=FALSE,
                         run_crancheck=TRUE, 
                         run_vignettes=TRUE,
                         has_testthat=TRUE, 
                         run_covr=TRUE, 
                         run_pkgdown=TRUE, 
                         has_runit=FALSE, 
                         run_docker=TRUE, 
                         repository="${{ github.repository }}",
                         github_token="${{ secrets.PAT_GITHUB }}",
                         docker_username=NULL,
                         docker_org=docker_username,
                         docker_token="${{ secrets.DOCKER_TOKEN }}",
                         cache_version="cache-v1",
                         enable_act=TRUE,
                         ## function args ##
                         save_dir=here::here(".github","workflows"),
                         return_path=TRUE,
                         force_new=FALSE,
                         preview=FALSE,
                         verbose=TRUE){
  
  # templateR:::source_all()
  # templateR:::args2vars(use_workflow) 
  # docker_org <- eval(docker_org)
  
  
  ## Custom handler prevents "on" from being converted to TRUE
  handlers <- list('bool#yes' = function(x) { if (x == "on") x else TRUE})
  if(is.null(name) || name=="rworkflows"){
    yml <- yaml::read_yaml(
      system.file("yaml","rworkflows_template.yml",
                  package = "rworkflows"),
      handlers = handlers)
    #### name ####
    yml$name <- name
    #### on ####
    on2 <- lapply(stats::setNames(on,on),
                  function(x){list("branches"=branches)})
    yml$on <- on2
    #### with: args ####
    with2 <- yml$jobs[[1]]$steps[[2]]$with
    with2$run_bioccheck <- run_bioccheck
    with2$run_crancheck <- run_crancheck
    with2$run_vignettes <- run_vignettes
    with2$has_testthat <- has_testthat
    with2$run_covr <- run_covr
    with2$run_pkgdown <- run_pkgdown
    with2$has_runit <- has_runit 
    with2$GITHUB_TOKEN <- github_token 
    with2$docker_username <- docker_username 
    with2$docker_org <- docker_org 
    with2$cache_version <- cache_version 
    with2$cache_version <- cache_version
    #### replace with: args ####
    yml$jobs[[1]]$steps[[2]]$with <- with2
    ### Enable running workflow locally with act ####
    if(isFALSE(enable_act)){
      yml$jobs[[1]]$steps[[1]] <- NULL
    } 
  } 
  #### Preview ####
  if(isTRUE(preview)){
    cat(yaml::as.yaml(yml)) 
  }
  #### Write to disk ####
  if(!is.null(save_dir)){ 
    path <- file.path(save_dir,paste0(name,".yml"))
    dir.create(dirname(path),showWarnings = FALSE, recursive = TRUE)
    messager("Saving workflow ==>",path,v=verbose)
    #### Write bools as true/false rather than yes/no (default) ####
    handlers2 <- list('bool#yes' = function(x){"${{ true }}"},
                      'bool#no' = function(x){"${{ false }}"})
    yml2 <- yaml::yaml.load(yaml::as.yaml(yml), handlers = handlers2)
    yaml::write_yaml(x = yml2,
                     file = path)
    #### Return ####
    if(isTRUE(return_path)){
      return(path)
    } else {
      return(yml)
    }
  } else {
    return(yml)
  }
}
