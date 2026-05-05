test_that("url_exists works", {
  if (!is_gha()) testthat::skip_if_offline(host = "github.com")
  
  testthat::expect_true(
    rworkflows:::url_exists("https://github.com/neurogenomics/rworkflows")
  )
  testthat::expect_false(
    rworkflows:::url_exists("https://github.com/neurogenomics/rworkflowsTYPOOOOO")
  )
})
