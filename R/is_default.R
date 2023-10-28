is_default <- function(arg,
                       val=get(arg, envir = parent.frame()),
                       func="use_workflow"){
  def <- eval(formals(get(func))[[arg]])
  # message("nm: ",arg)
  # message("val: ",val)
  # message("def: ",def)
  (is.null(def) & is.null(val)) || any(def==val)
}