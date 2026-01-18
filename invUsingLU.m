function X = invUsingLU(A, B)
    [n, m] = size(A);
    if n ~= m
        error('Matrix A must be square');
    end

    [L, U, P] = lu(A);

    y = L \ (P*B);   % Forward substitution
    X = U \ y;       % Back substitution
end
