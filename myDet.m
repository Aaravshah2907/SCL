function d = myDet(A)
    [m, n] = size(A);
    if m ~= n
        error('Matrix must be square.');
    end
    
    % Base case: 1x1 matrix
    if m == 1
        d = A(1, 1);
        return;
    end
    
    d = 0;
    for j = 1:n
        % Calculate cofactor by creating the submatrix (minor)
        subA = A(2:m, [1:j-1, j+1:n]);
        
        % Add/subtract alternate terms
        if mod(j, 2) == 0
            signVal = -1;
        else
            signVal = 1;
        end
        
        d = d + signVal * A(1, j) * myDet(subA); % Recursive call
    end
end

% Inbuilt function : det(A)