test_that("messager works", {
     
        msg <- "Hello world"
        #### Default ####
        msg_out <- utils::capture.output(messager(msg),
                                         type = "message")
        testthat::expect_equal(msg, msg_out)
        #### Parallel ####
        f <- textConnection("test3", "w")
        msg_out2 <- utils::capture.output(messager(msg, parallel = TRUE),
                                          type = "message")
        testthat::expect_equal(msg_out2, character())  
})
