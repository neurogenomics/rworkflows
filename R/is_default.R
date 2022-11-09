is_default <- function(fun,
                       arg,
                       arg_value,
                       use_names=TRUE){
  fmls <- formals(get(fun))
  if(arg %in% names(fmls)){
    is_def <- if(use_names){
      all(arg_value == names(fmls[[arg]]))
    } else {
      all(arg_value == fmls[[arg]])
    } 
    return(is_def)
  } else {
    wrn <- paste0(arg," is not an argument in ",fun,".")
    warning(wrn)
    return(NULL)
  }
}