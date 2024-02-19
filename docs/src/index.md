```@meta
CurrentModule = PropertyMethods
```

# PropertyMethods

Suppose a type needs to define non-field properties.  This might be
because it needs to implement some of the properties of another type
to whose interface it must conform.  The *Delegation* pattern is an
example.  There could be other reasons why some properties need to be
computed rather than directly read.

Here is an example, though somewhat contrived:

```@example 1
using PropertyMethods

mutable struct Rectangle
    x
    y
    width
    height
end

mutable struct OffsetRectangle
    rect
    x_offset
    y_offset
end

Base.getproperty(r::OffsetRectangle, ::Val{:x}) =
    r.x_offset + r.rect.x

Base.getproperty(r::OffsetRectangle, ::Val{:y}) =
    r.y_offset + r.rect.y

Base.getproperty(r::OffsetRectangle, ::Val{:width}) =
    r.rect.width

Base.getproperty(r::OffsetRectangle, ::Val{:height}) =
    r.rect.height

@property_trampolines OffsetRectangle
```

The macro is necessary to define some additional methods:

```@example 1
using MacroTools

MacroTools.striplines(@macroexpand @property_trampolines OffsetRectangle)
```


```@example 1

rect1 = Rectangle(0, 1, 2, 4)

orect = OffsetRectangle(rect1, 2, 2)

for prop in propertynames(orect)
    println(prop, '\t', getproperty(orect, prop))
end
```

Some of the `getproperty` methods we defined just trampoline to the
value of the `OffsetRectangle`'s `rect` field.  This is just boilerplate.  We can do better:

```@example 1
MacroTools.striplines(@macroexpand @delegate Rectangle rect width height)
```

So, instead of explicitly coding the OffsetRectangle methods for the `width` and `height` fields, we can write

```@example 1
@delegate Rectangle rect width height
```

```@example 1
orect.width
```


## Index

```@index
```



## Definitions

```@autodocs
Modules = [PropertyMethods]
```
