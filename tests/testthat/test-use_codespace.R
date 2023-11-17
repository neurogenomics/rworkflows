test_that("use_codespace works", {
  
  run_tests <- function(path){
    testthat::expect_true(file.exists(path))
    jsn <- jsonlite::read_json(path)
    testthat::expect_true(
      all(c("image","features","customizations") %in% names(jsn))
    )
  }
  save_dir <- tempdir()
  ## First time
  path <- use_codespace(save_dir=save_dir)
  run_tests(path)
  
  ## Second time
  path2 <- use_codespace(save_dir=save_dir, preview=TRUE)
  run_tests(path2)
})
