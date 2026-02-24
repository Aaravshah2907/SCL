classdef OptimLocalExtremaChart < matlab.graphics.chartcontainer.ChartContainer
    % c = OptimLocalExtremaChart('XData',X,'YData',Y,Name,Value,...)
    % plots one line with markers at local extrema for every column of matrix Y. 
    % You can also specify the additonal name-value arguments, 'MarkerColor' 
    % and 'MarkerSize'.
    
    properties
        XData (:,1) double = NaN
        YData (:,:) double = NaN
        MarkerColor {validatecolor} = [1 0 0]
        MarkerSize (1,1) double = 5
    end
    properties(Access = private,Transient,NonCopyable)
        PlotLineArray (:,1) matlab.graphics.chart.primitive.Line
        ExtremaLine (:,1) matlab.graphics.chart.primitive.Line
    end
    
    methods(Access = protected)
        function setup(obj)
            obj.ExtremaLine = matlab.graphics.chart.primitive.Line(...
                'Parent', obj.getAxes(), 'Marker', 'o', ...
                'MarkerEdgeColor', 'none', 'LineStyle',' none');
        end
        function update(obj)
            % Get the axes
            ax = getAxes(obj);
            
            % Create extra lines as needed
            p = obj.PlotLineArray;
            nPlotLinesNeeded = size(obj.YData, 2);
            nPlotLinesHave = numel(p);
            for n = nPlotLinesHave+1:nPlotLinesNeeded
                p(n) = matlab.graphics.chart.primitive.Line('Parent', ax, ...
                    'SeriesIndex', n, 'LineWidth', 2);
            end
            
            % Update the lines
            for n = 1:nPlotLinesNeeded
                p(n).XData = obj.XData;
                p(n).YData = obj.YData(:,n);
            end
            
            % Delete unneeded lines
            delete(p((nPlotLinesNeeded+1):numel(p)))
            obj.PlotLineArray = p(1:nPlotLinesNeeded);
            
            % Replicate x-coordinate vectors to match size of YData
            newx = repmat(obj.XData(:),1,size(obj.YData,2));
            
            % Find local minima and maxima and plot markers
            tfmin = islocalmin(obj.YData,1);
            tfmax = islocalmax(obj.YData,1);
            obj.ExtremaLine.XData = [newx(tfmin); newx(tfmax)];
            obj.ExtremaLine.YData = [obj.YData(tfmin); obj.YData(tfmax)];
            obj.ExtremaLine.MarkerFaceColor = obj.MarkerColor;
            obj.ExtremaLine.MarkerSize = obj.MarkerSize;
            
            % Make sure the extrema are on top
            uistack(obj.ExtremaLine, 'top');
        end
    end
end
