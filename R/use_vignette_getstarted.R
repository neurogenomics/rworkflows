#' Use vignette: Get started
#' 
#' Creates a "Get started" rmarkdown vignette file.
#' @param package R package name.
#' @inheritParams use_vignette_docker
#' @returns Path to vignette file.
#' 
#' @export
#' @importFrom yaml read_yaml as.yaml
#' @importFrom here here
#' @examples
#' path <- use_vignette_getstarted(package = "mypackage",
#'                                 ## use default save_dir in practice
#'                                 save_dir = tempdir())
use_vignette_getstarted <- function(package,
                                    title="Get started",
                                    vignette_index_entry=package,
                                    save_dir=here::here(),
                                    path=file.path(save_dir,
                                                   "vignettes",
                                                   paste0(package,".Rmd")),
                                    force_new=FALSE,
                                    show=FALSE,
                                    verbose=TRUE){
  
  force(package)
  #### Check if file exists already ####
  if(file.exists(path) &
     isFALSE(force_new)){
    messager("Using existing vignette file:",path,v=verbose)
  } else {
    messager("Creating new vignette file ==>",path,v=verbose)
    dir.create(dirname(path), showWarnings = FALSE, recursive = TRUE)
    #### get the template ####
    template_path <- system.file("templates","templateR.Rmd",
                                 package = "rworkflows")
    #### Edit the yaml header ###
    l <- readLines(template_path)
    yml_lines <- seq(grep("---",l)[1],
                     rev(grep("---",l))[1] ) 
    yml <- yaml::read_yaml(text = l[yml_lines]) 
    ## vignette title
    yml$title <- title 
    yml <- set_vignette_index(yml = yml,
                              pattern = "%\\VignetteIndexEntry{templateR}",
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
