test_that("construct_cont works", {
  
  cont1 <- construct_cont() 
  default_registry <- eval(formals(construct_cont)$default_registry)[1]
  default_tag <- eval(formals(construct_cont)$default_tag)[1]
  testthat::expect_equal(cont1[[1]],  
                         paste0(default_registry,"bioconductor/bioconductor_docker:",default_tag))
  testthat::expect_null(cont1[[2]])
  testthat::expect_null(cont1[[3]])
  
  cont2 <- construct_cont(cont = "devel") 
  testthat::expect_equal(cont2[[1]],  
                         paste0(default_registry,"bioconductor/bioconductor_docker:",default_tag))
  
  cont3 <- construct_cont(versions_explicit = TRUE) 
  testthat::expect_true(grepl("bioconductor/bioconductor_docker:RELEASE_*",
                              cont3[[1]]))
  testthat::expect_null(cont3[[2]])
  testthat::expect_null(cont3[[3]])
  
  ## Don't run on CRAN servers due to ongoing internet connectivity issues
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  
  cont4 <- construct_cont(default_tag = "release",
                          default_registry = "ghcr.io",
                          run_check_cont = TRUE) 
  testthat::expect_equal(cont4[[1]], paste0(default_registry,"bioconductor/bioconductor_docker:latest"))
  testthat::expect_null(cont4[[2]])
  testthat::expect_null(cont4[[3]])
  
  
  cont5 <- construct_cont(default_registry = NULL) 
  testthat::expect_equal(cont5[[1]],"bioconductor/bioconductor_docker:devel")
  testthat::expect_null(cont5[[2]])
  testthat::expect_null(cont5[[3]])
})
