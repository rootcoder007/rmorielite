# Polite, cache-aware HTTPS fetch

Downloads a single URL to the per-user cache directory (see
[`rmorielite_cache_dir()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_cache_dir.md))
using `httr2` with built-in throttling and exponential-backoff retry on
429/5xx. If a non-empty cached copy at the same target path already
exists, the download is skipped and the cached path is returned.

## Usage

``` r
rmorielite_fetch(
  url,
  dest_basename = NULL,
  rate = 4,
  force = FALSE,
  max_tries = 3L
)
```

## Arguments

- url:

  The URL to fetch.

- dest_basename:

  Filename (no path) under which to cache the result. Defaults to the
  URL's basename.

- rate:

  Requests per second. Default `4`.

- force:

  If `TRUE`, re-download even if a cached copy exists. Default `FALSE`.

- max_tries:

  Maximum retry attempts on transient errors (429, 5xx). Default `3`.

## Value

A character scalar: the absolute path of the cached file.

## Details

Throttling and retry are delegated to
[`httr2::req_throttle()`](https://httr2.r-lib.org/reference/req_throttle.html)
and
[`httr2::req_retry()`](https://httr2.r-lib.org/reference/req_retry.html).
The default rate cap of 4 requests per second matches the
polite-by-default conventions used by major public-data CKAN portals.

## Examples

``` r
# \donttest{
path <- rmorielite_fetch(
  "https://data.ontario.ca/api/3/action/package_list"
)
file.exists(path)
#> [1] TRUE
# }
```
