fill_yaml <- function(yml,
                      ## action-level args
                      name,
                      tag,
                      on,
                      branches,
                      ## workflow-level args
                      run_bioccheck,
                      run_rcmdcheck, 
                      as_cran,
                      run_vignettes,
                      has_testthat, 
                      run_covr, 
                      run_pkgdown, 
                      has_runit, 
                      run_docker,  
                      github_token,
                      docker_user,
                      docker_org,
                      docker_token,
                      cache_version,
                      enable_act){
  #### name ####
  yml$name <- name
  #### on ####
  on2 <- lapply(stats::setNames(on,on),
                function(x){list("branches"=branches)})
  yml$on <- on2
  #### static workflow vs. action ####
  if(name=="rworkflows_static"){
    with2 <- yml$env
  } else if(name=="rworkflows"){
    #### Set tag ####
    yml$jobs[[1]]$steps[[2]]$uses <- paste0("neurogenomics/",name,tag)   
    #### with: args #### 
    with2 <- yml$jobs[[1]]$steps[[2]]$with
    ### Enable running workflow locally with act ####
    if(isFALSE(enable_act)){
      yml$jobs[[1]]$steps[[1]] <- NULL
    }  
  }
  #### Supply variables as "with:" or "env:" ####
  with2$run_bioccheck <- run_bioccheck
  with2$run_rcmdcheck <- run_rcmdcheck
  with2$as_cran <- as_cran
  with2$run_vignettes <- run_vignettes
  with2$has_testthat <- has_testthat
  with2$run_covr <- run_covr
  with2$run_pkgdown <- run_pkgdown
  with2$has_runit <- has_runit 
  with2$GITHUB_TOKEN <- github_token 
  with2$run_docker <- run_docker 
  with2$docker_user <- docker_user 
  with2$docker_org <- docker_org 
  with2$DOCKER_TOKEN <- docker_token 
  with2$cache_version <- cache_version  
  #### static workflow vs. action ####
  if(name=="rworkflows_static"){
    yml$env <- with2
  } else if(name=="rworkflows"){
    #### replace with: args ####
    yml$jobs[[1]]$steps[[2]]$with <- with2
  }
  return(yml) 
}
