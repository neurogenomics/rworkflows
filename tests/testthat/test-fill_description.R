test_that("fill_description works", {
  
  url <- "https://github.com/neurogenomics/templateR/raw/master/DESCRIPTION"
  path <- tempfile(pattern = "DESCRIPTION")
  utils::download.file(url,path)
  
  d <- fill_description(
    path = path,
    package = "MyPackageName",
    title = "This Package Does Awesome Stuff",
    description = paste(
      "MyPackageName does several awesome things.",
      "Describe thing1.",
      "Describe thing2.",
      "Describe thing3."
    ),
    github_owner = "OwnerName", 
    biocviews = c("Genetics", "SystemsBiology"),
    suggests = NA)
  
  testthat::expect_true(methods::is(d,"description"))
  f <- c('Package','Type','Title','Version','Authors@R',
         'Description','URL','BugReports','Encoding','Depends',
         'biocViews','Imports','RoxygenNote',
         'VignetteBuilder','License','Config/testthat/edition')
  testthat::expect_true(all(f %in% d$fields()))
  testthat::expect_true(!"Suggests" %in% d$fields())
  # usethis::use_description_defaults()
})
