test_that("use_issue_template works", {
  
  path <- use_issue_template(save_dir=tempdir())
  testthat::expect_true(all(file.exists(path)))
  
  out <- testthat::capture_output_lines(
    path2 <- use_issue_template(save_dir=tempdir(),
                               force_new = FALSE,
                               show = TRUE)
  )
  testthat::expect_true(all(file.exists(path2)))
  testthat::expect_equal("description: File a bug report",out[[2]])
})
