test_that("get_hex works", { 
  
  hex1 <- get_hex(refs="neurogenomics/rworkflows")
  hex2 <- get_hex(refs="rworkflows")
  hex3 <- get_hex(refs=NULL, 
                  paths=here::here("DESCRIPTION"))
  hex4 <- get_hex(refs=NULL, 
                  paths=NULL)
  testthat::expect_equal(hex2$rworkflows,
                         hex1$`neurogenomics/rworkflows`)  
  if(testthat::is_testing()){
    testthat::expect_null(hex3[[1]])
  } else {
    testthat::expect_equal(hex3[[1]], 
                           hex1[[1]])
  } 
  testthat::expect_null(hex4)
  
  
  #### Get example DESCRIPTION file #### 
  d <- get_description(refs="neurogenomics/rworkflows")[[1]]
  tmp <- tempfile(pattern = "DESCRIPTION")
  d$del(keys = "URL")
  d$write(tmp)
  hex5 <- get_hex(refs=NULL, 
                  paths=tmp)
  testthat::expect_equal(hex5[[1]], 
                         hex1[[1]])

})
