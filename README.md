# PropertyMethods

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://MarkNahabedian.github.io/PropertyMethods.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://MarkNahabedian.github.io/PropertyMethods.jl/dev/)
[![Build Status](https://github.com/MarkNahabedian/PropertyMethods.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/MarkNahabedian/PropertyMethods.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/MarkNahabedian/PropertyMethods.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/MarkNahabedian/PropertyMethods.jl)

PropertyMethods is a small package that allows one to add computed
properties to a struct by defining a `Val` specialized method for each
property.  Unrelated properties no longer need to be enumerated in the
conditioonal tree of a single `getproperty` method.

Properties defined in this way will automatically be
recognized by the struct's `propertynames` and `hasproperty` methods.

This mackage also provide a macro to generate trampoline methods for
the *Delegation* pattern.

See the documentation linked above for details.
