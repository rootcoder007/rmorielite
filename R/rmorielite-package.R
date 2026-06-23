#' rmorielite: Polite Retrieval of Canadian Carceral and Police-Oversight Data
#'
#' A focused, audited subset of the upstream `rmorie` toolkit, scoped
#' narrowly to data retrieval and extraction for openly-published
#' Canadian administrative datasets:
#' Ontario's OTIS (Offender Tracking Information System) restrictive-
#' confinement releases, and federal Structured Intervention Unit (SIU)
#' reports.
#'
#' @section Design principles:
#'
#' * **Polite by default.** Inter-request interval is enforced via a
#'   small on-disk state file; the default floor is one request every
#'   0.25 seconds. See [`rmorielite_fetch()`].
#' * **Cache by default.** Downloads land in the R-canonical user data
#'   directory via [`tools::R_user_dir()`]. Second fetches of the same
#'   URL are served from disk. See [`rmorielite_cache_dir()`].
#' * **Provenance by default.** SHA256 verification is available
#'   alongside every fetched file.
#' * **Minimum dependencies.** Only `stats`, `utils`, `jsonlite`, and
#'   `tools` are required. No `httr`, `curl`, `Rcpp`, or
#'   `tidyverse`-stack dependencies in the base install.
#'
#' @section rOpenSci review:
#'
#' This package is the "focused rewrite" requested by the rOpenSci
#' editorial board at \href{https://github.com/ropensci/software-review/issues/770}{software-review #770}.
#' The upstream multi-domain `rmorie` package remains available at
#' \url{https://github.com/rootcoder007/rmorie}; `rmorielite` is an
#' independent codebase, not a fork.
#'
#' @keywords internal
"_PACKAGE"
