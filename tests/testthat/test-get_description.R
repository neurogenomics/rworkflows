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
  
  testthat::expect_equal(d2,d1)
  testthat::expect_equal(d3,d1)
  testthat::expect_equal(d4,d1)
  testthat::expect_null(d5)
  testthat::expect_null(d6)
  if(is_gha()){
    testthat::expect_equal(d7,d1)  
  } else {
    testthat::expect_null(d7)
  }
  
})
