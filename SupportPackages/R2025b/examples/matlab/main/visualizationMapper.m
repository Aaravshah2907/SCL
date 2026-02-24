function visualizationMapper(data, ~, intermKVStore, edges)
%
% Count how many flights have arrival delays in each interval specified by
% the EDGES vector, and add these counts to INTERMKVSTORE.
% 

%   Copyright 2014-2020 The MathWorks, Inc.

counts = histc( data.ArrDelay, edges );

add( intermKVStore, 'Null', counts );
