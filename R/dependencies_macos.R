#' MacOS dependencies
#' 
#' Construct a command to install system dependencies for the 
#' Mac OS environment.
#' 
#'### --- Justifications for each package --- ####
#'## libxml2 ###
#' Enable installing XML from source if needed
#'## imagemagick@6 ###
#' Required to install magick as noted at
#' https://github.com/r-lib/usethis/commit/f1f1e0d10c1ebc75fd4c18fa7e2de4551fd9978f#diff-9bfee71065492f63457918efcd912cf2
#'## harfbuzz fribidi ###
#' For textshaping, required by ragg, and required by pkgdown
#'## libgit2 ###
#' For installing usethis's dependency gert
#'## xquartz --cask ###
#' Required for tcltk
#'## libxfont ###
#' Required for some ggplot2 functions
#'## texlive ###
#' Required for rendering Sweave files (even with r-lib/actions/setup-tinytex)
#' @param cask Additional dependencies to install via cask.
#' @inheritParams dependencies_linux
#' @returns Command to install system dependencies.
#' 
#' @export
#' @examples
#' dependencies_macos()
dependencies_macos <- function(extra=c("libxml2",
                                       "harfbuzz",
                                       "fribidi",
                                       "libgit2",
                                       "texlive",
                                       "imagemagick@6",
                                       "rsync"),
                               cask = c("xquartz"),
                               prefix="brew install",
                               verbose=TRUE){ 
  # devoptera::args2vars(macos_dependencies)  
  
  ### Install normally ###
  cmd <- paste(prefix,paste(extra,collapse=" "))
  ### Install via cask ###
  if(length(cask) > 0){
    cmd <- paste(
      cmd,
      paste(prefix,paste(cask,collapse=" "),"--cask"),
      sep=" && "
    ) 
  } 
  messager(cmd,v=verbose)
  cat(cmd)
}
