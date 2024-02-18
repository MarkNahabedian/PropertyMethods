using PropertyMethods
using Documenter

DocMeta.setdocmeta!(PropertyMethods, :DocTestSetup, :(using PropertyMethods); recursive=true)

makedocs(;
    modules=[PropertyMethods],
    authors="MarkNahabedian <naha@mit.edu> and contributors",
    repo="https://github.com/MarkNahabedian/PropertyMethods.jl/blob/{commit}{path}#{line}",
    sitename="PropertyMethods.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MarkNahabedian.github.io/PropertyMethods.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MarkNahabedian/PropertyMethods.jl",
    devbranch="main",
)
