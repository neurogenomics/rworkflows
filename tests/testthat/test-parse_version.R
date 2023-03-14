test_that("parse_version works", {
  
  v <- parse_version(v = "4.2.0",depth = 1)
  testthat::expect_equal(v,"4")
  
  v2 <- parse_version(v = "4.2.0", 
                     depth = 4,
                     as_package_version = FALSE)
  testthat::expect_equal(v2,"4.2.0.0")
  
  testthat::expect_error(
    parse_version(v = "4.2.0",depth = 0)
  )
})
