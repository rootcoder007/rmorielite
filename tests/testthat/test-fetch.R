test_that("rmorielite_fetch validates arguments", {
  expect_error(rmorielite_fetch(NULL))
  expect_error(rmorielite_fetch("https://x", rate = -1))
  expect_error(rmorielite_fetch("https://x", max_tries = 0))
})

test_that("cached file is returned without a new request", {
  cache_root <- rmorielite_cache_dir(which = "cache", create = TRUE)
  dest <- file.path(cache_root, "preexisting.csv")
  writeLines("col1,col2\n1,2", dest)
  on.exit(unlink(dest), add = TRUE)

  out <- rmorielite_fetch(
    "https://example.org/preexisting.csv",
    dest_basename = "preexisting.csv"
  )
  expect_equal(normalizePath(out, winslash = "/"),
               normalizePath(dest, winslash = "/"))
})

test_that("force = TRUE re-downloads even when cache exists", {
  skip_if_not_installed("httr2")
  cache_root <- rmorielite_cache_dir(which = "cache", create = TRUE)
  dest <- file.path(cache_root, "force.csv")
  writeLines("stale", dest)
  on.exit(unlink(dest), add = TRUE)

  httr2::local_mocked_responses(list(
    httr2::response(body = charToRaw("fresh,content\n"))
  ))
  out <- rmorielite_fetch(
    "https://example.org/force.csv",
    dest_basename = "force.csv",
    force = TRUE
  )
  expect_true(file.exists(out))
})
