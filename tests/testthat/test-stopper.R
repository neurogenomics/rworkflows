test_that("stopper works", {
  
  testthat::expect_error(
    stopper("stop message")
  )
  testthat::expect_error(
    stopper("stop message",v=FALSE)
  )
})
