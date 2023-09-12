omit_if_default <- function(arg,
                            val=get(arg, envir = parent.frame()),
                            func="use_workflow",
                            omit_value=NULL){ 
  def <- eval(formals(get(func))[[arg]])
  message("nm: ",arg)
  message("val: ",val)
  message("def: ",def) 
  if(val == def){
    return(omit_value)
  } else {
    return(val)
  } 
}