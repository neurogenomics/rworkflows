test_that("get_github_url_db works", {
  
  #### Prepare daa ####
  db <- rworkflows::biocpkgtools_db
  db$url_github <- NULL
  
  #### When db=NULL ####
  testthat::expect_null(get_github_url_db(db = NULL))
  
  #### When all columns provided ####
  testthat::expect_equal(
    sum(!is.na(get_github_url_db(db = db))),
    39
  )
  #### When only some columns provided ####
  db$BugReports <- NULL
  db$git_url <- NULL
  testthat::expect_equal(
    sum(!is.na(get_github_url_db(db = db))),
    25
  )
})
