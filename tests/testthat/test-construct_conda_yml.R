test_that("construct_conda_yml works", {
  
  path1 <- construct_conda_yml(name="sc_env",
                              dependencies=c("anndata","scanpy"),
                              return_path = TRUE)
  testthat::expect_true(file.exists(path1)) 
  
  yml1 <- construct_conda_yml(name="sc_env",
                              dependencies=c("anndata","scanpy"),
                              return_path = FALSE)
  testthat::expect_true(all(c("name","channels","dependencies") %in% names(yml1)))
  
  yml2 <- construct_conda_yml(name="sc_env",
                              dependencies=c("anndata>=1.0","scanpy<20.1.1"),
                              pip = c("pip","mytool1","mtool2"), 
                              return_path = FALSE)
  testthat::expect_true(all(c("name","channels","dependencies","pip") %in% names(yml2)))
  
  yml3 <- construct_conda_yml(name="sc_env",
                              dependencies=c("anndata","scanpy"),
                              save_path = NULL,
                              return_path = TRUE)
  testthat::expect_true(all(c("name","channels","dependencies") %in% names(yml3)))
})
