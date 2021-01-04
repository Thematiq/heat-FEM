using DiffPackage

function η(space::Space, i::Int, x::Real)::Real
    lower_bound, middle_bound, upper_bound = get_bounds(space, i)
    if lower_bound < x <= middle_bound
        (x - lower_bound) / space_interval(space)
    elseif middle_bound < x < upper_bound
        (upper_bound - x) / space_interval(space)
    else
        0
    end
end

function Legendre(degree:)

function dη(space::Space, i::Int, x::Real)::Real
    lower_bound, middle_bound, upper_bound = get_bounds(space, i)
    if lower_bound < x <= middle_bound
        1
    elseif middle_bound < x < upper_bound
        -1
    else
        0
    end
end

function ∫(space::Space, f::function)::Real

end

composition(u::function, v::function)::function = \x -> u(x) * v(x)




N = ARGS[1]
filename = ARGS[2]

local_space = Space(0, 2, N)

matrix = [
    [∫(space, composition(η(space, u))) for u in 1:N]
for v in 1:N]