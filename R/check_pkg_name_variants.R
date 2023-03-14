check_pkg_name_variants <- function(ref,
                                    pkg_retrieved=NULL,
                                    verbose=TRUE){
  # ref <- "neurogenomics/MAGMA_Celltyping"
  
  v1 <- basename(ref) |>
    trimws() |> trimws(whitespace = "^\\.|\\.")
  v2 <- tolower(v1)
  v3 <- lapply(c("-","_"," "), function(x){
    gsub(x,".",v1)
  })
  v4 <- lapply(c("-","_"," "), function(x){
    gsub(x,"",v1)
  })
  v <- unlist(c(ref,basename(ref),v1,v2,v3,v4))
  approximate_match <- pkg_retrieved %in% v
  if(isFALSE(approximate_match)){
    messager(
      paste0(
        "Requested package (",shQuote(basename(ref)),") ",
        "!= retrieved package (",shQuote(pkg_retrieved),") in DESCRIPTION. ",
        "Returning NULL."
      ),v = verbose
    )
  }
  return(approximate_match)
}