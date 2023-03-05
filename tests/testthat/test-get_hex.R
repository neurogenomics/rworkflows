test_that("get_hex works", {
  
  hex1 <- get_hex(ref="neurogenomics/rworkflows")
  hex2 <- get_hex(ref="rworkflows")
  hex3 <- get_hex(ref=NULL, 
                  path=here::here("DESCRIPTION"))
  
  testthat::expect_equal(hex1, hex2)
  testthat::expect_null(hex3)
})
