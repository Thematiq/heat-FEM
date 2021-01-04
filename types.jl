Polynomial = Vector{Float, 1}

struct Space
    lower_bound::Real
    upper_bound::Real
    dividers::Int
end

space_range(space::Space)::Real = space.upper_bound - space.lower_bound

space_interval(space::Space)::Real = space_range(space) / space.dividers 

function get_bounds(space::Space, i::Int)::Tuple{Real, Real, Real}
    i > space.dividers && error("Index larger than divides")
    lower_bound = space.lower_bound + ((i - 1) / space.dividers) * space_range(space)
    middle_bound = space.lower_bound + (i / space.dividers) * space_range(space)
    upper_bound = space.lower_bound + ((i + 1) / space.dividers) * space_range(space)
    (lower_bound, middle_bound, upper_bound)
end