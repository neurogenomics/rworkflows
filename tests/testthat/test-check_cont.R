test_that("check_cont works", {
  ## Don't run on CRAN servers due to ongoing internet connectivity issues
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  
  testthat::expect_no_warning(
    check_cont(cont = "bioconductor/bioconductor_docker:devel")
  )
  testthat::expect_no_warning(
    check_cont(cont = "bioconductor/bioconductor_docker")
  )
  testthat::expect_error(
    testthat::expect_warning(
      check_cont(cont = "bioconductor/bioconductor_typooooo")
    )
  )
  testthat::expect_error(
    check_cont(cont = "bioconductor/bioconductor_docker:typooo")
  )
  testthat::expect_error(
    check_cont(cont = "typooooo")
  )
  
  #### Include registry ####
  testthat::expect_no_warning(
    check_cont(cont = "ghcr.io/bioconductor/bioconductor_docker")
  )
  
  testthat::expect_no_warning(
    check_cont(cont = "docker.io/bioconductor/bioconductor_docker:devel")
  )
  testthat::expect_warning(
    check_cont(cont = "mcr.microsoft.com/bioconductor/bioconductor_docker:devel")
  )
})
