test_that("use_vignette_docker works", {
  
  path <- use_vignette_docker(package = "mypackage",
                              docker_org = "neurogenomicslab",
                              save_dir = tempdir())
  testthat::expect_true(file.exists(path))
  
  out <- testthat::capture_output_lines({
    path2 <- use_vignette_docker(package = "mypackage",
                                 docker_org = "neurogenomicslab",
                                 save_dir = tempdir(), 
                                 preview = TRUE)
  })
  testthat::expect_true(file.exists(path2))
  testthat::expect_true(grepl("^title:",out[[2]]))
})
