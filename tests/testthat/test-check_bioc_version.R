test_that("check_bioc_version works", {
  ## Skip if offline: relies on bioc_r_versions() which fetches a remote yaml
  if(!is_gha()) testthat::skip_if_offline()

  testthat::expect_equal(
    check_bioc_version(bioc = "3.17"),
    "3.17"
  )
  testthat::expect_error(
    check_bioc_version(bioc = "typo")
  )
})
