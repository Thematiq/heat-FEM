include("diffpackage.jl")

using .DiffPackage:
        Space,
        gauss2,
        gauss3,
        gauss4

function k(x::Real)::Real
    if 0 <= x <= 1
        1
    elseif 1 < x <= 2
        2
    else
        0
    end
end

test(x::Real)::Real = x^3 + 12x^2 + 23x

println("Please type number of intervals: ")
intervals = parse(Int,readline(stdin))
space = Space(0, 2, intervals)
gauss = gauss4

y = gauss(space, test)

print("y = '$y'")


