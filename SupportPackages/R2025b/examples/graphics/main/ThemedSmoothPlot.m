classdef ThemedSmoothPlot < matlab.graphics.chartcontainer.ChartContainer
    properties
        XData (1,:) double = NaN
        YData (1,:) double = NaN
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
            obj.OriginalLine = plot(ax,NaN,NaN);
            hold(ax,"on")
            obj.SmoothLine = plot(ax,NaN,NaN);
            hold(ax,"off")
        end
        function update(obj)
            % Update line data
            obj.OriginalLine.XData = obj.XData;
            obj.OriginalLine.YData = obj.YData;
            obj.SmoothLine.XData = obj.XData;
            obj.SmoothLine.YData = createSmoothData(obj);

            % Update line colors and smooth line width
            updateColor(obj);
            obj.SmoothLine.LineWidth = obj.SmoothWidth;
        end

        function sm = createSmoothData(obj)
            % Calculate smoothed data
            v = ones(1,10)*0.1;
            sm = conv(obj.YData,v,"same");
        end

        function updateColor(obj)
            OriginalLineColor = [0.6 0.7 1]; 
            SmoothLineColor = [0.3 0.4 0.7];
            thm = getTheme(obj);
            switch thm.BaseColorStyle
                case "light"
                    % Use OriginalLineColor and SmoothLineColor
                    obj.OriginalLine.Color = OriginalLineColor;
                    obj.SmoothLine.Color = SmoothLineColor;
                case "dark"
                    % Flip OriginalLineColor and SmoothLineColor
                    obj.OriginalLine.Color = fliplightness(OriginalLineColor);
                    obj.SmoothLine.Color = fliplightness(SmoothLineColor);
            end
        end
    end
end