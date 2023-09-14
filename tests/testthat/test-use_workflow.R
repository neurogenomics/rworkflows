test_that("use_workflow works", {
  
  path <- use_workflow(save_dir = file.path(tempdir(),".github","workflows"))
  testthat::expect_true(file.exists(path))
  
  #### Non-defaults ###
  args <- list(has_latex = TRUE, 
               run_bioccheck = TRUE, 
               run_vignettes = FALSE, 
               run_docker = TRUE,
               docker_user = "octocat",
               docker_org = "octolab")
  yml <- use_workflow(has_latex = args$has_latex, 
                      run_bioccheck = args$run_bioccheck, 
                      run_vignettes = args$run_vignettes, 
                      run_docker = args$run_docker,
                      docker_user = args$docker_user,
                      docker_org = args$docker_org,
                      force_new = TRUE,
                      return_path = FALSE, 
                      save_dir = tempdir())
  with <- yml$jobs$rworkflows$steps[[1]]$with
  for(x in names(args)){
    testthat::expect_equal(
      if(with[[x]]=="${{ true }}") TRUE else if (with[[x]]=="${{ false }}") FALSE else with[[x]],
                           args[[x]])
  } 
  #### Load pre-existing yaml #### 
  yml2 <- use_workflow(force_new = FALSE,
                       return_path = FALSE, 
                       save_dir = tempdir())
  testthat::expect_equal(yml,yml2)
  
  
  #### Use rworkflows_static ####
  yml3 <- use_workflow(template = "rworkflows_static",
                       return_path = FALSE,
                       force_new = TRUE,
                       tinytex_installer = "TinyTeX",
                       save_dir = tempdir())
  
  
  #### Make table out of arguments ####
  # defaults <- eval(formals(rworkflows::use_workflow))
  # d <- data.table::data.table(arg=names(defaults), 
  #                             default=as.character(defaults)) 
  
})
