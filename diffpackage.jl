module DiffPackage


include("space_dim.jl")
include("integral.jl")

using .Gauss
using .SpaceDim


export Space,
       gauss2,
       gauss3,
       gauss4

end #DiffPackage