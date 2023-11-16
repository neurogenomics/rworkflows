test_that("dependencies_latex works", {
  
  deps <- dependencies_latex(install=FALSE)
  testthat::expect_gte(length(deps),20)
  
  # deps <- dependencies_latex(install=TRUE)
  # testthat::expect_equal(deps,0)
})
