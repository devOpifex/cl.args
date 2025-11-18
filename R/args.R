#' Make a command line argument parser
#'
#' @param args A vector of command line arguments
#'
#' @return A list of functions that parse arguments
#' @export
#'
#' @examples
#' cl <- cl.make()
#'
#' n <- cl$int("n", 1, "An integer")
#' name <- cl$str("name", "Bob", "A name")
#'
#' if (erratum::is.e(n)) {
#'   erratum::raise(n)
#' }
#'
#' if (erratum::is.e(name)) {
#'   erratum::raise(m)
#' }
#'
#' cat(
#'   "n =",
#'   n,
#'   "name =",
#'   name,
#'   "\n"
#' )
cl.make <- function(args = commandArgs(trailingOnly = TRUE)) {
  list(
    int = \(name, default, description) {
      parse_arg(args, default, name, as.integer)
    },
    str = \(name, default, description) {
      parse_arg(args, default, name, as.character)
    },
    bool = \(name, default, description) {
      parse_arg(args, default, name, as.logical)
    },
    num = \(name, default, description) {
      parse_arg(args, default, name, as.numeric)
    }
  ) |>
    invisible()
}

parse_arg <- function(args, default, name, converter) {
  name <- paste0("-", name)
  name_index <- which(name %in% args)

  if (length(name_index) == 0) {
    return(default)
  }

  value_index <- name_index + 1

  if (value_index > length(args)) {
    erratum::e("No value set for")
  }

  value <- args[value_index]
  converter(value)
}
