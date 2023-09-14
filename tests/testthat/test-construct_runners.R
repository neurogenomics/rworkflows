test_that("construct_runners works", {
  
  run_tests <- function(runners){
    testthat::expect_length(runners,3)
    for (r in runners){
      testthat::expect_true(all(c("os","bioc","r") %in% names(r)))
    }
  }
  runners <- construct_runners()
  run_tests(runners = runners)
  
  testthat::expect_error(
    construct_runners(bioc=list("typo"="typo"))
  ) 
  testthat::expect_error(
    construct_runners(r=list("typo"="typo"))
  )
  testthat::expect_error(
    construct_runners(cont=list("typo"="typo"))
  )
  
  #### versions_explicit ####
  runners <- construct_runners(versions_explicit = TRUE)
  run_tests(runners = runners) 
  testthat::expect_true(
    package_version(runners[[1]]$r)>="4.3"
  )
  testthat::expect_true(
    package_version(runners[[1]]$bioc)>="3.17"
  ) 
  
  #### When only single opts given ####
  runners <- construct_runners(bioc = "devel",
                               versions_explicit = TRUE,
                               run_check_cont = TRUE)
  run_tests(runners = runners) 
  testthat::expect_true(
    package_version(runners[[1]]$r)>="4.3"
  )
  testthat::expect_true(
    package_version(runners[[1]]$bioc)>="3.18"
  ) 
  
  #### When incorrect OS names provided ####
  testthat::expect_error(
    construct_runners(bioc = list("ubuntu-latest"="devel",
                                  "macOS-latest"="devel",
                                  "typooo"="devel"))
  )
  
})
