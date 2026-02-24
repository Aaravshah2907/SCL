%% Chart Class for Displaying Variable Size Tiling of Plots
% This example shows how to define a class for creating a tiling of 
% plots that can be any size, depending on the size of the user's data. The
% chart has a public |Data| property that accepts an m-by-n matrix. The 
% chart displays an n-by-n square tiling of scatter plots and histograms. The
% scatter plots show the different columns of the data plotted against each
% other. The histograms show the distribution of the values within each column 
% of the data.
% 
% The |update| method in this class recreates the histograms and scatter
% plots to reflect changes in the data. If the grid size of the layout 
% conflicts with the size of the data, then all the axes are deleted and the
% |GridSize| property is updated to match the size of the data. 
% Then a new set of axes objects is created.
%
% To define the class, copy the following code into the editor and save it
% with the name |TrellisChart.m| in a writable folder. 
%
% <include>TrellisChart.m</include>
%
%%
% After saving the class file, create an instance of the chart.

load patients
chartTitle = "Height, Weight, and Diastolic Blood Pressure";
c = TrellisChart('Data',[Height Weight Diastolic], ...
    'colNames', ["Height" "Weight" "Diastolic"],...
    'TitleText',chartTitle);
% Copyright 2019 The MathWorks, Inc.
