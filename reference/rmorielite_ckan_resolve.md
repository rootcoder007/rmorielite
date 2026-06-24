# Resolve a CKAN resource by name pattern

Queries a CKAN open-data portal's `package_show` endpoint and returns
metadata for the first *resource* whose `name` field matches a supplied
regular expression. CKAN powers many government open-data portals
(Ontario, UK, Canada, US federal); resource UUIDs occasionally change
between portal updates but resource names are usually stable, so
name-pattern matching survives portal reslugs.

## Usage

``` r
rmorielite_ckan_resolve(portal, package_slug, name_pattern, timeout = 30)
```

## Arguments

- portal:

  Base URL of the CKAN portal, without trailing slash. Example:
  `"https://data.ontario.ca"`.

- package_slug:

  CKAN package slug. Example: `"data-on-inmates-in-ontario"`.

- name_pattern:

  PCRE-compatible regex applied case-insensitively to each resource's
  `name` field. The first match wins.

- timeout:

  Request timeout in seconds. Default `30`.

## Value

A list with elements `name`, `url`, `format`, `resource_id`, and
`package_slug`, or `NULL` if the package is not found, the API call
fails, or no resource matches.

## Examples

``` r
# \donttest{
res <- rmorielite_ckan_resolve(
  portal        = "https://data.ontario.ca",
  package_slug  = "data-on-inmates-in-ontario",
  name_pattern  = "Restrictive.?Confinement.*Detailed.?Dataset"
)
if (!is.null(res)) res$url
#> [1] "https://data.ontario.ca/dataset/09f7fc65-d3bb-4ca8-8b84-1cdc3ef73c36/resource/5a0c5804-a055-4031-9743-73f556e43bb4/download/a01_restrictive_confinement_detailed_dataset.csv"
# }
```
