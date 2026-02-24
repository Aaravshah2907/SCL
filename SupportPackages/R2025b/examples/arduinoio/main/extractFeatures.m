function features  = extractFeatures(xbuffer, ybuffer, zbuffer)
% extractFeatures -  extract features from real-time accelerometer, 3 axes data 
% returns 1xk vector, where k is is the number of features (k = 60 for this
% example)

% Copyright 2023 The MathWorks, Inc.

% set sample time and frequency 
sample_time = 0.1;
frequency   = (1/sample_time); 

% pre-computed fmean and fstd values from training data
acceleration = [xbuffer ybuffer zbuffer];

%% Extract features
features = featuresFromBuffer(acceleration, frequency);

end

function feature = featuresFromBuffer(at, fs)
% featuresFromBuffer Extract vector of features from raw data buffer
%
% feat1-3 = mean (3 axis);
% feat4-6 = rms (3);
% feat7-15 = autocorrelation: height of main peak; height and position of second peak (3 feature *3 axis);
% feat16-51 = Spectral peak features: height and position of first 6 peaks% (12 feature * 3 axis);
% feat51-60 = Spectral power features: total power in 5 adjacent and pre-defined frequency bands (5 feature * 3 axis);

% Initialize digital filter
persistent dcblock spect f
if(isempty(dcblock))
    [s,g] = getFilterCoefficients();
    dcblock = dsp.SOSFilter('Structure','Direct form II transposed', ...
        'Numerator',s(:,1:3),'Denominator',s(:,4:6),'ScaleValues',g);

    NFFT = 4096;
    spect = dsp.SpectrumEstimator('SpectralAverages',1,...
        'Window','Rectangular','FrequencyRange','onesided',...
        'SampleRate',fs,'SpectrumType','Power density',...
        'FFTLengthSource','Property','FFTLength',4096);
    f = (fs/NFFT)*(0:NFFT/2)';
end

% Initialize feature vector
feature = zeros(1,60);

% Average value in signal buffer for all three acceleration components (1 each)
feature(1:3) = mean(at,1);

% Remove gravitational contributions with digital filter
ab = step(dcblock,at);

% RMS value in signal buffer for all three acceleration components (1 each)
feature(4:6) = rms(ab,1);

% Pre-compute spectra of 3 channels for frequency-domain features
af = step(spect,ab);

% Spectral peak features (12 per channel): value and freq of first 6 peaks
feature(16:51) = spectralPeaksFeatures(af, f);

% Spectral power features (5 each): total power in 5 adjacent
% and pre-defined frequency bands
feature(52:60) = spectralPowerFeatures(af, f);

% Autocorrelation features for all three acceleration components (3 each): 
% height of main peak; height and position of second peak
feature(7:15) = autocorrFeatures(ab, fs);
end

%% ===== HELPER FUNCTIONS =====
% Calculate autocorrelation features: feat7-15
% height of main peak; height and position of second peak
function feats = autocorrFeatures(x,fs)

feats = zeros(1,9);

% Apply xcorr and get the negative corelation values
c_all = xcorr(x);
c = c_all(32:end,1:3);
lags = (0:length(x)-1)';

minprom = 0.0005;
mindist_xunits = 0.3;
minpkdist = floor(mindist_xunits/(1/fs));

% Separate peak analysis for 3 different channels
for k = 1:3
    [pks,locs] = findpeaks([0;c(:,k)],...
        'minpeakprominence',minprom,...
        'minpeakdistance',minpkdist);

    tc = (1/fs)*lags;
    tcl = tc(locs-1);

    % Feature 1 - peak height at 0
    feats(3*(k-1)+1) = c(1,k);
    % Features 2 and 3 - position and height of first peak 
    if(length(tcl) >= 2)   % else f2,f3 already 0
        feats(3*(k-1)+2) = tcl(2);
        feats(3*(k-1)+3) = pks(2);
    end
end
end

% Calculate spectral peak features: feat16-51 
% height and position of first 6 peaks
function feats = spectralPeaksFeatures(xpsd, f)

feats = zeros(1,3*12);

mindist_xunits = 0.3;
minpkdist = floor(mindist_xunits/f(2));

% iterate through number of channels
nfinalpeaks = 6;
for k = 1:3
    [pks,locs] = findpeaks(xpsd(:,k),'npeaks',20,'minpeakdistance',minpkdist);
    opks = typecast(zeros(nfinalpeaks,1), 'single');
    olocs = zeros(nfinalpeaks,1); 
    if(~isempty(pks))
        mx = min(6,length(pks));
        [spks, idx] = sort(pks,'descend');
        slocs = locs(idx);

        pkssel = spks(1:mx);
        locssel = slocs(1:mx);

        [olocs, idx] = sort(locssel,'ascend');
        opks = pkssel(idx);
    end
    ofpk = f(olocs);

    % Features 1-6 positions of highest 6 peaks
    feats(12*(k-1)+(1:length(opks))) = ofpk;
    % Features 7-12 power levels of highest 6 peaks
    feats(12*(k-1)+(7:7+length(opks)-1)) = opks;
end
end

% Calculate spectral power features: feat51-60 
% total power in 5 adjacent and pre-defined frequency bands (5 feature * 3 axis);
function feats = spectralPowerFeatures(xpsd, f)

edges = [0.5, 5, 10, 20];
featstmp = zeros(3,3);
    
for kband = 1:length(edges)-1
    featstmp(kband,:) = sum(xpsd( (f>=edges(kband)) & (f<edges(kband+1)), : ),1);
end
feats = featstmp(:);
end

function [s,g] = getFilterCoefficients()
    coder.extrinsic('zp2sos')
    [z,p,k] = ellip(7,0.1,60,0.4/25,'high');
    [s,g] = coder.const(@zp2sos,z,p,k);
end