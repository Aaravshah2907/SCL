classdef LocalExtremaChart < matlab.graphics.chartcontainer.ChartContainer
    % c = LocalExtremaChart('XData',X,'YData',Y,Name,Value,...)
    % plots one line with markers at local extrema for every column of matrix Y. 
    % You can also specify the additonal name-value arguments, 'MarkerColor' 
    % and 'MarkerSize'.
    
    properties
        XData (1,:) double = NaN
        YData (:,:) double = NaN
        MarkerColor {validatecolor} = [1 0 0]
        MarkerSize (1,1) double = 5
    end
    properties(Access = private,Transient,NonCopyable)
        PlotLineArray (:,1) matlab.graphics.chart.primitive.Line
        ExtremaArray (:,1) matlab.graphics.chart.primitive.Line
    end
    
    methods(Access = protected)
        function setup(~)
        end
        function update(obj)
            % get the axes
            ax = getAxes(obj);
            
            % Plot Lines and the local extrema
            obj.PlotLineArray = plot(ax,obj.XData,obj.YData);
            hold(ax,'on')
            
            % Replicate x-coordinate vectors to match size of YData
            newx = repmat(obj.XData(:),1,size(obj.YData,2));
            
            % Find local minima and maxima and plot markers
            tfmin = islocalmin(obj.YData,1);
            tfmax = islocalmax(obj.YData,1);
            obj.ExtremaArray = plot(ax,newx(tfmin),obj.YData(tfmin),'o',...
                newx(tfmax),obj.YData(tfmax),'o',...
                'MarkerEdgeColor','none',...
                'MarkerFaceColor',obj.MarkerColor,...
                'MarkerSize',obj.MarkerSize);
            hold(ax,'off')
        end
    end
end