%% Compare Structures That Contain Small and Large Values
% Combine tolerances so that when you compare values contained in
% structures, an absolute tolerance applies when the values are close to
% zero and a relative tolerance applies when they are much larger.

% Copyright 2021 The MathWorks, Inc.

%%
% First, import the classes used in this example.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
import matlab.unittest.constraints.AbsoluteTolerance
import matlab.unittest.constraints.RelativeTolerance
%%
% Create a test case for interactive testing.
testCase = TestCase.forInteractiveUse;
%% 
% Create two structures that contain the values of electromagnetic
% properties of a vacuum, expressed in SI units. The |approximate|
% structure holds approximations for the values contained in the
% |baseline| structure.
%%
baseline.LightSpeed = 299792458;
baseline.Permeability = 4*pi*10^-7;
baseline.Permittivity = 1/(baseline.Permeability*baseline.LightSpeed^2);

approximate.LightSpeed = 2.9979e+08;
approximate.Permeability = 1.2566e-06;
approximate.Permittivity = 8.8542e-12;
%%
% Test if the relative difference between the corresponding approximate
% and baseline values is within |eps*1.0000e+11|. Even though the 
% difference between the permeabilities is small, it is not small enough
% relative to the expected permeability to satisfy the relative tolerance.
%%
testCase.verifyThat(approximate,IsEqualTo(baseline, ...
    "Within",RelativeTolerance(eps*1.0000e+11)))
%%
% Test if the absolute difference between the corresponding approximate
% and baseline values is within |1.0000e-04|. Even though the difference
% between the light speeds is small relative to the expected light speed, 
% it is too large to satisfy the absolute tolerance.
%%
testCase.verifyThat(approximate,IsEqualTo(baseline, ...
    "Within",AbsoluteTolerance(1.0000e-04)))
%%
% Now, combine the tolerances to verify that the absolute difference 
% between the corresponding approximate and baseline values is within
% |1.0000e-04| or their relative difference is within |eps*1.0000e+11|. In
% this case, the permeabilities that are close to zero satisfy the
% absolute tolerance, and the light speeds that are much larger satisfy
% the relative tolerance.
%%
testCase.verifyThat(approximate,IsEqualTo(baseline, ...
    "Within",RelativeTolerance(eps*1.0000e+11) | ...
    AbsoluteTolerance(1.0000e-04)))