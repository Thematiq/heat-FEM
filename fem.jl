module FemSolver

using ..SpaceDim:
    Space,
    get_test,
    get_test_prim

using ..Gauss:
    gauss2,
    gauss3,
    gauss4

using ..LinearAlgebra:
    tridiagonal_equation

export solve_matrix_fem,
       solve_thomas_fem

function k(x::Real)::Real
    if 0 <= x <= 1
        1
    elseif 1 < x <= 2
        2
    else
        0
    end
end

gauss = gauss4


function eval_L(space::Space, i::Int)::Real
    v = get_test(space, i)
    - 20 * v(0)
end

function eval_B(space::Space, x::Int, y::Int)::Real
    u  = get_test(space, x)
    uprim = get_test_prim(space, x)
    v  = get_test(space, y)
    vprim = get_test_prim(space, y)
    
    gauss(space, x -> k(x) * uprim(x) * vprim(x)) - u(0)*v(0)
end

function solve_matrix_fem(intervals::Int; deltaX::Real=0.01)
    space = Space(0, 2, intervals)

    B = [
        eval_B(space, y, x)
        for x=0:intervals-2, y=0:intervals-2
    ]
        
    Y = [
        eval_L(space, i)
        for i in 0:intervals-2
    ]
    
    X =  B \ Y

    ex = 0:deltaX:2
    ey = [
        sum(
            get_test(space, i)(x) * X[i+1]
            for i in 0:intervals-2
        )
        for x in ex 
    ]

    ex, ey
end

function solve_thomas_fem(intervals::Int; deltaX::Real=0.01)
    space = Space(0, 2, intervals)

    D = Vector{Real}(undef, intervals-1)
    A = Vector{Real}(undef, intervals-1)
    B = Vector{Real}(undef, intervals-1)
    C = Vector{Real}(undef, intervals-1)

    # Generate matrices
    B[1] = eval_B(space, 0, 0)
    C[1] = eval_B(space, 0, 1)
    D[1] = eval_L(space, 0)

    for i in 1:intervals-2
        A[i+1] = eval_B(space, i, i-1)
        B[i+1] = eval_B(space, i, i)
        C[i+1] = eval_B(space, i, i + 1)
        D[i+1] = eval_L(space, i)
    end
        
    A[intervals-2] = eval_B(space, intervals-1, intervals-1)
    B[intervals-2] = eval_B(space, intervals-1, intervals-1)
    D[intervals-2] = eval_L(space, intervals-1)

    X = tridiagonal_equation([A, B, C], D)

    ex = 0:deltaX:2
    ey = [
        sum(
            get_test(space, i)(x) * X[i+1]
            for i in 0:intervals-2
        )
        for x in ex 
    ]

    ex, ey
end

end #FemSolver