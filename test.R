#!/usr/bin/Rscript
devtools::load_all()

cl <- cl.make()

n <- cl$int("n", 42, "An age")
name <- cl$str("name", "Bob", "A name")

if ("-help" %in% commandArgs(trailingOnly = TRUE)) {
  cl$help()
  quit(save = "no")
}

erratum::resolve(n)
erratum::resolve(name)

cat(sprintf("Hello %s, you are %d years old.\n", name, n))
