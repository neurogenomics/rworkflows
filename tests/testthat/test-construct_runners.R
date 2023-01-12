test_that("construct_runners works", {
  
  runners <- construct_runners()
  testthat::expect_length(runners,3)
  for (r in runners){
    testthat::expect_true(all(c("os","bioc","r") %in% names(r)))
  }
  
  testthat::expect_error(
    construct_runners(bioc=c("typo"="typo"))
  ) 
  testthat::expect_error(
    construct_runners(r=c("typo"="typo"))
  )
  testthat::expect_error(
    construct_runners(cont=c("typo"="typo"))
  )
})
