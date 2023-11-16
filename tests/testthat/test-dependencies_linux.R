test_that("dependencies_linux works", {
  
  cmd <- utils::capture.output(
    dependencies_linux(package="rworkflows")
  )
  testthat::expect_true(grepl("^apt-get update",cmd))
})
