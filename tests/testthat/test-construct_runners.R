test_that("construct_runners works", {
  ## Don't run on CRAN servers due to ongoing internet connectivity issues
  testthat::skip_if_offline()
  
  #### Set up tests ####  
  run_tests <- function(runners){
    testthat::expect_length(runners,3)
    for (r in runners){
      testthat::expect_true(all(c("os","bioc","r") %in% names(r)))
    }
  }
  #### Defaults ####
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
  
  #### When python versions passed ####
  python_version <- "3.9"
  runners <- construct_runners(python_version = python_version)
  run_tests(runners = runners) 
  testthat::expect_true(
    all(sapply(runners, function(x)x$r=="auto"))
  )
  testthat::expect_true(
    all(sapply(runners, function(x)x$`python-version`==python_version))
  )
  
})
