test_that("use_gha works", {
  
  path <- use_gha(save_dir = file.path(tempdir(),".github","workflows"))
  testthat::expect_true(file.exists(path))
})
