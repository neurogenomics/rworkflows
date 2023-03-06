test_that("use_readme works", {
  
  path <- use_readme(save_dir = tempdir()) 
  testthat::expect_true(file.exists(path[1]))
  
  out <- testthat::capture_output_lines({
    path2 <- use_readme(save_dir = tempdir(), show = TRUE)
  })
  
  testthat::expect_true(file.exists(path2))
  testthat::expect_true(grepl("^title:",out[[2]]))
})