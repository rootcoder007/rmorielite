# Changelog

## rmorielite 0.1.0

- Initial release.
- [`rmorielite_cache_dir()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_cache_dir.md)
  — per-user cache/data/config directories. Defaults to a sub-tree of
  the R session [`tempdir()`](https://rdrr.io/r/base/tempfile.html)
  (CRAN-policy compliant). Persistent storage at
  [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html) is
  opt-in via `persistent = TRUE` or the `RMORIELITE_PERSISTENT_CACHE`
  env var.
- [`rmorielite_ckan_resolve()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_ckan_resolve.md)
  — resolves a CKAN resource by package slug + name-pattern match.
  Survives portal reslugs because resource UUIDs are not assumed stable.
  Uses `httr2`.
- [`rmorielite_fetch()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_fetch.md)
  — polite, cache-aware HTTPS fetch using `httr2` with token-bucket
  throttling (4 req/s by default) and exponential- backoff retry on
  429/5xx.
