#!/usr/bin/Rscript
library(cl.args)

cl <- cl.make("Namer", "1.0.0")

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
