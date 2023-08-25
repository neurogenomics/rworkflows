test_that("get_authors works", {
  
  true_auths <- "Brian Schilder, Alan Murphy, Nathan Skene"
  #### ref is NULL ####
  auths1 <- get_authors(ref = NULL)
  testthat::expect_null(auths1)
  #### Ref is filled: has authors ####
  auths2 <- get_authors(ref = "rworkflows")
  testthat::expect_equal(auths2, true_auths)
  #### Ref is filled: has modified authors ####
  d <- get_description(refs="neurogenomics/rworkflows")[[1]]
  tmp <- tempfile(pattern = "DESCRIPTION")
  d$del("Authors@R")
  d$del("Author")
  auths3 <- get_authors(ref = d)
  testthat::expect_null(auths3)
})
