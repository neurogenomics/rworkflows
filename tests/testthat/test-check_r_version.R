test_that("check_r_version works", {
  ## Don't run on CRAN servers due to ongoing internet connectivity issues
  if(!is_gha()) testthat::skip_if_offline()
  
  testthat::expect_equal(
    check_r_version(r = "4.1"),
    "4.1"
  )
  testthat::expect_equal(
    check_r_version(r = "release_*"),
    "release"
  )
  testthat::expect_error(
    check_r_version(r = "10000.0000")
  )
})
