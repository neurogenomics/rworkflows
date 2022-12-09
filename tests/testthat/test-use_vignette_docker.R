test_that("use_vignette_docker works", {
  
  path <- use_vignette_docker(docker_org = "neurogenomicslab",
                              save_dir = tempdir())
  testthat::expect_true(file.exists(path))
})
