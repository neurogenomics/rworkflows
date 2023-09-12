get_yaml <- function(template){
  
  template_nms <- c("rworkflows","rworkflows_static")
  ## Custom handler prevents "on" from being converted to TRUE
  handlers <- list('bool#yes' = function(x) { if (x == "on") x else TRUE})
  #### Check template and read in #####
  #### Dynamic action ####
  if(is.null(template) || 
     template=="rworkflows"){
      yml <- yaml::read_yaml(
        system.file("templates","rworkflows_template.yml",
                    package = "rworkflows"),
        handlers = handlers)
    #### Static workflow ####
    } else if(template=="rworkflows_static"){
      yml <- yaml::read_yaml(
        system.file("templates","rworkflows_template_static.yml",
                    package = "rworkflows"),
        handlers = handlers)  
      #### Read in action to avoid code redundancy ####
      ## Import the latest version of action.yml
      action <- yaml::read_yaml(
        "https://github.com/neurogenomics/rworkflows/raw/master/action.yml")
      #### Add action steps to static workflow #### 
      recurse <- function(x, 
                          fun=function(x){
                            gsub("inputs\\.","env.",x)
                          }){
        if(is.list(x)){
          lapply(x, recurse, fun=fun) 
        } else if(is.character(x)){
          fun(x)
        } else {
          x
        }
      }
      yml$jobs$rworkflows_static$steps <- recurse(action$runs$steps)
    } else {
      stp <- paste("`name` must be one of:",
                   paste("\n -",shQuote(template_nms),collapse = ""))
      stop(stp)
  } 
  return(yml)
}
  