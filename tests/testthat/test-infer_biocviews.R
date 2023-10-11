test_that("infer_biocviews works", { 
  # Don't run simply bc biocViews::recommendBiocViews is unable
  ## to find the DESCRIPTION file when running examples.
  # biocviews1 <- infer_biocviews(pkgdir = "../../")
  # testthat::expect_equal(biocviews1,"Software")
  
  # 
  if(testthat::is_testing() &&
     !is_gha()){
    testthat::expect_error(
      infer_biocviews(include_branch = FALSE)
    )
  } else {
    testthat::expect_equal(infer_biocviews(include_branch = FALSE),
                           c("`Software","WorkflowManagement"))  
  }
  biocviews_manual = c("Software","Genetics","Transcriptomics") 
  if(testthat::is_testing() && !is_gha()){
    testthat::expect_error(
      infer_biocviews(biocviews = biocviews_manual)
    )
  } else {
    testthat::expect_equal(infer_biocviews(biocviews = biocviews_manual),
                           c(biocviews_manual,"WorkflowManagement"))
  }

  #### Errors ####
  testthat::expect_error(
    infer_biocviews(branch = "typo")
  )
  testthat::expect_error(
    infer_biocviews(type = "typo")
  ) 
})
