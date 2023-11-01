test_that("infer_docker_org works", {
  
 testthat::expect_error(
   infer_docker_org(docker_org = NULL, 
                    docker_registry = "docker.io")
 )
  
  docker_org <- "neurogenomicslab"
  out <- infer_docker_org(docker_org = docker_org, 
                          docker_registry = "docker.io")
  testthat::expect_equal(out,docker_org)
})
