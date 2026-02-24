function feats = spectralPowerFeatures(xpsd, f)
% SPECTRALPOWERFEATURES
%
% Copyright 2024 The MathWorks, Inc.
edges = [0.5, 5, 10, 20];
featstmp = zeros(3,3);
    
for kband = 1:length(edges)-1
    featstmp(kband,:) = sum(xpsd( (f>=edges(kband)) & (f<edges(kband+1)), : ),1);
end
feats = featstmp(:);
end