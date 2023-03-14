## -------------------------------------------------------------------------- ##
## Code to create a dependency graph 
## for all GitHub repos that use the rworkflows GitHub Action.
## -------------------------------------------------------------------------- ##

#### Install required packages ####
if(!require("rworkflows"))remotes::install_github("neurogenomics/rworkflows",
                                                  dependencies = TRUE)
if(!require("echodeps"))remotes::install_github("RajLabMSSM/echodeps",
                                                dependencies = TRUE)
#### Create graph ####
res <- echodeps::dep_graph(pkg = "rworkflows",
                 method_seed = "github",
                 save_path = here::here(
                   "reports","rworkflows_depgraph.html"),
                 reverse = TRUE)
saveRDS(res,here::here("reports","depgraph.rds")) 
# #### Remove temp files ####
unlink(here::here("reports","rworkflows_depgraph_files"), recursive = TRUE)
