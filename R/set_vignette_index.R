set_vignette_index <- function(yml,
                               pattern="%\\VignetteIndexEntry{docker}",
                               vignette_index_entry){
  yml$vignette <- gsub(
    "} ","}\n",
    gsub(
      pattern, 
      paste0("%\\VignetteIndexEntry{",vignette_index_entry,"}"), 
      yml$vignette, 
      fixed = TRUE),
    fixed=TRUE
  )
  return(yml)
}