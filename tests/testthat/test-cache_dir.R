test_that("rmorielite_cache_dir defaults to tempdir (CRAN policy)", {
  path <- rmorielite_cache_dir(create = TRUE)
  expect_type(path, "character")
  expect_length(path, 1L)
  expect_true(nzchar(path))
  expect_true(dir.exists(path))
  expect_true(startsWith(path, normalizePath(tempdir(), winslash = "/")))
})

test_that("persistent = TRUE returns tools::R_user_dir path", {
  expected <- normalizePath(tools::R_user_dir("rmorielite", which = "cache"),
                            mustWork = FALSE, winslash = "/")
  actual <- rmorielite_cache_dir(persistent = TRUE, create = FALSE)
  expect_equal(actual, expected)
})

test_that("RMORIELITE_PERSISTENT_CACHE env var opts in", {
  prev <- Sys.getenv("RMORIELITE_PERSISTENT_CACHE", NA_character_)
  on.exit(
    if (is.na(prev)) Sys.unsetenv("RMORIELITE_PERSISTENT_CACHE")
    else Sys.setenv(RMORIELITE_PERSISTENT_CACHE = prev),
    add = TRUE
  )
  Sys.setenv(RMORIELITE_PERSISTENT_CACHE = "TRUE")
  expected <- normalizePath(tools::R_user_dir("rmorielite", which = "cache"),
                            mustWork = FALSE, winslash = "/")
  actual <- rmorielite_cache_dir(create = FALSE)
  expect_equal(actual, expected)
})

test_that("which argument is validated", {
  expect_error(rmorielite_cache_dir(which = "bogus"))
})

test_that("data, cache, config resolve to distinct directories", {
  d <- rmorielite_cache_dir("data",   create = FALSE)
  c <- rmorielite_cache_dir("cache",  create = FALSE)
  k <- rmorielite_cache_dir("config", create = FALSE)
  expect_false(identical(d, c))
  expect_false(identical(d, k))
  expect_false(identical(c, k))
})
