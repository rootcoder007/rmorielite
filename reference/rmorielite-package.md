# rmorielite: Polite Retrieval of Canadian Carceral and Police-Oversight Data

A focused interface to the upstream `rmorie` toolkit for retrieving,
mining, and analysing open carceral, policing, police-oversight, and
public-health data – correctional tracking and segregation (OTIS),
special-investigations and oversight bodies (SIU, ARSAU), municipal
police services (Toronto, Chicago, New York, Vancouver), and
substance-use surveys (Canadian Cannabis Survey, CPADS, and related
Health Infobase / CIHI tables).

## Design principles

- **Polite by default.** Inter-request interval is enforced via a small
  on-disk state file; the default floor is one request every 0.25
  seconds. See
  [`rmorielite_fetch()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_fetch.md).

- **Cache by default.** Downloads land in the R session temporary
  directory ([`tempdir()`](https://rdrr.io/r/base/tempfile.html)); set
  `RMORIELITE_PERSISTENT_CACHE=1` to opt in to a persistent cache via
  [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html). Second
  fetches of the same URL are served from disk. See
  [`rmorielite_cache_dir()`](https://rootcoder007.github.io/rmorielite/reference/rmorielite_cache_dir.md).

- **Provenance by default.** SHA256 verification is available alongside
  every fetched file.

- **Focused re-export.** rmorielite imports the upstream `rmorie`
  toolkit and `rmoriebricklayer`, re-exporting their domain and
  provenance APIs, and adds its own small `httr2`-based polite,
  cache-aware fetch layer.

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
