# rmorielite

Polite retrieval of openly-published Canadian carceral and
police-oversight data.

[![License:
AGPL-3.0-or-later](https://img.shields.io/badge/license-AGPL--3.0--or--later-a42e2b.svg)](https://rootcoder007.github.io/rmorielite/LICENSE)

## Status

**v0.1 — under development.** A focused interface to carceral, policing,
and public-health open data — narrower than upstream
[`rmorie`](https://github.com/rootcoder007/rmorie): retrieval,
extraction, and the domain analysis API.

## Scope

| In scope (v0.1) | Out of scope (upstream `rmorie`) |
|----|----|
| Polite-by-default HTTPS fetcher (token-bucket throttle) | Causal estimators (ATE, ATT, AIPW) |
| Manifest-aware cache via [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html) | MRM framework |
| CKAN resource resolution by name pattern | Statistical physics, signal processing |
| OTIS A01RCDD restrictive-confinement ingestion | Cryptography, psychometrics |
| Federal SIU report ingestion | LLM helpers, spatial GP |
| SHA256 provenance verification | Survey calibration |

## Install

Not yet on CRAN.

``` r

# remotes::install_github("rootcoder007/rmorielite")
```

## Documentation

Function docs ship as standard `.Rd` files. After install, see
`?rmorielite-package` and
[`help(package = "rmorielite")`](https://rdrr.io/pkg/rmorielite/man).

## Licence

AGPL-3.0-or-later. Same as upstream `rmorie`.

## Author

Vansh Singh Ruhela — <vsruhela@proton.me> · ORCID
[0009-0004-1750-3592](https://orcid.org/0009-0004-1750-3592)
