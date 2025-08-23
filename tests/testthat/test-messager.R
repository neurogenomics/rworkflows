test_that("messager works", {
     
        msg <- "Hello world"
        #### Default ####
        msg_out <- utils::capture.output(messager(msg),
                                         type = "message")
        
        # Check if output contains the message
        msg_test <- grepl(msg, msg_out) |> any()
        testthat::expect_true(msg_test)
        #### Parallel ####
        f <- textConnection("test3", "w")
        msg_out2 <- utils::capture.output(messager(msg, parallel = TRUE),
                                          type = "message")
        testthat::expect_equal(msg_out2, character())  
})
