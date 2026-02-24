%% Optimized Chart Class for Displaying Variable Number of Lines
% This example shows how to optimize a chart class for displaying
% a variable number of lines. It reuses existing line objects, which 
% can improve the performance of the chart, especially if the number of 
% lines does not change frequently. For a simpler version of this chart 
% without the optimization, see <docid:creating_plots#mw_77a882bd-9d86-4e6b-8dfa-f094eae12783>.
%
% The chart displays
% as many lines as there are columns in the |YData| matrix, with circular markers
% at the local extrema. The following code demonstrates how to:
%
% * Define two properties called |PlotLineArray| and |ExtremaLine| that store
% the objects for the lines and the markers, respectively.
% * Implement a |setup| method that initializes the |ExtremaLine| object. 
% * Implement an |update| method that gets the size of the |PlotLineArray|, and
% then adds or subtracts objects from that array according to the number of 
% columns in |YData|. 
%
% To define the class, copy this code into the editor and save it 
% with the name |OptimLocalExtremaChart.m| in a writable folder.
%
% <include>OptimLocalExtremaChart.m</include>
%
%%
% After saving the class file, you can create an instance of the chart.
% For example: 

x = linspace(0,2)';
y = cos(5*x)./(1+x.^2);
c = OptimLocalExtremaChart('XData',x,'YData',y);

%%
% Now, create a |for| loop that adds an additional line to the plot at every
% iteration. The chart object keeps all the existing lines, and adds
% one additonal line for each |i|. 

for i=1:10
    y = cos(5*x+i)./(1+x.^2);
    c.YData = [c.YData y];
end
% Copyright 2020 The MathWorks, Inc.

