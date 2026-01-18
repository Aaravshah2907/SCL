function result = myTrace(A)
    
    % Check for Square Matrix
    [rows, cols] = size(A);
    if rows ~= cols
        error('Input matrix must be square.');
    end

    % Initialize the sum
    result = 0;

    % Loop through the diagonal elements and sum them
    for i = 1:rows
        result = result + A(i, i);
    end
end


% Inbuilt Function: trace(A)