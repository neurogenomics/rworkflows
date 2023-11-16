test_that("dependencies_macos works", {
  
  cmd <- utils::capture.output(
    dependencies_macos()
  )
  testthat::expect_true(grepl("^brew install",cmd))
})
