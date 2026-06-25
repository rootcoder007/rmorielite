#' rmorielite: Polite Retrieval of Canadian Carceral and Police-Oversight Data
#'
#' A focused interface to the upstream `rmorie` toolkit for retrieving,
#' mining, and analysing open carceral, policing, police-oversight, and
#' public-health data -- correctional tracking and segregation (OTIS),
#' special-investigations and oversight bodies (SIU, ARSAU), municipal
#' police services (Toronto, Chicago, New York, Vancouver), and
#' substance-use surveys (Canadian Cannabis Survey, CPADS, and related
#' Health Infobase / CIHI tables).
#'
#' @section Design principles:
#'
#' * **Polite by default.** Inter-request interval is enforced via a
#'   small on-disk state file; the default floor is one request every
#'   0.25 seconds. See [`rmorielite_fetch()`].
#' * **Cache by default.** Downloads land in the R session temporary
#'   directory ([`tempdir()`]); set `RMORIELITE_PERSISTENT_CACHE=1` to
#'   opt in to a persistent cache via [`tools::R_user_dir()`]. Second
#'   fetches of the same URL are served from disk. See
#'   [`rmorielite_cache_dir()`].
#' * **Provenance by default.** SHA256 verification is available
#'   alongside every fetched file.
#' * **Focused re-export.** rmorielite imports the upstream `rmorie`
#'   toolkit and `rmoriebricklayer`, re-exporting their domain and
#'   provenance APIs, and adds its own small `httr2`-based polite,
#'   cache-aware fetch layer.
#'
#' @section Relationship to rmorie:
#'
#' `rmorielite` is a focused interface to the carceral, policing, and
#' public-health data domain. The upstream multi-domain `rmorie` package
#' is available at \url{https://github.com/rootcoder007/rmorie}.
#'
#' @keywords internal
"_PACKAGE"
