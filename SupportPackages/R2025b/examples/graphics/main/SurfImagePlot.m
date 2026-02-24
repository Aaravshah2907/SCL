classdef SurfImagePlot < matlab.graphics.chartcontainer.ChartContainer & ...
        matlab.graphics.chartcontainer.mixin.Colorbar
    
    properties
        ZData (:,:) double = []
        Offset (1,1) double = 10
        Colormap (:,3) double {mustBeGreaterThanOrEqual(Colormap,0),...
            mustBeLessThanOrEqual(Colormap,1)} = parula
    end
    properties(Access = private,Transient,NonCopyable)
        Surface (1,1) matlab.graphics.chart.primitive.Surface
        Image (1,1) matlab.graphics.primitive.Image
    end
    
    methods(Access = protected)
        function setup(obj)
            % Get the axes
            ax = getAxes(obj);
            
            % Create surface and image objects
            obj.Surface = surf(ax,[],[],[]);
            hold(ax,'on')
            obj.Image = imagesc(ax,[]);
            
            % Configure axes, make colorbar visible
            view(ax,3)
            axis(ax,'tight')
            grid(ax,'on')
            obj.ColorbarVisible = 'on';
            hold(ax,'off')
        end
        function update(obj)
            % Update Data and Colormap
            ax = getAxes(obj);
            [r,c] = size(obj.ZData);
            [X,Y] = meshgrid(1:c,1:r);
            obj.Surface.XData = X;
            obj.Surface.YData = Y;
            obj.Surface.ZData = obj.ZData + obj.Offset;
            obj.Image.CData = obj.ZData;
            colormap(ax,obj.Colormap)
        end
    end
end