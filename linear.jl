module LinearAlgebra

export tridiagonal_equation

TrigMatrix = Vector{Vector{Real}}

# Thomas algorithm for solving tridiagonal system of equations
# More about: https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm
function tridiagonal_equation(V::TrigMatrix,D::Vector{Real})::Vector{Real}
    A, B, C = V
    X = Vector{Real}(undef, size(D, 1))

    C[1] = C[1] / B[1]
    D[1] = D[1] / B[1]
    # Forward
    for i in 2:(size(D, 1))
        C[i] = C[i] / (B[i] - A[i] * C[i-1])
        D[i] = (D[i] - A[i] * D[i-1]) / (B[i] - A[i] * C[i-1])
    end
    # Backward
    X[size(D, 1)] = D[size(D, 1)]
    for i in (size(D, 1)-1):-1:1
        X[i] = D[i] - C[i] * X[i+1]
    end
    return X
end


end # LinearAlgebra