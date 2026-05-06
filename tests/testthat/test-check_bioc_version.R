test_that("check_bioc_version works", {
  if (!is_gha()) testthat::skip_if_offline(host = "bioconductor.org")

  testthat::expect_equal(
    check_bioc_version(bioc = "3.17"),
    "3.17"
  )
  testthat::expect_error(
    check_bioc_version(bioc = "typo")
  )
})
