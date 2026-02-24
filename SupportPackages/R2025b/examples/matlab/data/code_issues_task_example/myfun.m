function myfun(numArrays)
arguments
    numArrays (1,1) {mustBeInteger,mustBePositive}
end
for n = 1:numArrays
    eval(['A',int2str(n),' = magic(n)'])
end
end