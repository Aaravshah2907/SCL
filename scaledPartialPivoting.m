function [U,c] = scaledPartialPivoting(A,b)

n = length(b);

% Scaling factors
s = max(abs(A), [], 2);

Aug = [A b];

for k = 1:n-1

    % Scaled ratios
    ratios = abs(Aug(k:n,k)) ./ s(k:n);
    [~, idx] = max(ratios);
    p = idx + k - 1;

    % Row swap
    if p ~= k
        Aug([k p], :) = Aug([p k], :);
        s([k p]) = s([p k]);
    end

    % Elimination
    for i = k+1:n
        m = Aug(i,k) / Aug(k,k);
        Aug(i,k:end) = Aug(i,k:end) - m*Aug(k,k:end);
    end
end

U = Aug(:,1:n);
c = Aug(:,n+1);

end
