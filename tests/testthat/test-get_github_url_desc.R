test_that("get_github_url_desc works", {
  
  testthat::expect_null(
    get_github_url_desc(desc_file = NULL)
  )
})
