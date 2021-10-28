# r_workflows

Automated GitHub Action workflows for R package development.


----- R Package Dockerfile -----

This Dockerfile is designed for developers of any R package stored on GitHub.

It runs several steps:
  1. Pulls the official bioconductor Docker container (which includes Rstudio).
  2. Runs CRAN checks on the R package.
  3. Installs the R package and all of its dependencies (including Depends, Imports, and Suggests).

This Dockerfile should be used with the [dockerhub.yml](https://github.com/neurogenomics/orthogene/blob/main/.github/workflows/dockerhub.yml) workflow file,
as you must first checkout the R package from GitHub,
along with several other GitHub Actions.

If the R package passes all checks, the dockerhub.yml workflow will subsequently
push the Docker container to DockerHub (using the username and token credentials
stored as GitHub Secrets).

You can then create an image of the Docker container in any command line:
  docker pull <DockerHub_repo_name>/<package_name>
Once the image has been created, you can launch it with:
  docker run -d -e ROOT=true -e PASSWORD=bioc -v ~/Desktop:/Desktop -v /Volumes:/Volumes --rm -p 8788:8787 <DockerHub_repo_name>/<package_name>
Finally, launch the containerised Rstudio by entering the following URL in any web browser:
  http://localhost:8788/

The username will be "rstudio" by default,
and you can set the password to whatever you like.