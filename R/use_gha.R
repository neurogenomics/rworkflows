#' Use GitHub Actions
#' 
#' Use a \href{https://github.com/features/actions}{GitHub Actions (GHA)} 
#' workflow from
#'  \href{https://github.com/neurogenomics/rworkflows}{rworkflows}.
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
#' @param repo_token Token for the repo. 
#' Can be passed in using {{ secrets.PAT_GITHUB }}.
#' @param docker_username DockerHub username.
#' @param docker_org DockerHub organization name. 
#' Is the same as \code{docker_username} by default.
#' @param docker_token DockerHub token.
#' 
#' @param save_dir Directory to save workflow to.
#' @param return_path Return the path to the saved \emph{yaml} workflow file
#' (default: \code{TRUE}), or return the \emph{yaml} object directly.
#' @param verbose Print messages.
#' @returns Path or yaml object.
#' 
#' @export
#' @importFrom here here
#' @importFrom yaml as.yaml
#' @examples  
#' path <- use_gha(save_dir = file.path(tempdir(),".github","workflows"))
use_gha <- function(name="test-document-deploy",
                    on=c("push","pull_request"),
                    branches=c("master","main"),
                    run_bioccheck=FALSE,
                    run_crancheck=TRUE, 
                    has_testthat=TRUE, 
                    run_covr=TRUE, 
                    run_pkgdown=TRUE, 
                    has_runit=TRUE, 
                    run_docker=TRUE, 
                    repository="${{ github.repository }}",
                    repo_token="${{ secrets.PAT_GITHUB }}",
                    docker_username=NULL,
                    docker_org=docker_username,
                    docker_token="${{ secrets.DOCKER_TOKEN }}",
                    
                    save_dir=here::here(".github","workflows"),
                    return_path=TRUE,
                    verbose=TRUE){
    
    # templateR:::source_all()
    # templateR:::args2vars(use_gha) 
    yml <- list(
            "name:"=name, 
            
            "on:"=list("push:"=list(
                "branches:"=paste0("[",paste(branches,collapse = ", "),"]")
                           ),
                "pull_request:"=list(
                    "branches:"= paste0("[",paste(branches,collapse = ", "),"]")
                           ),
                       
            "jobs:"=list(
                list(
                    "runs-on:"="${{ matrix.config.os }}",
                    "name:"="${{ matrix.config.os }} (${{ matrix.config.r }})",
                    "container:"="${{ matrix.config.cont }}",
                    "env:"=list("RSPM: ${{ matrix.config.rspm }}"),
                    "strategy:"=list(
                        "fail-fast:"="false",
                        "matrix"=list(
                            "config:"=list(
                                "- { os: ubuntu-latest, r: 'devel', bioc: 'devel', cont: 'bioconductor/bioconductor_docker:devel', rspm: 'https://packagemanager.rstudio.com/cran/__linux__/focal/release'}",
                                "- { os: macOS-latest, r: 'latest', bioc: 'release'}",
                                "- { os: windows-latest, r: 'latest', bioc: 'release'}"
                            )
                        )
                    ),
                    "steps:"=list(
                        list(
                            "- if:"="${{ env.ACT }}",
                            "name:"="Hack container for local development",
                            "run:"="|
                            curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
                            sudo apt-get install -y nodejs"
                        ),
                    list("- uses:"="actions/checkout@v3"),
                    list("- uses:"="./test-document-deploy",
                         list("with:",
                              "run_bioccheck:"=tolower(toString(run_bioccheck)),
                              "run_crancheck:"=tolower(toString(run_crancheck)), 
                              "has_testthat:"=tolower(toString(has_testthat)),  
                              "run_covr:"=tolower(toString(run_covr)),   
                              "run_pkgdown:"=tolower(toString(run_pkgdown)),   
                              "has_runit:"=tolower(toString(has_runit)),    
                              "run_docker:"=tolower(toString(run_docker)),   
                              "repository:"=repository,    
                              "github_token:"=repo_token,    
                              "DOCKER_USERNAME:"=docker_username,
                              "DOCKER_ORG:"=docker_org,
                              "DOCKER_TOKEN:"=docker_token,
                              "runner.os:"="${{ runner.os }}" 
                              )
                         )
                    )       
                ) |> `names<-`(paste0(name,":"))
            )
        ) 
    )
    
    if(!is.null(save_dir)){
        yml2 <- yaml::as.yaml(x = yml)
        path <- file.path(save_dir,name)
        dir.create(dirname(path),showWarnings = FALSE, recursive = TRUE)
        messager("Saving workflow ==>",path,v=verbose)
        writeLines(text = yml2, con = path)
        if(isTRUE(return_path)){
            return(path)
        } else {
            yml
        }
    } else {
        return(yml)
    }
}
