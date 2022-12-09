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
dgc_out <- echodeps::dep_graph_create(pkg_name = "rworkflows",
                                      method = "github",
                                      node_size = "clones_uniques")
#### Subset graph ####
## Remove repos that are automatically created by GitHub to check actions
## published on the GitHub Actions marketplace.
g <- dgc_out$subgraph
exclude <- grep("actions-marketplace-validations",
                names(igraph::V(g)),value = TRUE)
g2 <- echodeps::subset_graph(g=g, exclude=exclude)
#### Plot graph ####
colors <- echodeps::construct_colors(save_background = "transparent",
                                     background = "transparent")
vis <- echodeps::dep_graph_plot(g = g2,
                                shape = "hexagon",
                                pkg_name = dgc_out$pkg_name,
                                colors = colors,
                                save_path = here::here(
                                  "depgraph","rworkflows_depgraph.html"))
#### Remove temp files ####
unlink(here::here("depgraph","rworkflows_depgraph_files"), recursive = TRUE)
