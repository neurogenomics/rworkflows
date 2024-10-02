test_that("construct_authors works", {
  
  a1 <- construct_authors()
  
  testthat::expect_true(as.character(a1) %in% 
                          c("yourGivenName yourFamilyName <yourEmail@email.com> [cre] (ORCID: yourOrcidId)",
                            "yourGivenName yourFamilyName <yourEmail@email.com> [cre] (yourOrcidId)"))
  
  a2 <- construct_authors(authors = "Test 1, Test1")
  testthat::expect_equal(as.character(a2), "Test 1, Test1")
})
