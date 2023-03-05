test_that("get_description works", {
   
  d1 <- get_description(ref="neurogenomics/rworkflows") 
  d2 <- get_description(ref="neurogenomics/rworkflows", 
                        path=here::here("typo","DESCRIPTION")) 
  
  d3 <- get_description(ref="neurogenomics/rworkflows", 
                        path="typo")
  d4 <- get_description(ref="rworkflows", 
                        path="typo")
  d5 <- get_description(ref="typoooo", 
                        path="typo")
  d6 <- get_description(ref=NULL, 
                        path="typo")
  d7 <- get_description(ref=NULL, 
                        path=here::here("DESCRIPTION"))
  
  testthat::expect_equal(d1,d2)
  testthat::expect_equal(d1,d3)
  testthat::expect_equal(d1,d4)
  testthat::expect_null(d5)
  testthat::expect_null(d6)
  testthat::expect_null(d7)
})
