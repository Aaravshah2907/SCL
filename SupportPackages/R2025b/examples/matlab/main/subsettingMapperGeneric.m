function subsettingMapperGeneric(data, ~, intermKVStore, subsetter)
%

%   Copyright 2014-2020 The MathWorks, Inc.

intermKey = 'Null';

intermVal = data(subsetter(data), :);

add(intermKVStore,intermKey,intermVal);
