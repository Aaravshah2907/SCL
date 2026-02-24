%% Labels in Different Units
% _Since R2022b_
%
% You can specify a function to format the labels when you need to calculate values.
% For example, you can define a function to calculate the label values in
% different units. 
%
% Define this function in a program file called |mylabelfun.m|. 
% The function converts the input from meters to feet and returns a string vector 
% containing each value in meters with the equivalent value in feet in
% parentheses. 
%
% <include>mylabelfun.m</include>
%

% Copyright 2022 The MathWorks, Inc.

%%
% Next, create a contour plot and specify the |LabelFormat| property as a handle to |mylabelfun|.
contour(peaks,[-4 0 2],"ShowText",true,"LabelFormat",@mylabelfun)
