codecov_graphs <- function(ref,
                           branch,
                           types=c("sunburst","tree","icicle"),
                           add_html=TRUE,
                           height=200,
                           style="vertical-align: top;",
                           token=NULL){
  # templateR:::args2vars(codecov_graphs)
  # ref="neurogenomics/rworkflows";branch="master" 
  
  #### Get graph types ###
  if(isTRUE(types)){
    types <- eval(formals(codecov_graphs)$types)
  }
  #### Make SVG link(s) ####
  lapply(stats::setNames(types,types), function(ty){
    URL <- paste0("https://codecov.io/gh/",
           ref,
           "/branch/",branch,
           "/graphs/",ty,".svg",
           if(!is.null(token)){paste0("?token=",token)} else {NULL}
           )
    if(isTRUE(add_html)){
      link <- paste0(
        "https://app.codecov.io/gh/",ref,"/tree/",branch
      )
      paste0(
        "<a href=",shQuote(link)," target='_blank'>",
        "<img src=",shQuote(URL),
        " height=",shQuote(height),
        " style=",shQuote(style),
        ">",
        "</a>"
        )
    } else {
      URL
    }
  })
}