save_yaml <- function(yml,
                      path,
                      verbose){
  
  dir.create(dirname(path),showWarnings = FALSE, recursive = TRUE)
  messager("Saving workflow ==>",path,v=verbose)
  #### Write bools as true/false rather than yes/no (default) ####
  handlers2 <- list('bool#yes' = function(x){"${{ true }}"},
                    'bool#no' = function(x){"${{ false }}"})
  yml2 <- yaml::yaml.load(yaml::as.yaml(yml), 
                          handlers = handlers2)
  yaml::write_yaml(x = yml2,
                   file = path)
}