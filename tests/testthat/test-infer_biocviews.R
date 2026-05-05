test_that("infer_biocviews works", {
  if (!is_gha()) testthat::skip_if_offline(host = "bioconductor.org")

  # Don't run simply bc biocViews::recommendBiocViews is unable
  ## to find the DESCRIPTION file when running examples.
  # biocviews1 <- infer_biocviews(pkgdir = "../../")
  # testthat::expect_equal(biocviews1,"Software")
  
  testthat::expect_equal(infer_biocviews(include_branch = FALSE),
                         c("Software","WorkflowManagement"))
  biocviews_manual = c("Software","Genetics","Transcriptomics")
  testthat::expect_equal(infer_biocviews(biocviews = biocviews_manual),
                         c(biocviews_manual,"WorkflowManagement"))

  #### Errors ####
  testthat::expect_error(
    infer_biocviews(branch = "typo")
  )
  testthat::expect_error(
    infer_biocviews(type = "typo")
  ) 
})
