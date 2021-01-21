module SpaceDim

export Space,
       space_range,
       space_interval,
       get_bounds,
       get_interval,
       get_test,
       get_test_prim

struct Space
    lower_bound::Real
    upper_bound::Real
    intervals::Int
end
    
space_range(space::Space)::Real = space.upper_bound - space.lower_bound
    
space_interval(space::Space)::Real = space_range(space) / space.intervals

function get_bounds(space::Space, i::Int)::Tuple{Real, Real, Real}
    lower_bound = space.lower_bound + (i - 1) * space_interval(space)
    middle_bound = space.lower_bound + i * space_interval(space)
    upper_bound = space.lower_bound + (i + 1) * space_interval(space)
    (lower_bound, middle_bound, upper_bound)
end

function get_interval(space::Space, i::Int)::Tuple{Real, Real}
    i > space.intervals && error("Index larger than divides")
    lower_bound = space.lower_bound + space_interval(space) * (i-1)
    upper_bound = lower_bound + space_interval(space)
    lower_bound = max(lower_bound, space.lower_bound)
    upper_bound = min(upper_bound, space.upper_bound)
    (lower_bound, upper_bound)
end

function eval_test(space::Space, x::Real, i::Int)::Real
    lower_bound, middle_bound, upper_bound = get_bounds(space, i)
    if x < space.lower_bound || x > space.upper_bound
        0
    elseif lower_bound <= x <= middle_bound
        (x - lower_bound) / space_interval(space)
    elseif middle_bound < x <= upper_bound
        (upper_bound - x) / space_interval(space)
    else
        0
    end
end

function eval_test_prim(space::Space, x::Real, i::Int)::Real
    lower_bound, middle_bound, upper_bound = get_bounds(space, i)
    if x < space.lower_bound || x > space.upper_bound
        0
    elseif lower_bound <= x < middle_bound
        1 / space_interval(space)
    elseif middle_bound <= x <= upper_bound
        -1 / space_interval(space)
    else
        0
    end
end

get_test(space::Space, i::Int) =  x -> eval_test(space, x, i)
get_test_prim(space::Space, i::Int) = x -> eval_test_prim(space, x, i)

end #SpaceDim