<!-- badges: start -->
<!-- badges: end -->

# cl.args

Parse command line arguments.

## Installation

``` r
# install.packages("pak")
pak::pak("devOpifex/cl.args")
```

## Example

``` r
library(cl.args)

cl <- cl.make()

n <- cl$int("n", 1, "An integer")
name <- cl$str("name", "Bob", "A name")

if ("-help" %in% commandArgs(trailingOnly = TRUE)) {
  cl$help()
  quit(0)
}

erratum::resolve(n)
erratum::resolve(m)
```

