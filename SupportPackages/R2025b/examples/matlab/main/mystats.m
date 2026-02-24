x = [1 3 5 7 9 10 8 6 4 2 0 -2];

avg = mymean(x)

fh = localfunctions;
med = fh{2}(x) % equivalent to med = mymedian(x,n)

function a = mymean(v)
n = length(v);
a = sum(v)/n;
end

function m = mymedian(v)
n = length(v);
w = sort(v);
if rem(n,2) == 1
    m = w((n + 1)/2);
else
    m = (w(n/2) + w(n/2 + 1))/2;
end
end