test_that("get_description works", {
  
  run_tests <- function(dl){
    for(i in seq_len(length(dl))){
      d <- dl[[i]]
      testthat::expect_true(methods::is(d,"description"))
      testthat::expect_equal(basename(names(dl)[i]),
                             d$get_field("Package"))
    }
  }
   
  d1 <- get_description(refs="neurogenomics/rworkflows") 
  d2 <- get_description(refs="neurogenomics/rworkflows", 
                        paths=here::here("typo","DESCRIPTION")) 
  
  d3 <- get_description(refs="neurogenomics/rworkflows", 
                        paths="typo")
  d4 <- get_description(refs="rworkflows", 
                        paths="typo")
  d5 <- get_description(refs="typoooo", 
                        paths="typo")
  d6 <- get_description(refs=NULL, 
                        paths="typo")
  d7 <- get_description(refs=NULL, 
                        paths=here::here("DESCRIPTION")
                        )
  d8 <- get_description(refs=c("stats","data.table"), 
                        paths=NULL)
  tmp <- tempfile()
  utils::download.file("https://github.com/neurogenomics/MAGMA_Celltyping/raw/master/DESCRIPTION",tmp)
  d9 <- get_description(refs="MAGMA_Celltyping",
                        paths=tmp) 
  d10 <- get_description(refs = "ABSSeq", 
                         use_wd = FALSE,
                         db = rworkflows::biocpkgtools_db,
                         use_repos = TRUE)
  d11 <- get_description(refs = d1)
  d12 <- get_description(paths = d1)
  
  run_tests(d1)
  run_tests(d2)
  run_tests(d3)
  run_tests(d4) 
  run_tests(d8) 
  testthat::expect_true(methods::is(d9[[1]],"description"))
  run_tests(d10) 
  run_tests(d11) 
  run_tests(d12) 
  testthat::expect_equal(d2$`neurogenomics/rworkflows`,
                         d1$`neurogenomics/rworkflows`) 
  testthat::expect_equal(d3,d1)
  testthat::expect_equal(d4$rworkflows,
                         d1$`neurogenomics/rworkflows`)
  testthat::expect_null(d5$typoooo)
  testthat::expect_null(d6[[1]])
  
  
  if(is_gha() && testthat::is_testing()){ 
    testthat::expect_equal(d7[[1]],
                           d1[[1]])
  } else{
    testthat::expect_null(d7[[1]])
  }
  
  #### Search CRAN/Bioc repos ####
  ## Don't run on CRAN due to issues on their server: 
  ## https://github.com/neurogenomics/rworkflows/issues/65
  if (is_gha() || is_rstudio()) {
    d13 <- get_description(refs="ABSSeq",
                           db = rworkflows::biocpkgtools_db, 
                           use_repos = TRUE) 
    testthat::expect_equal(d13[[1]],
                           d1[[1]])
    
    d13 <- get_description(refs="ABSSeq",
                           db = NULL, 
                           use_repos = TRUE) 
    testthat::expect_equal(d13[[1]],
                           d1[[1]])
  }  
  #### Search GitHub repos ####
  d14 <- get_description(refs="neurogenomics/orthogene",
                         use_wd = FALSE) 
  if(is_gha()){
    testthat::expect_false(methods::is(d14[[1]],"description"))
  } else {
    testthat::expect_true(methods::is(d14[[1]],"description"))
  }
})
