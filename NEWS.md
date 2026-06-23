# rmorielite 0.1.0

* Initial release.
* `rmorielite_cache_dir()` — per-user cache/data/config directories.
  Defaults to a sub-tree of the R session `tempdir()` (CRAN-policy
  compliant). Persistent storage at `tools::R_user_dir()` is opt-in
  via `persistent = TRUE` or the `RMORIELITE_PERSISTENT_CACHE` env var.
* `rmorielite_ckan_resolve()` — resolves a CKAN resource by package
  slug + name-pattern match. Survives portal reslugs because resource
  UUIDs are not assumed stable. Uses `httr2`.
* `rmorielite_fetch()` — polite, cache-aware HTTPS fetch using `httr2`
  with token-bucket throttling (4 req/s by default) and exponential-
  backoff retry on 429/5xx.
