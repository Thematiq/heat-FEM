module SpaceDim

export Space,
       space_range,
       space_interval,
       get_bounds,
       get_interval

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
    # Space limitation
    lower_bound = max(lower_bound, space.lower_bound)
    upper_bound = min(upper_bound, space.upper_bound)
    (lower_bound, middle_bound, upper_bound)
end

function get_interval(space::Space, i::Int)::Tuple{Real, Real}
    i > space.dividers && error("Index larger than divides")
    lower_bound = space.lower_bound + space_interval(space) * (i-1)
    upper_bound = lower_bound + space_interval(space)
    (lower_bound, upper_bound)
end

end #SpaceDim