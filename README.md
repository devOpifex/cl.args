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
#!/usr/bin/Rscript
library(cl.args)

cl <- cl.make()

name <- cl$str("name", "Bob", "A name")
n <- cl$int(
  name = "n",
  default = 42, 
  description = "An age"
)

if ("-help" %in% commandArgs(trailingOnly = TRUE)) {
  cl$help()
  quit(0)
}

erratum::resolve(n)
erratum::resolve(m)

cat(sprintf("Hello %s, you are %d years old.\n", name, n))
```

Which you can then call like `./script.R`, `./script.R -n 10 -name "Alice"` or `./script.R -help`.

