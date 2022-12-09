get_yaml <- function(name){
  
  workflow_nms <- c("rworkflows","rworkflows_static")
  handlers <- list('bool#yes' = function(x) { if (x == "on") x else TRUE})
  #### Check name and read in #####
  #### Dynamic action ####
  if(is.null(name) || 
     name=="rworkflows"){
      yml <- yaml::read_yaml(
        system.file("templates","rworkflows_template.yml",
                    package = "rworkflows"),
        handlers = handlers)
    #### Static workflow ####
    } else if(name=="rworkflows_static"){
      yml <- yaml::read_yaml(
        system.file("templates","rworkflows_template_static.yml",
                    package = "rworkflows"),
        handlers = handlers)  
      #### Read in action to avoid code redundancy ####
      ## Import the latest version of action.yml
      action <- yaml::read_yaml(
        "https://github.com/neurogenomics/rworkflows/raw/master/action.yml")
      #### Add action steps to static workflow ####
      yml$jobs$rworkflows_static$steps <- action$runs$steps
    } else {
      stp <- paste("`name` must be one of:",
                   paste("\n -",shQuote(workflow_nms),collapse = ""))
      stop(stp)
  } 
  return(yml)
}
  