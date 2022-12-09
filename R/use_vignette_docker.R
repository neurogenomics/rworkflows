#' Use vignette: Docker
#' 
#' Creates a vignette rmarkdown file demonstrates how to create a
#'  Docker/Singularity image from a container stored in 
#' \href{https://hub.docker.com/}{Dockerhub}.
#' @param docker_org DockerHub organization name. 
#' Can simply be your Dockerhub username instead.
#' @param title Title of vignette.
#' @param vignette_index_entry Index entry of the vignette, 
#' which is used when creating the navigation bar in the \pkg{pkgdown} site.
#' @param save_dir Directory to save the vignette file to.
#' @param path Path to the vignette file.
#' @param force_new If the file already exists, overwrite it 
#' (default: \code{FALSE}).
#' @param show Print the contents of the vignette file in the R console.
#' @param verbose Print messages.
#' @returns Path to vignette file.
#' 
#' @export
#' @importFrom yaml read_yaml as.yaml
#' @importFrom here here
#' @examples
#' path <- use_vignette_docker(docker_org = "neurogenomicslab",
#'                             ## use default save_dir in practice
#'                             save_dir = tempdir())
use_vignette_docker <- function(docker_org,
                                title="Docker/Singularity Containers",
                                vignette_index_entry="docker",
                                save_dir=here::here(),
                                path=file.path(save_dir,
                                               "vignettes",
                                               "docker.Rmd"),
                                force_new=FALSE,
                                show=FALSE,
                                verbose=TRUE){
  
  force(docker_org)
  #### Check if file exists already ####
  if(file.exists(path) &
     isFALSE(force_new)){
    messager("Using existing vignette file:",path,v=verbose)
  } else {
    messager("Creating new vignette file ==>",path,v=verbose)
    dir.create(dirname(path), showWarnings = FALSE, recursive = TRUE)
    #### get the template ####
    template_path <- system.file("templates","docker.Rmd",
                                 package = "rworkflows")
    #### Edit the yaml header ###
    l <- readLines(template_path)
    yml_lines <- seq(grep("---",l)[1],
                     rev(grep("---",l))[1] ) 
    yml <- yaml::read_yaml(text = l[yml_lines])
    ## docker_user
    yml$params$docker_org$value <- docker_org
    ## vignette title
    yml$title <- title
    yml <- set_vignette_index(yml = yml,
                              pattern = "%\\VignetteIndexEntry{docker}",
                              vignette_index_entry = vignette_index_entry)
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
