#!/usr/bin/Rscript
devtools::load_all()

cl <- cl.make()

age <- cl$int("age", 42L, "An integer")
name <- cl$str("name", "Bob", "A name")

erratum::resolve(age)
erratum::resolve(name)

cl$help()

cat(
  sprintf(
    "You are %d years old and your name is %s\n",
    age,
    name
  )
)
