test_that("use_vignette_docker works", {
  
  if(.Platform$OS.type!="windows"){
    path <- use_vignette_docker(docker_org = "neurogenomicslab",
                                save_dir = tempdir())
    testthat::expect_true(file.exists(path))
    
    out <- testthat::capture_output_lines({
      path2 <- use_vignette_docker(docker_org = "neurogenomicslab",
                                   save_dir = tempdir(), 
                                   show = TRUE)
    })
    testthat::expect_true(file.exists(path2))
    testthat::expect_true(grepl("^title:",out[[2]]))
  } 
})
