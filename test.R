devtools::load_all()

cl <- cl.make()

n <- cl$int("n", 1, "An integer")
name <- cl$str("name", "Bob", "A name")

if ("-help" %in% commandArgs(trailingOnly = TRUE)) {
  cl$help()
  quit(save = "no")
}

erratum::resolve(n)
erratum::resolve(name)

cat(
  "n =",
  n,
  "name =",
  name,
  "\n"
)
