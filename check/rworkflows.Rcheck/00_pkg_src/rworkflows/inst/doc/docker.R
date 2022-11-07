## ----setup, include=FALSE-----------------------------------------------------
#### Package name ####
pkg <- read.dcf("../DESCRIPTION", fields = "Package")[1]
library(pkg, character.only = TRUE)
## Docker containers must be lowercase
pkg <- tolower(pkg)
#### Username of DockerHub account ####
docker_user <- "neurogenomicslab"

## ----Session Info-------------------------------------------------------------
utils::sessionInfo()

