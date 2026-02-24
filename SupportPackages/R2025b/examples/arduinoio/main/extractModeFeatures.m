function [featmat,feature1,feature2,feature3] = extractModeFeatures(accx_mat,accy_mat,accz_mat)
    
    % Copyright 2024 The MathWorks, Inc.

    featmat = zeros(1,33);
    fs = 10.0;
  
    %% Mean
    feature1 = mean(accx_mat,1);    
    featmat(1) = feature1;
    
    %%
    feature2 = mean(accy_mat,1);    
    featmat(2) = feature2;
    
    %%
    feature3 = mean(accz_mat,1);    
    featmat(3) = feature3;
    
    %% Root Mean Square
    feature4 = rms(accx_mat,1);    
    featmat(4) = feature4;
    
    %%
    feature5 = rms(accy_mat,1);    
    featmat(5) = feature5;
    
    %%
    feature6 = rms(accz_mat,1);    
    featmat(6) = feature6;
    
    %%
    NFFT = 1024;
    spect = dsp.SpectrumEstimator('SpectralAverages',1,...
        'Window','Rectangular','FrequencyRange','onesided',...
        'SampleRate',fs,'SpectrumType','Power density',...
        'FFTLengthSource','Property','FFTLength',4096);
    f = (fs/NFFT)*(0:NFFT/2)';
    %% spectralPowerFeatures
    pf = zeros(1,9);
    af = step(spect,accx_mat);
    spf=spectralPowerFeatures(af, f);
    pf(1:9)=spf';
    featmat(7:15) = pf;
   
    %%
     pf = zeros(1,9);
    af = step(spect,accy_mat);
    spf=spectralPowerFeatures(af, f);
    pf(1:9)=spf';
    featmat(16:24) = pf;
    %%
    pf = zeros(1,9);
    af = step(spect,accz_mat);
    spf=spectralPowerFeatures(af, f);
    pf(1:9)=spf';
    featmat(25:33) = pf;
    
end

