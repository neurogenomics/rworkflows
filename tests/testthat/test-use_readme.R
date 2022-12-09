test_that("use_readme works", {
  
  path <- use_readme(save_dir = tempdir()) 
  testthat::expect_true(file.exists(path))
})
