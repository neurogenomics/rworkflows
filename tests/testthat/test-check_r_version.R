test_that("check_r_version works", {
  
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
