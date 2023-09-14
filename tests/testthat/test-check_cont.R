test_that("check_cont works", {
  
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
})
