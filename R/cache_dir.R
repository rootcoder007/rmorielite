#' Resolve the package cache directory
#'
#' Returns the directory `rmorielite` uses for cached resources. By
#' default this is a sub-tree of the R **session temporary directory**
#' (`tempdir()`) -- files are cleaned up automatically when R exits, in
#' line with the CRAN policy that packages must not write outside the
#' session temp area without explicit user consent.
#'
#' To opt in to a *persistent* cache that survives R sessions, set the
#' environment variable `RMORIELITE_PERSISTENT_CACHE=1` or pass
#' `persistent = TRUE`. The persistent location follows R's official
#' convention via [`tools::R_user_dir()`] -- on macOS that is
#' `~/Library/Application Support/.../rmorielite`, on Windows
#' `%LOCALAPPDATA%\R\.../rmorielite`, and on Linux
#' `$XDG_DATA_HOME/R/rmorielite` (or `~/.local/share/R/rmorielite` if
#' `XDG_DATA_HOME` is unset).
#'
#' @param which One of `"data"`, `"cache"`, `"config"`; matches the
#'   `which` argument of [`tools::R_user_dir()`]. Defaults to `"cache"`.
#' @param create Logical. If `TRUE` (the default), create the
#'   directory recursively if it does not yet exist.
#' @param persistent Logical or `NULL`. If `NULL` (the default), reads
#'   the environment variable `RMORIELITE_PERSISTENT_CACHE`. If `TRUE`,
#'   uses [`tools::R_user_dir()`]; if `FALSE`, uses `tempdir()`.
#'
#' @return A character scalar: the absolute path of the directory.
#'
#' @examples
#' rmorielite_cache_dir()                  # default: session tempdir
#' rmorielite_cache_dir(persistent = TRUE, create = FALSE) # opt in to R_user_dir
#'
#' @export
rmorielite_cache_dir <- function(which      = c("cache", "data", "config"),
                                 create     = TRUE,
                                 persistent = NULL) {
  which <- match.arg(which)
  if (is.null(persistent)) {
    env <- Sys.getenv("RMORIELITE_PERSISTENT_CACHE", "FALSE")
    persistent <- isTRUE(as.logical(env))
  }
  path <- if (isTRUE(persistent)) {
    tools::R_user_dir("rmorielite", which = which)
  } else {
    file.path(tempdir(), "rmorielite", which)
  }
  if (isTRUE(create) && !dir.exists(path)) {
    dir.create(path, recursive = TRUE, showWarnings = FALSE)
  }
  normalizePath(path, mustWork = FALSE, winslash = "/")
}
