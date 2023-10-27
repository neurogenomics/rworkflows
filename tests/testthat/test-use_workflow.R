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
  testthat::expect_equal(yml$on,yml3$on)
  testthat::expect_equal(length(yml$jobs[[1]]$steps),1)
  testthat::expect_gte(length(yml3$jobs[[1]]$steps),20)
  
  #### Modify conda args ####
  environment_file <- construct_conda_yml(dependencies = c("python>=3.9","anndata"),
                      preview = TRUE, 
                      save_path = file.path(tempdir(),"conda.yml"))
  miniforge_variant <- "Mambaforge"
  yml4 <- use_workflow(return_path = FALSE,
                       force_new = TRUE,
                       miniforge_variant = miniforge_variant,
                       environment_file = environment_file,
                       save_dir = tempdir())
  testthat::expect_equal(yml$on,yml4$on)
  testthat::expect_null(yml$jobs$rworkflows$steps[[1]]$with$miniforge_variant)
  testthat::expect_equal(yml4$jobs$rworkflows$steps[[1]]$with$miniforge_variant,
                         miniforge_variant)
  testthat::expect_equal(yml4$jobs$rworkflows$steps[[1]]$with$environment_file,
                         environment_file)
  
  miniforge_variant <- TRUE
  yml5 <- use_workflow(return_path = FALSE,
                       force_new = TRUE,
                       miniforge_variant = miniforge_variant,
                       environment_file = environment_file,
                       save_dir = tempdir())
  testthat::expect_equal(yml$on,yml5$on)
  testthat::expect_equal(yml5$jobs$rworkflows$steps[[1]]$with$miniforge_variant,
                         "")
  testthat::expect_equal(yml5$jobs$rworkflows$steps[[1]]$with$environment_file,
                         environment_file)
  
  #### Make table out of arguments ####
  # defaults <- eval(formals(rworkflows::use_workflow))
  # d <- data.table::data.table(arg=names(defaults), 
  #                             default=as.character(defaults)) 
  
})
