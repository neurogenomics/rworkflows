test_that("url_exists works", {
  ## Don't run on CRAN servers due to ongoing internet connectivity issues
  if(!is_gha()) testthat::skip_if_offline()
  
  testthat::expect_true(
    rworkflows:::url_exists("https://github.com/neurogenomics/rworkflows")
  )
  testthat::expect_false(
    rworkflows:::url_exists("https://github.com/neurogenomics/rworkflowsTYPOOOOO")
  )
})
