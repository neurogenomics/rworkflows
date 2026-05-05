test_that("construct_authors works", {
  
  a1 <- construct_authors()
  
  testthat::expect_true(as.character(a1) %in% 
                          c("yourGivenName yourFamilyName <yourEmail@email.com> [cre] (ORCID: <https://orcid.org/0000-0001-2345-6789>)",
                            "yourGivenName yourFamilyName <yourEmail@email.com> [cre] (<https://orcid.org/0000-0001-2345-6789>)",
                            "yourGivenName yourFamilyName <yourEmail@email.com> [cre] (0000-0001-2345-6789)"))
  
  a2 <- construct_authors(authors = "Test 1, Test1")
  testthat::expect_equal(as.character(a2), "Test 1, Test1")
})
