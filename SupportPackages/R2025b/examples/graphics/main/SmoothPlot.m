classdef SmoothPlot < matlab.graphics.chartcontainer.ChartContainer
    properties
        XData (1,:) double = NaN
        YData (1,:) double = NaN
        SmoothColor (1,3) double {mustBeGreaterThanOrEqual(SmoothColor,0),...
            mustBeLessThanOrEqual(SmoothColor,1)} = [0.9290 0.6940 0.1250]
        SmoothWidth (1,1) double = 2
    end
    properties(Access = private,Transient,NonCopyable)
        OriginalLine (1,1) matlab.graphics.chart.primitive.Line
        SmoothLine (1,1) matlab.graphics.chart.primitive.Line
    end
    
    methods(Access = protected)
        function setup(obj)
            % Create the axes
            ax = getAxes(obj);
            
            % Create the original and smooth lines
            obj.OriginalLine = plot(ax,NaN,NaN,'LineStyle',':');
            hold(ax,'on')
            obj.SmoothLine = plot(ax,NaN,NaN);
            hold(ax,'off')
        end
        function update(obj)
            % Update line data
            obj.OriginalLine.XData = obj.XData;
            obj.OriginalLine.YData = obj.YData;
            obj.SmoothLine.XData = obj.XData;
            obj.SmoothLine.YData = createSmoothData(obj);
            
            % Update line color and width
            obj.SmoothLine.Color = obj.SmoothColor;
            obj.SmoothLine.LineWidth = obj.SmoothWidth;
        end
        function sm = createSmoothData(obj)
            % Calculate smoothed data
            v = ones(1,10)*0.1;
            sm = conv(obj.YData,v,'same');
        end
    end
end