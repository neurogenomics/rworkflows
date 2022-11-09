test_that("use_workflow works", {
  
  path <- use_workflow(save_dir = file.path(tempdir(),".github","workflows"))
  testthat::expect_true(file.exists(path))
})
