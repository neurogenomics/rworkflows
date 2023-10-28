omit_if_default <- function(arg,
                            val=get(arg, envir = parent.frame()),
                            func="use_workflow",
                            omit_value=NULL){ 
  if(is_default(arg=arg, val=val,func=func)){
    return(omit_value)
  } else {
    return(val)
  } 
}