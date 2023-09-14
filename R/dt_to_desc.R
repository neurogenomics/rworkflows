#' \link[data.table]{data.table} to \link[desc]{desc}
#' 
#' Convert \link[data.table]{data.table} containing the
#'  parsed \emph{DESCROPTION} file data and convert each of them to 
#'  to \link[desc]{desc} format.
#' @param db A \link[data.table]{data.table} where each row is a different R package
#' and each column is a field from the \emph{DESCROPTION} file.
#' @param verbose Print messages.
#' @inheritParams get_description
#' @returns A named list of \link[desc]{desc} objects.
#' 
#' @export
#' @importFrom stats setNames
#' @importFrom  data.table as.data.table 
#' @import desc
#' @examples 
#' #### Updated data ####
#' # db <- BiocPkgTools::biocPkgList()
#' #### Static data ####
#'  db <- rworkflows::biocpkgtools_db
#'  dl <- dt_to_desc(db=db, refs="ABSSeq")
dt_to_desc <- function(db,
                       refs=NULL,
                       verbose=TRUE){
  
  Package <- NULL;
  
  refs <- check_refs_names(refs)
  db <- data.table::as.data.table(db)
  #### Set up refs ####
  if(is.null(refs)){
    refs <- db$Package
  }else{
    refs <- refs[basename(names(refs)) %in% db$Package]
  }
  #### Name refs ####
  if(is.null(names(refs))) names(refs) <- refs
  messager("Constructing DESCRIPTION files for",
           formatC(length(refs),big.mark = ","),"R package(s).",v=verbose)
  valid_fields <- desc::cran_valid_fields
  lapply(stats::setNames(names(refs),
                         refs),
         function(p){
           p <- basename(p)
           messager("Constructing DESCRIPTION for:",p,v=verbose)
           db_sub <- db[Package==p,][1,]
           d <- desc::description$new("!new")
           for(k in names(db_sub)){ 
             vals <- db_sub[[k]]
             if(is.list(vals)) vals <- unlist(vals)
             vals <- vals[vals!=""]
             if(k %in% valid_fields &&
                !all(is.na(vals))){ 
               d$set_list(key = k, 
                          list_value = vals) |> 
                 suppressWarnings() 
             }
           }
           d
         })
}
