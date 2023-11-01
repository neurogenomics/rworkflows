test_that("use_codespace works", {
  
  path <- use_codespace(save_dir=tempdir())
  testthat::expect_true(file.exists(path))
  
  jsn <- jsonlite::read_json(path)
  testthat::expect_true(
    all(c("image","features","customizations") %in% names(jsn))
  )
})
