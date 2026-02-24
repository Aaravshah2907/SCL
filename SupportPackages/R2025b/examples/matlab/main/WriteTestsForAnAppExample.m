%% Write Tests for an App
% This example shows how to write tests for an App Designer app in your
% current folder. To interact with the app programmatically and qualify
% the results, use the app testing framework and the unit testing
% framework.

% Copyright 2022 The MathWorks, Inc.

%%
% To explore the properties of the app prior to testing, create an instance
% of the app. This step is not necessary for the tests, but it is helpful
% to explore the properties used by the tests. For example, use
% |app.BloodPressureSwitch| to access the *Blood Pressure* switch within
% the app.
app = PatientsDisplay;
%%
% In a file named |PatientsDisplayTest.m| in your current folder, create a
% test class that derives from |matlab.uitest.TestCase|. To create an app
% for each test and delete it after the test, add a |TestMethodSetup|
% method to the class. Then, add four |Test| methods to the class:
%
% * |testTab| method &#8212; Test the tab-switching functionality. Choose
% the *Data* tab and then verify that the chosen tab has the expected
% title. 
% * |testPlottingOptions| method &#8212; Test various
% plotting options. First, press the *Histogram* radio button and verify
% that the _x_-axis label changes. Then, change the *Bin Width* slider and
% verify the number of bins.
% * |testBloodPressure| method &#8212; Test the blood
% pressure data and display. First, extract the blood pressure data from
% the app, and verify the _y_-axis label and the values of
% the scatter points. Then, switch to |Diastolic| readings, and verify
% the label and the displayed values again.
% * |testGender| method &#8212; Test the gender data
% and display. First, verify the number of scatter points for data about
% males. Then, include the data about females, and verify that two data
% sets are plotted and that the color of the scatter points for data about
% females is red. Finally, exclude the data about males, and test the
% number of plotted data sets and scatter points. 
%
% <include>PatientsDisplayTest.m</include>
%
%%
% Run the tests. In this example, three tests pass and one test fails.
results = runtests("PatientsDisplayTest");
%%