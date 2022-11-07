test_that("use_dockerfile works", { 
  
  path <- use_dockerfile(save_dir=tempdir())
  testthat::expect_true(file.exists(path))
})
