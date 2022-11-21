get_yaml <- function(name){
  
  workflow_nms <- c("rworkflows","rworkflows_static")
  handlers <- list('bool#yes' = function(x) { if (x == "on") x else TRUE})
  #### Check name and read in #####
  if(is.null(name) || 
     name=="rworkflows"){
      yml <- yaml::read_yaml(
        system.file("yaml","rworkflows_template.yml",
                    package = "rworkflows"),
        handlers = handlers)
    } else if(name=="rworkflows_static"){
      yml <- yaml::read_yaml(
        system.file("yaml","rworkflows_template_static.yml",
                    package = "rworkflows"),
        handlers = handlers)
    } else {
      stp <- paste("`name` must be one of:",
                   paste("\n -",shQuote(workflow_nms),collapse = ""))
      stop(stp)
  } 
  return(yml)
}
  