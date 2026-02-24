classdef BarErrorBarChart < matlab.graphics.chartcontainer.ChartContainer
    properties
        XData (1,:) double = NaN
        YData (1,:) double = NaN
        EData (1,:) double = NaN
        TitleText (:,:) char = ''
    end
    properties (Dependent)
        % Provide properties to support setting & getting
        XLimits (1,2) double
        XLimitsMode {mustBeMember(XLimitsMode,{'auto','manual'})}
        YLimits (1,2) double
        YLimitsMode {mustBeMember(YLimitsMode,{'auto','manual'})}
    end
    properties (Access = private)
        BarObject (1,1) matlab.graphics.chart.primitive.Bar
        ErrorBarObject (1,1) matlab.graphics.chart.primitive.ErrorBar
    end
    
    methods(Access = protected)
        function setup(obj)
            ax = getAxes(obj);
            obj.BarObject = bar(ax,NaN,NaN);
            hold(ax,'on')
            obj.ErrorBarObject = errorbar(ax,NaN,NaN,NaN);
            obj.ErrorBarObject.LineStyle = 'none';
            obj.ErrorBarObject.LineWidth = 2;
            obj.ErrorBarObject.Color = [0.6 0.7 1];
            hold(ax,'off');
        end
        function update(obj)
            % Update Bar and ErrorBar XData and YData
            obj.BarObject.XData = obj.XData;
            obj.BarObject.YData = obj.YData;
            obj.ErrorBarObject.XData = obj.XData;
            obj.ErrorBarObject.YData = obj.YData;
            
            % Update ErrorBar delta values
            obj.ErrorBarObject.YNegativeDelta = obj.EData;
            obj.ErrorBarObject.YPositiveDelta = obj.EData;
            
            % Update axes title
            ax = getAxes(obj);
            title(ax,obj.TitleText);
        end
    end
    
    methods
        % xlim method
        function varargout = xlim(obj,varargin)
            ax = getAxes(obj);
            [varargout{1:nargout}] = xlim(ax,varargin{:});
        end
        % ylim method
        function varargout = ylim(obj,varargin)
            ax = getAxes(obj);
            [varargout{1:nargout}] = ylim(ax,varargin{:});
        end
        % title method
        function title(obj,txt)
            obj.TitleText = txt;
        end
        
        % set and get methods for XLimits and XLimitsMode
        function set.XLimits(obj,xlm)
            ax = getAxes(obj);
            ax.XLim = xlm;
        end
        function xlm = get.XLimits(obj)
            ax = getAxes(obj);
            xlm = ax.XLim;
        end
        function set.XLimitsMode(obj,xlmmode)
            ax = getAxes(obj);
            ax.XLimMode = xlmmode;
        end
        function xlm = get.XLimitsMode(obj)
            ax = getAxes(obj);
            xlm = ax.XLimMode;
        end
        
        % set and get methods for YLimits and YLimitsMode
        function set.YLimits(obj,ylm)
            ax = getAxes(obj);
            ax.YLim = ylm;
        end
        function ylm = get.YLimits(obj)
            ax = getAxes(obj);
            ylm = ax.YLim;
        end
        function set.YLimitsMode(obj,ylmmode)
            ax = getAxes(obj);
            ax.YLimMode = ylmmode;
        end
        function ylm = get.YLimitsMode(obj)
            ax = getAxes(obj);
            ylm = ax.YLimMode;
        end
    end
end