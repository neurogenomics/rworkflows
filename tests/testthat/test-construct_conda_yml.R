test_that("construct_conda_yml works", {
  
  save_path <- tempfile(fileext = "myenv_conda.yml")
  path1 <- construct_conda_yml(name="myenv",
                              dependencies=c("anndata","scanpy"),
                              return_path = TRUE,
                              save_path = save_path)
  testthat::expect_true(file.exists(path1)) 
  
  yml1 <- construct_conda_yml(name="myenv",
                              dependencies=c("anndata","scanpy"),
                              return_path = FALSE,
                              save_path = save_path)
  testthat::expect_true(all(c("name","channels","dependencies") %in% names(yml1)))
  
  yml2 <- construct_conda_yml(name="myenv",
                              dependencies=c("anndata>=1.0","scanpy<20.1.1"),
                              pip = c("pip","mytool1","mtool2"), 
                              return_path = FALSE,
                              save_path = save_path)
  testthat::expect_true(all(c("name","channels","dependencies","pip") %in% names(yml2)))
  
  yml3 <- construct_conda_yml(name="myenv",
                              dependencies=c("anndata","scanpy"),
                              save_path = NULL,
                              preview = TRUE,
                              return_path = TRUE,
                              save_path = save_path)
  testthat::expect_true(all(c("name","channels","dependencies") %in% names(yml3)))
  
  
  #### Construct an actual conda env ####
  if(conda_installed() && is_gha()){ 
    envname <- "testenv"
    if(condaenv_exists(envname)){
      reticulate::conda_remove(envname = envname)
    }
    path2 <- construct_conda_yml(name=envname,
                                 dependencies=list("python"),
                                 pip=list("requests"),
                                 preview = TRUE,
                                 return_path = TRUE,
                                 save_path = save_path)
    out <- reticulate::conda_create(environment = path2)
  }
  
})
