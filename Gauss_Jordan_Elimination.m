function X = Gauss_Jordan_Elimination(A, B)
     [n, m] = size(A);
    if n ~= m
        error('Matrix must be square');
    end

    % Augmented matrix [A | I]
    Aug = [A B];

    for i = 1:n
        % ---------- Partial pivoting ----------
        [~, k] = max(abs(Aug(i:n, i)));
        k = k + i - 1;
        Aug([i k], :) = Aug([k i], :);

        % ---------- Normalize pivot row ----------
        Aug(i, :) = Aug(i, :) / Aug(i, i);

        % ---------- Eliminate other rows ----------
        for j = 1:n
            if j ~= i
                Aug(j, :) = Aug(j, :) - Aug(j, i) * Aug(i, :);
            end
        end
    end

    % Extract inverse
    X = Aug(:, n+1:end);
end