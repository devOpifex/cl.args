devtools::load_all()

cl <- cl.make()

n <- cl$int("n", 1, "An integer")
name <- cl$str("name", "Bob", "A name")

if (erratum::is.e(n)) {
  erratum::raise(n)
}

if (erratum::is.e(name)) {
  erratum::raise(m)
}

cat(
  "n =",
  n,
  "name =",
  name,
  "\n"
)
