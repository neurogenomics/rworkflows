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
    construct_runners(bioc=c("typo"="typo"))
  ) 
  testthat::expect_error(
    construct_runners(r=c("typo"="typo"))
  )
  testthat::expect_error(
    construct_runners(cont=c("typo"="typo"))
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
})
