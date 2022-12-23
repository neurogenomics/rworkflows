test_that("bioc_r_versions works", {
  
  ver1 <- bioc_r_versions(bioc_version="devel")
  testthat::expect_true(ver1$bioc>=3.17)
  testthat::expect_true(ver1$r>="4.2.0")
  
  ver2 <- bioc_r_versions(bioc_version="release")
  testthat::expect_true(ver2$bioc>=3.16)
  testthat::expect_true(ver2$r>="4.2.0")
})
