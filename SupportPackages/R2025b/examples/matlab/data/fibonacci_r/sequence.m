function s = sequence(n)
arguments
    n (1,1) {mustBeInteger,mustBePositive}
end
s = zeros(1,n);
for i = 1:n
    s(i) = fib(i);
end
end

function f = fib(n)
if n == 1
    f = 0;
elseif n == 2
    f = 1;
else
    f = fib(n-1) + fib(n-2);
end
end