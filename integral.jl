#=
Using Gauss-Legendre quadrature
=#
module Gauss

export  gauss2,
        gauss3,
        gauss4

using ..SpaceDim:
        Space,
        get_bounds,
        get_interval

const GAUSS_2 = Dict(
    'x' => [-1/sqrt(3), 1/sqrt(3)],
    'w' => [1, 1]
)

const GAUSS_3 = Dict(
    'x' => [-1/sqrt(3), 0, 1/sqrt(3)],
    'w' => [5/9, 8/9, 5/9]
)

const GAUSS_4 = Dict(
    'x' => [-sqrt(3/7 + 2/7sqrt(6/5)), -sqrt(3/7 - 2/7sqrt(6/5)), sqrt(3/7 - 2/7sqrt(6/5)), sqrt(3/7 + 2/7sqrt(6/5))],
    'w' => [(18 - sqrt(30))/36, (18 + sqrt(30))/36, (18 + sqrt(30))/36, (18 - sqrt(30))/36]
)

gauss2(space::Space, f) = gaussian_quadrature(space, f, GAUSS_2)

gauss3(space::Space, f) = gaussian_quadrature(space, f, GAUSS_3)

gauss4(space::Space, f) = gaussian_quadrature(space, f, GAUSS_4) 

function gaussian_quadrature(space::Space, f, gauss_dict::Dict)::Real
    partial_sum = 0
    # Integrate each divider 
    for i in 1:space.dividers
        #∫(a,b) f(x)dx = (b-a)/2 ∫(-1, 1) f((b-a)/2 x + (a+b/2)) dx
        a, b = get_interval(space, i)
        ζ = (b-a)/2
        η = (a+b)/2
        partial_sum += ζ * sum([
            w * f(ζ * x + η)
            for (w, x) in zip(gauss_dict['w'], gauss_dict['x'])
        ])
    end
    return partial_sum
end

end #Gauss