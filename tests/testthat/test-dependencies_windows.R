test_that("dependencies_windows works", {
  
  cmd <- utils::capture.output(
    dependencies_windows()
  )
  testthat::expect_true(grepl("^npm install",cmd))
})
