test_that("infer_biocviews works", {
  if (!is_gha()) testthat::skip_if_offline(host = "bioconductor.org")

  # Resolve a pkgdir that contains DESCRIPTION in both devtools::test()
  # (source dir) and R CMD check (installed copy in temp library), since
  # here::here() doesn't anchor to the package under R CMD check.
  pkgdir <- dirname(system.file("DESCRIPTION", package = "rworkflows"))

  testthat::expect_equal(infer_biocviews(pkgdir = pkgdir,
                                         include_branch = FALSE),
                         c("Software","WorkflowManagement"))
  biocviews_manual = c("Software","Genetics","Transcriptomics")
  testthat::expect_equal(infer_biocviews(pkgdir = pkgdir,
                                         biocviews = biocviews_manual),
                         c(biocviews_manual,"WorkflowManagement"))

  #### Errors ####
  testthat::expect_error(
    infer_biocviews(branch = "typo")
  )
  testthat::expect_error(
    infer_biocviews(type = "typo")
  ) 
})
