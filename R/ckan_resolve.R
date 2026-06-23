#' Resolve a CKAN resource by name pattern
#'
#' Queries a CKAN open-data portal's `package_show` endpoint and
#' returns metadata for the first *resource* whose `name` field
#' matches a supplied regular expression. CKAN powers many government
#' open-data portals (Ontario, UK, Canada, US federal); resource UUIDs
#' occasionally change between portal updates but resource names are
#' usually stable, so name-pattern matching survives portal reslugs.
#'
#' @param portal Base URL of the CKAN portal, without trailing slash.
#'   Example: `"https://data.ontario.ca"`.
#' @param package_slug CKAN package slug. Example:
#'   `"data-on-inmates-in-ontario"`.
#' @param name_pattern PCRE-compatible regex applied case-insensitively
#'   to each resource's `name` field. The first match wins.
#' @param timeout Request timeout in seconds. Default `30`.
#'
#' @return A list with elements `name`, `url`, `format`, `resource_id`,
#'   and `package_slug`, or `NULL` if the package is not found, the API
#'   call fails, or no resource matches.
#'
#' @examples
#' \donttest{
#' res <- rmorielite_ckan_resolve(
#'   portal        = "https://data.ontario.ca",
#'   package_slug  = "data-on-inmates-in-ontario",
#'   name_pattern  = "Restrictive.?Confinement.*Detailed.?Dataset"
#' )
#' if (!is.null(res)) res$url
#' }
#'
#' @export
rmorielite_ckan_resolve <- function(portal,
                                    package_slug,
                                    name_pattern,
                                    timeout = 30) {
  stopifnot(
    is.character(portal),       length(portal)       == 1L, nzchar(portal),
    is.character(package_slug), length(package_slug) == 1L, nzchar(package_slug),
    is.character(name_pattern), length(name_pattern) == 1L, nzchar(name_pattern),
    is.numeric(timeout),        timeout > 0
  )
  if (!requireNamespace("httr2", quietly = TRUE))
    stop("Package 'httr2' is required. Install with: install.packages('httr2')")

  req <- httr2::request(sub("/$", "", portal))
  req <- httr2::req_url_path_append(req, "api", "3", "action", "package_show")
  req <- httr2::req_url_query(req, id = package_slug)
  req <- httr2::req_timeout(req, timeout)
  req <- httr2::req_user_agent(req,
    paste0("rmorielite/", utils::packageVersion("rmorielite")))

  resp <- tryCatch(httr2::req_perform(req), error = function(e) NULL)
  if (is.null(resp) || httr2::resp_is_error(resp)) return(NULL)

  body <- httr2::resp_body_json(resp, simplifyVector = FALSE)
  if (!isTRUE(body$success)) return(NULL)

  for (r in body$result$resources) {
    nm <- if (is.null(r$name)) "" else r$name
    if (grepl(name_pattern, nm, ignore.case = TRUE, perl = TRUE)) {
      return(list(
        name         = nm,
        url          = r$url,
        format       = r$format,
        resource_id  = r$id,
        package_slug = package_slug
      ))
    }
  }
  NULL
}
