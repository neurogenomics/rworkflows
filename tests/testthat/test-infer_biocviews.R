test_that("infer_biocviews works", {
  
  # wd <- getwd()
  # setwd("../../")
  # 
  # # Don't run simply bc biocViews::recommendBiocViews is unable
  # ## to find the DESCRIPTION file when running examples.
  # biocviews1 <- infer_biocviews()
  # testthat::expect_equal(biocviews1,"Software")
  # 
  # biocviews2 <- infer_biocviews(include_branch = FALSE)
  # testthat::expect_null(biocviews2)
  # 
  # biocviews_manual = c("Software","Genetics","Transcriptomics")
  # biocviews3 <- infer_biocviews(biocviews = biocviews_manual)
  # testthat::expect_equal(biocviews3,biocviews_manual)
  # 
  # #### Errors ####
  # testthat::expect_error(
  #   infer_biocviews(branch = "typo")
  # )
  # testthat::expect_error(
  #   infer_biocviews(type = "typo")
  # )
  # 
  # setwd(wd)
})
