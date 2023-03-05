test_that("use_issue_template works", {
  
  path <- use_issue_template(save_dir=tempdir())
  testthat::expect_true(all(file.exists(path)))
  
  path <- use_issue_template(save_dir=tempdir(),
                             force_new = FALSE,
                             show = TRUE)
  testthat::expect_true(all(file.exists(path)))
})
