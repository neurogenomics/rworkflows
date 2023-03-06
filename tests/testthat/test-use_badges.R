test_that("use_badges works", {
   
  run_tests <- function(badges){
    testthat::expect_length(badges,1)
    testthat::expect_type(badges,"character")
  } 
  badges <- use_badges(ref = "neurogenomics/rworkflows",
                       add_hex = TRUE, 
                       add_actions = "rworkflow", 
                       add_doi = "doi:000000",
                       add_lifecycle = "experimental",
                       add_github_version = TRUE, 
                       add_commit = TRUE,
                       add_code_size = TRUE, 
                       add_codecov = TRUE, 
                       add_codecov_graphs = TRUE,
                       add_license = TRUE, 
                       add_authors = TRUE,
                       add_cran_release = TRUE,
                       add_cran_checks = TRUE, 
                       add_cran_download_month = TRUE, 
                       add_cran_download_total = TRUE
                       ) 
  run_tests(badges) 
  
  #### Explicitly specify package ####
  badges3 <- use_badges(ref = "BiocManager", 
                        add_hex = FALSE,
                        add_bioc_release = TRUE,
                        add_bioc_download_month = TRUE,
                        add_bioc_download_total = TRUE,
                        add_bioc_download_rank = TRUE,
                        ## These only work if you have the DESCRIPTION file
                        ## or a proper ref in the format owner/repo
                        add_github_version = FALSE,
                        add_license = FALSE, 
                        add_authors = FALSE,
                        as_list = TRUE)  
  testthat::expect_gte(length(badges3),8)
  
})
