test_that("dt_to_desc works", {
  
   # db <- BiocPkgTools::biocPkgList()
   db <- rworkflows::biocpkgtools_db
   dl <- dt_to_desc(db=db, refs="ABSSeq")
  testthat::expect_true(methods::is(dl[[1]],"description"))
})
