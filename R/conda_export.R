#' Conda export
#'
#' @description
#'  Get a list of installed packages within a conda environment.
#'  Generates a requirements.txt file.
#' @param name Name of conda environment.
#' @param save_path Path to save the requirements file. 
#' If the file ends with .yml or .yaml, a conda-style 
#' yaml file will be generated.
#' If the file ends with requirements.txt, a pip-style requirements.txt file
#'  will be generated.
#' @param preview Print the requirements file to the R console.
#' @param verbose Print messages. 
#' @source https://stackoverflow.com/a/55687210
#' 
#' @export 
#' @examples
#' \dontrun{
#' conda_export()
#' }
conda_export <- function(name,
                         save_path=tempfile(fileext = "_requirements.txt"),
                         preview=FALSE,
                         verbose=TRUE){
  requireNamespace("reticulate")
  
  force(name)
  #### Find conda executable ####
  conda <- reticulate::conda_binary() 
  #### Get packages ####
  dir.create(dirname(save_path),recursive = TRUE,showWarnings = FALSE)
  if(grepl("requirements\\.txt$",save_path)){
    system(paste(conda,"list -n testenv --export >",save_path))  
  } else if (grepl("\\.yml$|\\.yaml$",save_path)){
    reticulate::conda_export(envname = name,
                             file = save_path)  
  } 
  #### Read ####
  txt <- readLines(save_path)
  if(length(txt)==0) stopper("No packages found.")
  #### Preview ####
  if(preview) cat(paste(txt,collapse = "\n")); cat("\n");
  #### Save ####
  if(!is.null(save_path)) {
    writeLines(txt, save_path)
    messager("Saved to",save_path,v=verbose)
    return(save_path)
  } else {
    return(txt)  
  } 
}