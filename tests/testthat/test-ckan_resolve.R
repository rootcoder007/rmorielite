test_that("rmorielite_ckan_resolve validates arguments", {
  expect_error(rmorielite_ckan_resolve(NULL, "x", "y"))
  expect_error(rmorielite_ckan_resolve("https://x", NULL, "y"))
  expect_error(rmorielite_ckan_resolve("https://x", "x", NULL))
  expect_error(rmorielite_ckan_resolve("https://x", "x", "y", timeout = -1))
})

test_that("matching resource is returned", {
  fixture <- list(
    success = TRUE,
    result  = list(resources = list(
      list(name = "Other File",
           url  = "https://example.org/other.csv",
           format = "CSV", id = "abc-1"),
      list(name = "Restrictive Confinement Detailed Dataset",
           url  = "https://example.org/rcdd.csv",
           format = "CSV", id = "abc-2")
    ))
  )
  httr2::local_mocked_responses(list(httr2::response_json(body = fixture)))
  res <- rmorielite_ckan_resolve(
    portal       = "https://data.ontario.ca",
    package_slug = "data-on-inmates-in-ontario",
    name_pattern = "Restrictive.?Confinement.*Detailed.?Dataset"
  )
  expect_type(res, "list")
  expect_equal(res$resource_id, "abc-2")
  expect_equal(res$url, "https://example.org/rcdd.csv")
  expect_equal(res$format, "CSV")
})

test_that("no match returns NULL", {
  fixture <- list(
    success = TRUE,
    result  = list(resources = list(
      list(name = "Unrelated", url = "", format = "CSV", id = "x")
    ))
  )
  httr2::local_mocked_responses(list(httr2::response_json(body = fixture)))
  res <- rmorielite_ckan_resolve(
    portal       = "https://data.example.org",
    package_slug = "anything",
    name_pattern = "no-such-pattern"
  )
  expect_null(res)
})

test_that("API failure returns NULL", {
  httr2::local_mocked_responses(list(
    httr2::response_json(body = list(success = FALSE))
  ))
  res <- rmorielite_ckan_resolve(
    portal       = "https://data.example.org",
    package_slug = "anything",
    name_pattern = ".*"
  )
  expect_null(res)
})
