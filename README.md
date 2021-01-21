# heat-FEM

FEM based differential equation solver.

---

## Usage

### Prerequisites

1. Install `Plots` package
``` julia
julia> using Pkg
julia> Pkg.add("Plots")
```

### Using solver

#### By jupyter notebook

Just run `drawer.ipynb`, there are example usages of the solver.

#### By console

1. Preparing the environment

```julia
julia> include("diffpackage.jl")
julia> using Plots
julia> using .DiffPackage
```

2. Solving using built-in Julia matrix solver

```julia
julia> X, Y = solve_matrix_fem(n) 
```

Where n is the number of intervals.

3. Solving using Thomas algorithm

```julia
julia> X, Y = solve_thomas_fem(n)
```

4. Plotting results

```julia
julia> display(plot(X, Y))
```