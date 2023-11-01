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
                              pip = c("mytool1","mytool2"), 
                              return_path = FALSE,
                              save_path = save_path)
  testthat::expect_true(all(c("name","channels","dependencies") %in% names(yml2)))
  testthat::expect_true(all(c("mytool1","mytool2") %in% yml2$dependencies[[4]][[1]]))
  
  yml3 <- construct_conda_yml(name="myenv",
                              dependencies=c("anndata","scanpy"),
                              preview = TRUE,
                              return_path = FALSE,
                              save_path = save_path)
  testthat::expect_true(all(c("name","channels","dependencies") %in% names(yml3)))
  
  
  #### Construct an actual conda env ####
  if(conda_installed() && 
     is_gha() &&
     .Platform$OS.type != "windows"){ 
    envname <- "testenv"
    if(condaenv_exists(envname)){
      reticulate::conda_remove(envname = envname)
    }
    #### From conda yaml ####
    path2 <- construct_conda_yml(name=envname,
                                 dependencies=list("python"),
                                 pip=list("requests"),
                                 preview = TRUE,
                                 return_path = TRUE,
                                 save_path = save_path)
    testthat::expect_true(file.exists(path2))
    
    # conda <- conda_path()
    out <- reticulate::conda_create(environment = path2, 
                                    envname = envname)
    testthat::expect_true(file.exists(out))
    testthat::expect_equal(basename(out),"python")
    testthat::expect_equal(basename(dirname(dirname(out))),envname)
    
    
    ### Test conda_export
    exported_yml <- conda_export(envname)
    testthat::expect_true(file.exists(exported_yml))
    testthat::expect_gte(length(readLines(exported_yml)),20)
    
    
    #### From requirements.txt ####
    ## Currently fails due to error:
    ## Error: Error creating conda environment [exit code 1]
    # envname2 <- "testenv2" 
    # req_txt <- conda_export(name = envname, 
    #                         preview = TRUE)   
    # out <- reticulate::conda_create(environment = req_txt,  
    #                                 # channel = c("conda-forge","bioconda"),
    #                                 envname = envname2) 
    # testthat::expect_true(file.exists(out))
    # testthat::expect_equal(basename(out),"python")
    # testthat::expect_equal(basename(dirname(dirname(out))),envname)
  }
  
})
