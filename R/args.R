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
#' erratum::resolve(n)
#' erratum::resolve(m)
#'
#' cat(
#'   "n =",
#'   n,
#'   "name =",
#'   name,
#'   "\n"
#' )
cl.make <- function(args = commandArgs(trailingOnly = TRUE)) {
  accepted <- list()

  list(
    int = \(name, default, description) {
      accepted <<- add_arg(accepted, name, default, description, type = "int")
      parse_arg(args, default, name, as.integer)
    },
    str = \(name, default, description) {
      accepted <<- add_arg(accepted, name, default, description, type = "str")
      parse_arg(args, default, name, as.character)
    },
    bool = \(name, default, description) {
      accepted <<- add_arg(accepted, name, default, description, type = "bool")
      parse_arg(args, default, name, as.logical)
    },
    num = \(name, default, description) {
      accepted <<- add_arg(accepted, name, default, description, type = "num")
      parse_arg(args, default, name, as.numeric)
    },
    help = \() {
      cat("Usage:\n")
      for (arg in accepted) {
        cat(
          sprintf(
            "\t -%s %s\n\t\t%s\n",
            arg$name,
            arg$type,
            arg$description
          )
        )
      }
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

add_arg <- function(args, name, default, description, type) {
  arg <- list(
    name = name,
    default = default,
    description = description,
    type = type
  )

  args <- append(args, list(arg))
  args
}
