test_that("dt_to_desc works", {
  
   db <-   BiocPkgTools::biocPkgList()
   dl <- dt_to_desc(db=db, refs="GenomicRanges")
   testthat::expect_true(methods::is(dl[[1]],"description"))
})
