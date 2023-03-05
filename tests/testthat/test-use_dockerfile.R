test_that("use_dockerfile works", { 
  
  path <- use_dockerfile(save_dir=tempdir())
  testthat::expect_true(file.exists(path))
  
  path <- use_dockerfile(save_dir=tempdir(), 
                         force_new = FALSE,
                         show = TRUE)
  testthat::expect_true(file.exists(path))
})
