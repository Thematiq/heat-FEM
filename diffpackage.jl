module DiffPackage

include("space_dim.jl")
include("integral.jl")
include("linear.jl")
include("fem.jl")

using .Gauss
using .SpaceDim
using .LinearAlgebra
using .FemSolver

export solve_matrix_fem,
       solve_thomas_fem

end #DiffPackage