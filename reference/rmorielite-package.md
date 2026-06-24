# rmorielite: Polite Retrieval of Canadian Carceral and Police-Oversight Data

A focused, audited subset of the upstream `rmorie` toolkit, scoped
narrowly to data retrieval and extraction for openly-published Canadian
administrative datasets: Ontario's OTIS (Offender Tracking Information
System) restrictive- confinement releases, and federal Structured
Intervention Unit (SIU) reports.

## Design principles

- **Polite by default.** Inter-request interval is enforced via a small
  on-disk state file; the default floor is one request every 0.25
  seconds. See
  [`rmorielite_fetch()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_fetch.md).

- **Cache by default.** Downloads land in the R-canonical user data
  directory via
  [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html). Second
  fetches of the same URL are served from disk. See
  [`rmorielite_cache_dir()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_cache_dir.md).

- **Provenance by default.** SHA256 verification is available alongside
  every fetched file.

- **Minimum dependencies.** Only `stats`, `utils`, `jsonlite`, and
  `tools` are required. No `httr`, `curl`, `Rcpp`, or `tidyverse`-stack
  dependencies in the base install.

## Relationship to rmorie

`rmorielite` is a focused interface to the carceral, policing, and
public-health data domain. The upstream multi-domain `rmorie` package is
available at <https://github.com/rootcoder007/rmorie>.

## See also

Useful links:

- <https://github.com/rootcoder007/rmorielite>

- Report bugs at <https://github.com/rootcoder007/rmorielite/issues>

## Author

**Maintainer**: Vansh Singh Ruhela <vsruhela@proton.me>
([ORCID](https://orcid.org/0009-0004-1750-3592))

Authors:

- Vansh Singh Ruhela <vsruhela@proton.me>
  ([ORCID](https://orcid.org/0009-0004-1750-3592))
