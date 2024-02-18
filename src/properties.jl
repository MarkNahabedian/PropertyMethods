# Rather than use a conditional tree to determine which peoperty is
# being queried by `getproperty`, we can method specialize
# `getproperty` on Val types.
# We should then be able to automate `propertynames` and `hasproperty`
# based on the defined methods.

# A struct might have fields, which are exposed as properties.  The
# `Val` methods will not shadow the method that implements that.

export @njl_getprop


"""
    propertynames_from_val_methods(t::Type, private::Bool)

Compute and return the `propertynames` for type `t` from
its fields and `Val` specialized methods.
"""
function propertynames_from_val_methods(t::Type, private::Bool)
    props = collect(fieldnames(t))
    for m in methods(Base.getproperty, [t, Any]).ms
        if m.sig isa DataType
            if m.sig.parameters[2] == t
                p = m.sig.parameters[3]
                if p <: Val
                    push!(props, p.parameters[1])
                end
            end
        end
    end
    props
end

"""
    @njl_getprop MyStruct

Define the methods necessary so that `Val` specialized `getproperty`
methods for `MyStruct` will find `Val` specialized properties.
"""
macro njl_getprop(structname)
    quote
        Base.getproperty(o::$(esc(structname)), prop::Symbol) =
            Base.getproperty(o, Val(prop))
        Base.getproperty(o::$(esc(structname)), prop::Val{T}) where {T} =
            getfield(o, T)
        Base.propertynames(o::$(esc(structname)), private::Bool=false) =
            propertynames_from_val_methods(typeof(o), private)
        Base.hasproperty(o::$(esc(structname)), prop::Symbol) =
            prop in propertynames_from_val_methods(typeof(o), true)
    end
end

