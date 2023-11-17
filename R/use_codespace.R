#' Use Codespace
#' 
#' Generate a dev container config file to set up a 
#' \href{https://docs.github.com/en/codespaces}{GitHub Codespace}.
#' @param template Dev container config template to use.
#' @param image Base Docker image to use for the Codespace.
#' @param features Named list of features to add to the Codespace.
#' See \href{https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/configuring-dev-containers/adding-features-to-a-devcontainer-file}{here}
#'  for details.
#' @param customizations Named list of customizations to add to the Codespace.
#' See \href{https://containers.dev/supporting}{here}
#'  for details.
#' @inheritParams use_workflow
#' @inheritParams use_vignette_docker
#' @returns Path to dev container config file.
#' 
#' @export
#' @examples
#' path <- use_codespace(save_dir=tempdir())
use_codespace <- function(template="devcontainer.json",
                          image="ghcr.io/neurogenomics/rworkflows:dev",
                          features=list(
                            "ghcr.io/devcontainers/features/conda:1"=list()
                          ),
                          customizations=list(
                            vscode=list(
                              settings=list(),
                              extensions=
                                list("reditorsupport.r",
                                     "visualstudioexptteam.vscodeintellicode",
                                     "ionutvmi.path-autocomplete")
                              )
                            ),
                          save_dir=here::here(".devcontainer"),
                          path=file.path(save_dir,
                                         template),
                          force_new=FALSE,
                          preview=FALSE,
                          verbose=TRUE){
  # devoptera::args2vars(use_codespace)
  
  #### Create or use existing file ####
  if(file.exists(path) &&
     isFALSE(force_new)){
    messager("Using existing dev container config file ==>",path,v=verbose)
  } else {
    requireNamespace("jsonlite")
    messager("Creating new dev container config file ==>",path,v=verbose)
    tmp <- system.file("templates","devcontainer.json",package="rworkflows")
    jsn <- jsonlite::read_json(tmp)
    jsn$features <- features
    jsn$customizations <- customizations
    jsonlite::write_json(jsn,path)
  }
  #### Preview ####
  if(isTRUE(preview)){
    messager("Config file preview:",v=verbose)
    cat(paste(readLines(path),collapse ="\n"))
  }
  return(path)
}