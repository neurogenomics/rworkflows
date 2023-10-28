#' Construct a conda yaml
#' 
#' Construct a yaml file to be used for building a given \code{conda} 
#' environment.
#' @returns description
#' @param name Name of \code{conda} env.
#' @param channels \code{conda} channels to use.
#' @param dependencies Packages to install via \code{conda}.
#' @param pip Packages to install via \code{pip}.
#' @param verbose Print messages.
#' @param save_path Path to save the yaml file to.
#' @param return_path Return the path to the saved \emph{yaml} workflow file
#' (default: \code{TRUE}), or return the \emph{yaml} object directly.
#' @param preview Print the yaml file to the R console.
#' @returns Path or yaml object.
#' 
#' @export
#' @importFrom yaml read_yaml
#' @examples
#' yml <- construct_conda_yml(name="myenv",
#'                            dependencies=c("anndata","scanpy"),
#'                            return_path = FALSE,  
#'                            ## Writing to temp only for example
#'                            save_path=tempfile(fileext="myenv_conda.yml"))
construct_conda_yml <- function(name = "test",
                                channels = list("conda-forge", 
                                                "nodefaults"),
                                dependencies = list(),
                                pip = NULL,
                                save_path = here::here(
                                  paste0(name,"_conda.yml")
                                ),
                                return_path = TRUE,
                                preview = FALSE,
                                verbose = TRUE
                                ){
  # devoptera::args2vars(construct_conda_yml) 
  
  if(is.vector(dependencies)) dependencies <- as.list(dependencies)
  if(is.vector(pip)) pip <- as.list(pip)
  yml <- list(
    name=name,
    channels=channels,
    dependencies=dependencies
  )
  if(!is.null(pip)){
    yml[["dependencies"]] <- c(unique(c(yml[["dependencies"]],"pip")),
                               list(list(pip=pip))) 
  }
  #### Preview ####
  if(isTRUE(preview)){
    preview_yaml(yml=yml) 
  }
  #### Save yaml #### 
  path_or_yaml <- return_yaml(yml=yml,
                              path=save_path,
                              return_path=return_path,
                              verbose=verbose, 
                              indent.mapping.sequence = TRUE)
  return(path_or_yaml)
}
