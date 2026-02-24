%% Change the Number of Inputs
% This example shows how to set the number of inputs for a
% System object&trade; with and without using |getNumInputsImpl|.
%
% If you have a variable number of inputs or outputs and you intend to use
% the System object in Simulink&reg;, you must include the
% |getNumInputsImpl| or |getNumOutputsImpl| method in your class
% definition.
%
% These examples show modifications for the number of inputs.  If you want
% to change the number of outputs, the same principles apply.
%
% As with all System object |Impl| methods, you always set the
% |getNumInputsImpl| and |getNumOutputsImpl| method's access to |protected|
% because they are internal methods that are never called directly.

% Copyright 2018 The MathWorks, Inc.


%% Allow up to Three Inputs
% This example shows how to write a System object that allows the number of
% inputs to vary.

%%
% Update the |stepImpl| method to accept up to three inputs by adding code to handle
% one, two, or three inputs. If you are only using this System object in MATLAB, |getNumInputsImpl| and
% |getNumOutputsImpl| are not required.
%%
% *Full Class Definition*
%
% <include>AddTogether.m</include>

%% 
% Run this System object with one, two, and three inputs.
addObj = AddTogether;
addObj(2)
%%
addObj(2,3)
%%
addObj(2,3,4)

%% Control the Number of Inputs and Outputs with a Property
% This example shows how to write a System object that allows changes to
% the number of inputs and outputs before running the object. Use this
% method when your System object will be included in Simulink:
%%
% 
% * Add a nontunable property |NumInputs| to control the number of inputs.
% * Implement the associated |getNumInputsImpl| method
% to specify the number of inputs.
% 
%%
% *Full Class Definition*
%
% <include>AddTogether2.m</include>

%% 
% Run this System object with one, two, and three inputs.
addObj = AddTogether2;
addObj.NumInputs = 1;
addObj(2)
%%
release(addObj);
addObj.NumInputs = 2;
addObj(2,3)
%%
release(addObj);
addObj.NumInputs = 3;
addObj(2,3,4)
