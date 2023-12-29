test_that("gha_python_versions works", {
  ## Don't run on CRAN servers due to ongoing internet connectivity issues
  testthat::skip_if_offline()
  
  testthat::expect_equal(gha_python_versions(python_version = "3.11"),"3.11")
  testthat::expect_equal(gha_python_versions(python_version = "3.x"),"3.x")
  testthat::expect_equal(gha_python_versions(python_version = "3"),"3.x")
  testthat::expect_true(
    package_version(gha_python_versions(python_version = "latest"))>="3.1.55"
    )
  testthat::expect_true(
    package_version(strsplit(gha_python_versions(python_version = "devel"),"-")[[1]][1])>="3.12.0"
  )
})
