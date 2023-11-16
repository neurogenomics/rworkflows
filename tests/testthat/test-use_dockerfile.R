test_that("use_dockerfile works", { 
  
  path <- use_dockerfile(save_dir=tempdir())
  testthat::expect_true(file.exists(path))
  
  out <- testthat::capture_output_lines({
    path2 <- use_dockerfile(save_dir=tempdir(), 
                            force_new = FALSE,
                            show = TRUE)
  })
  testthat::expect_true(file.exists(path2))
  testthat::expect_equal("# ----- rworkflows Dockerfile ----- ",out[[1]])
})
