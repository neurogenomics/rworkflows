test_that("infer_deps works", {
  
  
  #' #### Get example DESCRIPTION file ####
  url <- "https://github.com/neurogenomics/templateR/raw/master/DESCRIPTION"
  path <- tempfile(fileext = "DESCRIPTION")
  utils::download.file(url,path)
  
  # wd <- getwd()
  # setwd("../../")
  
  deps <- infer_deps(path = path)
  # imports <- c(
  #   'utils','here','BiocStyle','yaml','stats','desc','badger',
  #   'biocViews','data.table','renv','shiny','htmltools'
  # )
  # suggests <- c(
  #   'testthat','rmarkdown','remotes','covr','echodeps',
  #   'igraph','knitr','markdown','methods'
  # )
  # testthat::expect_equal(sort(deps$Imports),
  #                        sort(imports))
  # testthat::expect_equal(sort(deps$Suggests),
  #                        sort(suggests))
  suggests <- c("covr","knitr","markdown","remotes","rmarkdown","testthat")
  testthat::expect_true(all(suggests %in% deps$Suggests))
  
  
  #### Return just one output ####
  deps2 <- infer_deps(path = path,
                      which = "Imports")
  testthat::expect_false(is.list(deps2))
  # setwd(wd)
  
  #### Conflicting inputs ####
  testthat::expect_error(
    infer_deps(path = path,
               imports = "markdown",
               suggests = "markdown")
  )
  
})
