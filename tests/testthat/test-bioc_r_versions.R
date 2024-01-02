test_that("bioc_r_versions works", {
  ## Don't run on CRAN servers due to ongoing internet connectivity issues
  if(!is_gha()) testthat::skip_if_offline()
  
  ver1 <- bioc_r_versions(bioc_version="devel")
  testthat::expect_true(ver1$bioc>="3.17")
  testthat::expect_true(ver1$r>="4.2.0")
  
  ver2 <- bioc_r_versions(bioc_version="release")
  testthat::expect_true(ver2$bioc>="3.16")
  testthat::expect_true(ver2$r>="4.2.0")
  
  ver3 <- bioc_r_versions(bioc_version="3.16")
  testthat::expect_true(ver3$bioc>="3.16")
  testthat::expect_true(ver3$r>="4.2")
  
  ver4 <- bioc_r_versions(bioc_version=NULL)
  testthat::expect_length(ver4,3)
  testthat::expect_gte(length(ver4$r_ver_for_bioc_ver),37)
  
  ver5 <- bioc_r_versions(bioc_version="devel", 
                          depth = 2)
  testthat::expect_true(ver5$bioc>="3.17")
  testthat::expect_true(ver5$r>="4.3")
  
  ver6 <- bioc_r_versions(bioc_version="devel", 
                          depth = 5)
  testthat::expect_true(ver6$bioc>="3.17")
  testthat::expect_true(ver6$r>="4.3")
})
