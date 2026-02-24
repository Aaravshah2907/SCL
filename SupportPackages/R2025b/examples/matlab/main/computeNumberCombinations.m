function c = computeNumberCombinations(n,k)
% Calculate number of combinations of n items taken k at a time
c = fact(n)/(fact(n-k)*fact(k));
end

function f = fact(n)
f = 1;
for m = 2:n
    f = f*m;   
end
end