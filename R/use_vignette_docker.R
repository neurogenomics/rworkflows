#' Use vignette: Docker
#' 
#' Creates a vignette rmarkdown file demonstrates how to create a
#'  Docker/Singularity image from a container stored in 
#' \href{https://hub.docker.com/}{Dockerhub}.
#' @param package R package name.
#' @param docker_org Docker registry organization name. 
#' Can simply be your registry username instead.
#' If \code{NULL}, \code{docker_org} will be inferred as the R package's GitHub 
#' owner.
#' @param title Title of vignette.
#' @param vignette_index_entry Index entry of the vignette, 
#' which is used when creating the navigation bar in the \pkg{pkgdown} site.
#' @param port_in Port number to route into the docker container.
#' See the 
#' \href{https://docs.docker.com/config/containers/container-networking/}{
#' Docker docs} for further details.
#' @param port_out Port number to route out of docker container.
#' See the 
#' \href{https://docs.docker.com/config/containers/container-networking/}{
#' Docker docs} for further details.
#' @param save_dir Directory to save the file to.
#' @param path Path to the file.
#' @param force_new If the file already exists, overwrite it 
#' (default: \code{FALSE}).
#' @param show Print the contents of the file in the R console.
#' @param verbose Print messages.
#' @param output Vignette output style. 
#' Defaults to \link[BiocStyle]{html_document}.
#' @inheritParams use_workflow
#' @inheritParams construct_runners
#' @returns Path to vignette file.
#' 
#' @export
#' @importFrom yaml read_yaml as.yaml
#' @importFrom here here
#' @examples
#' path <- use_vignette_docker(package = "mypackage",
#'                             docker_org = "neurogenomics",
#'                             ## use default save_dir in practice
#'                             save_dir = tempdir())
use_vignette_docker <- function(package = names(get_description()),
                                docker_org = NULL,
                                docker_registry="ghcr.io",
                                cont = construct_cont(
                                  cont = paste(docker_org,
                                               package,
                                               sep="/"),
                                  default_registry =docker_registry)[[1]],
                                title="Docker/Singularity Containers",
                                vignette_index_entry="docker",
                                save_dir=here::here(),
                                path=file.path(save_dir,
                                               "vignettes",
                                               "docker.Rmd"),
                                output=list(
                                  "BiocStyle::html_document"= list(
                                    "md_extensions"="-autolink_bare_uris"
                                    )
                                  ),
                                port_in=8787,
                                port_out=8900,
                                force_new=FALSE,
                                show=FALSE,
                                verbose=TRUE){
  # devoptera::args2vars(use_vignette_docker, reassign = TRUE)

  #### Check if file exists already ####
  if(file.exists(path) &
     isFALSE(force_new)){
    messager("Using existing vignette file:",path,v=verbose)
  } else {
    messager("Creating new vignette file ==>",path,v=verbose)
    force(docker_org)
    #### Infer docker_org
    docker_org <- infer_docker_org(docker_org=docker_org,
                                   docker_registry=docker_registry,
                                   verbose=verbose) 
    dir.create(dirname(path), showWarnings = FALSE, recursive = TRUE)
    #### get the template ####
    template_path <- system.file("templates","docker.Rmd",
                                 package = "rworkflows")
    #### Edit the yaml header ###
    l <- readLines(template_path)
    yml_lines <- seq(grep("---",l)[1],
                     rev(grep("---",l))[1] ) 
    yml <- yaml::read_yaml(text = l[yml_lines])
    #### Set params ####
    ## cont
    yml$params$cont$value <- cont
    ## docker_registry
    yml$params$docker_registry$value <- docker_registry
    ## docker_org
    yml$params$docker_org$value <- docker_org
    ## vignette title
    yml$title <- title
    ## vignette index entry
    yml <- set_vignette_index(yml = yml,
                              pattern = "%\\VignetteIndexEntry{docker}",
                              vignette_index_entry = vignette_index_entry)
    yml$output <- output
    #### Change port numbers ####
    l <- gsub("<port_in>",port_in,l)
    l <- gsub("<port_out>",port_out,l)
    #### Render to text ####
    yml_txt <- gsub("''","\"",yaml::as.yaml(yml))
    new_rmd <-c("---",strsplit(yml_txt,"\n")[[1]],"---",
                l[-yml_lines])
    #### Rewrite local rmarkdown #### 
    writeLines(text = new_rmd,
               con = path) 
  }
  if(isTRUE(show)){
    messager("Vignette file preview:",v=verbose)
    cat(paste(readLines(path),collapse ="\n"))
  }
  return(path)
}
