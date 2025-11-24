#' Make a command line argument parser
#'
#' @param name The name of the interface
#' @param version The version of the interface
#' @param args A vector of command line arguments
#'
#' @return A list of functions that parse arguments
#' @export
cl.make <- function(name, version, args = commandArgs()) {
  if (missing(name)) {
    stop("You must provide a name for the interface")
  }

  if (missing(version)) {
    stop("You must provide a version for the interface")
  }

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
      sprintf("-%s", name) %in% args
    },
    num = \(name, default, description) {
      accepted <<- add_arg(accepted, name, default, description, type = "num")
      parse_arg(args, default, name, as.numeric)
    },
    help = \(...) {
      if (!"-help" %in% args) {
        return(invisible())
      }

      cat(sprintf("Usage %s %s:\n", name, version))

      for (arg in accepted) {
        cat(
          sprintf(
            "\t -%s %s\n\t\t%s\n",
            arg$name,
            arg$type,
            arg$description
          ),
          ...
        )
      }

      quit("no")
    }
  ) |>
    invisible()
}

parse_arg <- function(args, default, name, converter) {
  name <- paste0("^-", name)
  name_index <- grep(name, args)

  if (!any(name_index)) {
    return(default)
  }

  if (grepl("=", args[name_index])) {
    split <- strsplit(args[name_index], "=")[[1]]
    return(converter(split[2]))
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
