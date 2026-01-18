function result = myInverse(A)
    [m, n] = size(A);
    if m ~= n
        error('Matrix must be square.');
    end

    if m == 1
        result = 1 / A(1, 1);
        return;
    end

    result = A / eye(n);
end