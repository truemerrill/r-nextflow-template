

# Documentation

All publicly exported R code is required to use `roxygen2` docstrings with 
Markdown extensions.  We highly recommend that you read and understand the R
packaging manual chapter on [documentation](https://r-pkgs.org/man.html)
before beginning work on your own R modules.

At a minimum, all docstrings must include a title, `@param` tags for each of
the input parameters, and a `@returns` tag for the return value.  You should
specify the datatypes for each of the input parameters and return values.  All
publicly exported code *must* include a `@export` tag in the docstring.

Here is a documentation example

```R

#' Create a closure which adds a constant to the input argument
#'
#' Given the argument `x`, this function returns a new function of the form
#' f(y) = x + y.
#'
#' @param x A constant number.
#' @returns A function that adds its argument to x.
#' @export
#' @examples
#' add_one <- create_adder(1)
#' add_ten <- create_adder(10)
create_adder <- function(x) {
  function(y) {
    x + y
  }
}

```

Our devops CI will automatically build the documentation for your package.
Please check that the documentation builds without errors before submitting
your code for review.  To manually build the documentation, execute the
following inside an R session:

```R
> devtools::document() 
```

You will see something like this:

```
ℹ Updating dockertemplate documentation
ℹ Loading dockertemplate
Writing NAMESPACE
Writing NAMESPACE
Writing hello.Rd
```

# Unit testing

All publicly exported R code is required to have a suite of `testthat` unit
tests.  Unit tests are an essential development practice and are used by our
devops CI to confirm that your package is working correctly in current and
future releases.  We highly recommend that you read and understand the R
packaging manual chapter on [testing](https://r-pkgs.org/testing-basics.html#introduction)
prior to beginning your work on your own R modules.

Your submission may be rejected by the maintainer if your test suite fails or
if they judge that you have insufficient test coverage.  Please consider the
following guidelines when building your unit test suite:

- All public functions must have a unit test
- Aim for at least 50% of your private functions to be tested
- Store test data (i.e. data that is used in your unit tests) inside 
  `tests/testthat/testdata`
- Whenever you expect your code to throw an error, test that the error is
  thrown with `expect_error()` or `expect_warning()` 

To manually run the test suite, execute the following inside an R session:

```R
> devtools::test()
```

You should see something like this:

```
ℹ Testing dockertemplate
✔ | F W S  OK | Context
✔ |         1 | hello
✔ |         5 | utils

══ Results ════════════════════════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 6 ]
```

# Code style and linting

All R code should conform to the [tidyverse](https://style.tidyverse.org/) code
style.  Having a consistent coding style is an essential development practice
that improves code readability and maintainability.

Your submission may be rejected by the maintainer if your code fails to conform
to the style guide.  To enforce consistency, our CI automatically runs a linter
against your submitted code.  You should run the linter yourself to check that
there are no linting errors before submitting the code for review.

To manually run the linter, execute the following inside an R session from the
package root directory:

```R
> library(lintr)
> lint_package()
```

You may find it easier to integrate the linter into your IDE such as RStudio or
VSCode.  Please consult your IDE's documentation on how to integrate `lintr`.

# Docker 

Build the docker image with the command

```
> docker build -t coe/<image-name>:<version> .
```

where `<image-name>` and `<version>` are the names of your image and version
number.  If you omit the version tag, docker will default to tagging the image
as `"latest"`.
