# Resolve the package cache directory

Returns the directory `rmorielite` uses for cached resources. By default
this is a sub-tree of the R **session temporary directory**
([`tempdir()`](https://rdrr.io/r/base/tempfile.html)) – files are
cleaned up automatically when R exits, in line with the CRAN policy that
packages must not write outside the session temp area without explicit
user consent.

## Usage

``` r
rmorielite_cache_dir(
  which = c("cache", "data", "config"),
  create = TRUE,
  persistent = NULL
)
```

## Arguments

- which:

  One of `"data"`, `"cache"`, `"config"`; matches the `which` argument
  of [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html).
  Defaults to `"cache"`.

- create:

  Logical. If `TRUE` (the default), create the directory recursively if
  it does not yet exist.

- persistent:

  Logical or `NULL`. If `NULL` (the default), reads the environment
  variable `RMORIELITE_PERSISTENT_CACHE`. If `TRUE`, uses
  [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html); if
  `FALSE`, uses [`tempdir()`](https://rdrr.io/r/base/tempfile.html).

## Value

A character scalar: the absolute path of the directory.

## Details

To opt in to a *persistent* cache that survives R sessions, set the
environment variable `RMORIELITE_PERSISTENT_CACHE=1` or pass
`persistent = TRUE`. The persistent location follows R's official
convention via
[`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html) – on macOS
that is `~/Library/Application Support/.../rmorielite`, on Windows
`%LOCALAPPDATA%\R\.../rmorielite`, and on Linux
`$XDG_DATA_HOME/R/rmorielite` (or `~/.local/share/R/rmorielite` if
`XDG_DATA_HOME` is unset).

## Examples

``` r
rmorielite_cache_dir()                  # default: session tempdir
#> [1] "/tmp/Rtmp5zbPOM/rmorielite/cache"
rmorielite_cache_dir(persistent = TRUE, create = FALSE) # opt in to R_user_dir
#> [1] "/home/runner/.cache/R/rmorielite"
```
