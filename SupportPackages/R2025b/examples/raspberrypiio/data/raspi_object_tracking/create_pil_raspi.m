function create_pil_raspi(fcnName)
% CREATE_PIL_MEX Build a PIL MEX function. 
% 
% Customized for Raspberry Pi
% CREATE_PIL_MEX(fcnName) creates a PIL MEX function that runs the
% generated code on Raspberry Pi
%
% Example:
% create_pil_mex('fft')

% Copyright 2020 The MathWorks, Inc.
narginchk(1,1);

% targetHardware & deploy workfow for PIL
t   = targetHardware('Raspberry Pi');
cfg = coder.config('lib','ecoder',true);

% Create custom coder config for PIL 
cfg.Hardware               = coder.hardware('Raspberry Pi');
cfg.TargetLang             = 'C++';
cfg.VerificationMode       = 'PIL';
cfg.CodeExecutionProfiling = true;

dlcfg                      = coder.DeepLearningConfig('arm-compute');
dlcfg.ArmArchitecture      = 'armv7';
cfg.DeepLearningConfig     = dlcfg;

% Assign the dlcfg to coder config
t.CoderConfig              = cfg;

% Deploy the function
deploy(t,fcnName);
end