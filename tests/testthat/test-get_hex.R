test_that("get_hex works", { 
  
  #### When repo name provided ####
  hex1 <- get_hex(refs="neurogenomics/rworkflows")
  #### When package name provided ####
  hex2 <- get_hex(refs="rworkflows")
  testthat::expect_equal(hex2$rworkflows,
                         hex1$`neurogenomics/rworkflows`)  
  #### When DESCRIPTION path provided ####
  hex3 <- get_hex(refs=NULL, 
                  paths=here::here("DESCRIPTION"))
  if(is_gha() && testthat::is_testing()){
    testthat::expect_equal(hex3[[1]], 
                           hex1[[1]])
  } else {
    message("Skipping test.")
  }
  #### When neither refs nor paths provided ####
  hex4 <- get_hex(refs=NULL, 
                  paths=NULL) 
  testthat::expect_null(hex4)
  #### Get example DESCRIPTION file #### 
  d <- get_description(refs="neurogenomics/rworkflows")[[1]]
  tmp <- tempfile(pattern = "DESCRIPTION")
  d$del(keys = "URL")
  d$write(tmp)
  hex5 <- get_hex(refs=NULL, 
                  paths=tmp)
  testthat::expect_equal(hex5[[1]], 
                         hex1[[1]])
  
  #### When git_url is included in DESCRIPTION ####
  d$set_list(key = "git_url", 
             list_value = "https://github.com/neurogenomics/rworkflows")
  d$write(tmp)
  hex6 <- get_hex(refs=NULL, 
                  paths=tmp)
  testthat::expect_equal(hex6[[1]], 
                         hex1[[1]])
  #### When paths length > refs length ####
  hex7 <- get_hex(refs="neurogenomics/rworkflows", 
                  paths = rep(here::here("DESCRIPTION"),2))
  testthat::expect_equal(hex7[[1]], 
                         hex1[[1]])
  #### Can't find URL: but URL inferred ####
  dl <- get_description(refs = "neurogenomics/rworkflows")
  dl[[1]]$del(keys = c("URL","BugReports"))
  hex8 <- get_hex(refs=dl)
  testthat::expect_equal(hex8[[1]], 
                         hex1[[1]])
  #### Can't find URL: but URL not inferred ####
  tmp <- tempfile(pattern = "DESCRIPTION")
  dl[[1]]$write(tmp)
  hex9 <- get_hex(refs = NULL,
                  paths = tmp)
  testthat::expect_null(hex9[[1]])
  #### Cant find URL: but URL doesn't exist ####
  hex10 <- get_hex(refs="neurogenomics/rworkflows", 
                   hex_path = "typoooo")
  testthat::expect_null(hex10[[1]])
  #### Don't add HTML ####
  hex11 <- get_hex(refs="rworkflows",
                   add_html = FALSE)
  testthat::expect_equal(
    hex11[[1]],
    "https://github.com/neurogenomics/rworkflows/raw/master/inst/hex/hex.png")
})
