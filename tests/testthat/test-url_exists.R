test_that("url_exists works", {
  
  testthat::expect_true(
    rworkflows:::url_exists("https://github.com/neurogenomics/rworkflows")
  )
  testthat::expect_false(
    rworkflows:::url_exists("https://github.com/neurogenomics/rworkflowsTYPOOOOO")
  )
})
