#' Polite, cache-aware HTTPS fetch
#'
#' Downloads a single URL to the per-user cache directory (see
#' [`rmorielite_cache_dir()`]) using `httr2` with built-in throttling
#' and exponential-backoff retry on 429/5xx. If a non-empty cached
#' copy at the same target path already exists, the download is
#' skipped and the cached path is returned.
#'
#' Throttling and retry are delegated to [`httr2::req_throttle()`] and
#' [`httr2::req_retry()`]. The default rate cap of 4 requests per
#' second matches the polite-by-default conventions used by major
#' public-data CKAN portals.
#'
#' @param url The URL to fetch.
#' @param dest_basename Filename (no path) under which to cache the
#'   result. Defaults to the URL's basename.
#' @param rate Requests per second. Default `4`.
#' @param force If `TRUE`, re-download even if a cached copy exists.
#'   Default `FALSE`.
#' @param max_tries Maximum retry attempts on transient errors
#'   (429, 5xx). Default `3`.
#'
#' @return A character scalar: the absolute path of the cached file.
#'
#' @examples
#' \donttest{
#' # Live network call; wrapped in try() so the example never errors if the
#' # portal is unreachable under R CMD check --run-donttest.
#' try({
#'   path <- rmorielite_fetch(
#'     "https://data.ontario.ca/api/3/action/package_list"
#'   )
#'   file.exists(path)
#' })
#' }
#'
#' @export
rmorielite_fetch <- function(url,
                             dest_basename = NULL,
                             rate          = 4,
                             force         = FALSE,
                             max_tries     = 3L) {
  stopifnot(
    is.character(url),         length(url) == 1L, nzchar(url),
    is.numeric(rate),          rate > 0,
    is.logical(force),         length(force) == 1L,
    is.numeric(max_tries),     max_tries >= 1L
  )
  if (!requireNamespace("httr2", quietly = TRUE))
    stop("Package 'httr2' is required. Install with: install.packages('httr2')")

  cache_root <- rmorielite_cache_dir(which = "cache", create = TRUE)
  if (is.null(dest_basename)) dest_basename <- basename(url)
  dest_path <- file.path(cache_root, dest_basename)

  if (!isTRUE(force) && file.exists(dest_path) && file.size(dest_path) > 0)
    return(normalizePath(dest_path, winslash = "/"))

  req <- httr2::request(url)
  req <- httr2::req_throttle(req, rate = rate, realm = "rmorielite")
  req <- httr2::req_retry(req, max_tries = as.integer(max_tries),
                          is_transient = function(resp) {
                            httr2::resp_status(resp) %in% c(429, 500, 502, 503, 504)
                          })
  req <- httr2::req_user_agent(req,
    paste0("rmorielite/", utils::packageVersion("rmorielite"),
           " (https://github.com/rootcoder007/rmorielite)"))

  resp <- httr2::req_perform(req, path = dest_path)
  httr2::resp_check_status(resp)
  normalizePath(dest_path, winslash = "/")
}
