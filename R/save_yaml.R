save_yaml <- function(yml,
                      path,
                      handlers=NULL,
                      verbose=TRUE,
                      ...){
  
  dir.create(dirname(path),showWarnings = FALSE, recursive = TRUE)
  messager("Saving yaml ==>",path,v=verbose)
  #### Write bools as true/false rather than yes/no (default) ####
  if(!is.null(handlers)){
    yml <- yaml::yaml.load(yaml::as.yaml(yml), 
                           handlers = handlers)
  } 
  yaml::write_yaml(x = yml,
                   file = path)
}