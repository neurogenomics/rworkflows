test_that("construct_cont works", {
  
  cont <- construct_cont() 
  testthat::expect_equal(cont[[1]],  "bioconductor/bioconductor_docker:devel")
  testthat::expect_null(cont[[2]])
  testthat::expect_null(cont[[3]])
})
