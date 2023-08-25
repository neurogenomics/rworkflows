refs_to_list <- function(refs){
  if(is.list(refs)){ 
    refs
  } else if(is.null(refs)){
    list(NULL)
  } else if(is.character(refs)){
    as.list(refs)
  } else (
    list(refs)
  )
}