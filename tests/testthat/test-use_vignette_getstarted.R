test_that("use_vignette_getstarted works", {
  
  path <- use_vignette_getstarted(package = "mypackage",
                                  save_dir = tempdir())
  testthat::expect_true(file.exists(path))
})
