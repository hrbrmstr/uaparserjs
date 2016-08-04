context("basic functionality")
test_that("we can do something", {

  res <- ua_parse(paste0("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, ",
                         "like Gecko) Ubuntu/11.10 Chromium/15.0.874.106 ",
                         "Chrome/15.0.874.106 Safari/535.2", collapse=""))

  expect_that(res, is_a("data.frame"))
  expect_that(res$ua.patch, equals("874"))
  expect_that(res$os.family, equals("Ubuntu"))

})
