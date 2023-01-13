

test_that("add_one adds one to the argument", {
  expect_equal(add_one(0), 1)
  expect_equal(add_one(10), 11)
  expect_equal(add_one(-6), -5)
  expect_equal(add_one(232), 233)
  expect_equal(add_one(1e6), 1e6 + 1)
})
