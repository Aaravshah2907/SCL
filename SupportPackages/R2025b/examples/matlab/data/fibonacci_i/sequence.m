function s = sequence(n)
arguments
    n (1,1) {mustBeInteger,mustBePositive}
end
s = zeros(1,n);
for i = 1:n
    if i == 1
        s(i) = 0;
    elseif i == 2
        s(i) = 1;
    else
        s(i) = s(i-1) + s(i-2);
    end
end
end
