test_that("get_yaml works", {
  
  testthat::expect_type(
    rworkflows:::get_yaml(template = "rworkflows"),
    "list"
  )
  testthat::expect_type(
    rworkflows:::get_yaml(template = "rworkflows_static"),
    "list"
  )
  testthat::expect_error(
    rworkflows:::get_yaml(template = "TYPOOOOO")
  )
})
