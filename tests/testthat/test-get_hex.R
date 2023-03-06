test_that("get_hex works", { 
  
  hex1 <- get_hex(ref="neurogenomics/rworkflows")
  hex2 <- get_hex(ref="rworkflows")
  hex3 <- get_hex(ref=NULL, 
                  path=here::here("DESCRIPTION"))
  
  testthat::expect_equal(hex2, hex1)
  if(is_gha()){
    testthat::expect_equal(hex3, hex1)  
  } else {
    testthat::expect_null(hex3)  
  }
})
