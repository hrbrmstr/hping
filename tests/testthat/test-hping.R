context("basic functionality")
test_that("uptime extraction works", {

  df <- extract_uptime(system.file("extdata",
                                   "sample.hping3.output.txt.gz",
                                   package="hping"))

  expect_that(df, is_a("tbl_df"))
  expect_that(dim(df), equals(c(33, 5)))

})
