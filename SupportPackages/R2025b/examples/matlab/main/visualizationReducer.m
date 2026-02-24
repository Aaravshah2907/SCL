function visualizationReducer(~, intermValList, outKVStore)
% get all intermediate results from the intermediate store

%   Copyright 2014-2020 The MathWorks, Inc.


if hasnext(intermValList)
    outVal = getnext(intermValList);
else
    outVal = [];
end

while hasnext(intermValList)
    outVal = outVal + getnext(intermValList);
end
    
add(outKVStore, 'Null', outVal);
