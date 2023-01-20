# R Nextflow Template

[Nextflow](https://www.nextflow.io/) is a batch processing framework commonly
used in bioinformatics.  One important feature of Nextflow is the ability to 
execute individual steps of a pipeline in isolated containers.

This repository is an example of how to correctly package R code for execution
by a Nextflow workflow in an isolated Docker container.

_Features_:

* R code is organized into a valid [R package](https://r-pkgs.org/).
  Users are able to directly install this package into their local R
  environments using `devtools::install_github(https://github.com/foosa/r-nextflow-template)`.
* R code is documented using `roxygen2` and unit tested using `testthat`.
* R code uses the modern [tidyverse](https://www.tidyverse.org/) coding standards.
* Github actions are used to build R documentation, perform unit tests, calculate
  test coverage, build a docker image, and publish the docker image to 
  [ghcr.io](https://github.com/users/foosa/packages/container/package/r-nextflow-template).
* We show an example of how to package an Rscript and to symbolically link
  the script to the `PATH` inside the docker container.
* We provide an example Nextflow workflow and configuration file to show how to
  build a Nextflow pipeline which executes a process using the published docker
  container.

## How to run with Nextflow

The following assumes you are using a Unix environment using a `bash` shell with
[Docker](https://www.docker.com/) already installed.  To install Nextflow, run
the installation script

```sh
curl -s https://get.nextflow.io | bash
```

You probably want to either symbolically link the `nextflow` script to somewhere
in your path or modify your `PATH` environment variable to point to the directory
where you installed Nextflow.

Next, you can execute the included Nextflow workflow with

```sh
nextflow run .
```

This will print output like
```
N E X T F L O W  ~  version 22.10.5
Launching `./main.nf` [peaceful_hypatia] DSL2 - revision: dc54a23214
executor >  local (1)
[da/10ab72] process > sayHello [100%] 1 of 1 ✔
Ni! Ni! Ni!
Bring me a shrubbery!
One that looks nice ...
And not too expensive!
```

which you should recognize as the output from [`inst/bin/hello`](https://github.com/foosa/r-nextflow-template/blob/main/inst/bin/hello)
when the appropriate command line flags are given.  You might also recognize
[this guy](https://en.wikipedia.org/wiki/Knights_Who_Say_%22Ni!%22).

![](https://upload.wikimedia.org/wikipedia/en/thumb/e/eb/Knightni.jpg/300px-Knightni.jpg)

## How to write good R code

Good code should be:

* Correctly packaged
* Correctly documented
* Correctly unit tested
* Correctly formatted

### Correct R packaging

The free online [R packaging manual](https://r-pkgs.org/) provides the best
introduction to the R packaging system.  We highly recommend that you review
this book and the standards it introduces before beginning work on building
your own R package.

Or devops CI will automatically check whether your code follows the correct
packaging standards.  To check on your own machine prior to pushing to
github, execute the following inside an R session

```R
devtools::check()
```

### Correct R documentation

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
devtools::document() 
```

You will see something like this:

```
ℹ Updating NextflowTemplate documentation
ℹ Loading NextflowTemplate
Writing NAMESPACE
Writing NAMESPACE
Writing hello.Rd
```

### Correct unit testing

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
devtools::test()
```

You should see something like this:

```
ℹ Testing NextflowTemplate

Attaching package: ‘testthat’

The following object is masked from ‘package:devtools’:

    test_file

✔ | F W S  OK | Context
✔ |         1 | hello
✔ |         5 | utils

══ Results ════════════════════════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 6 ]
```

### Correct formatting and linting

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
devtools::lint()
```

You should see something like this:

```
ℹ Linting NextflowTemplate
.....
```

You should correct any linting errors that you see in your code.  You may find
it easier to integrate the linter into your IDE such as RStudio or VSCode.
Please consult your IDE's documentation on how to integrate linting.
