classdef TowerChart < matlab.graphics.chartcontainer.ChartContainer
    properties
        TowerData (:,:) table {mustHaveRequiredVariables} = table([],...
            [],[],'VariableNames',{'STRUCTYPE','Latitude','Longitude'})
    end
    
    properties (Access = private,Transient,NonCopyable)
        MapAxes matlab.graphics.axis.GeographicAxes
        HistogramAxes matlab.graphics.axis.Axes
        ScatterObject matlab.graphics.chart.primitive.Scatter
        HistogramObject matlab.graphics.chart.primitive.categorical.Histogram
    end
    
    methods (Access = protected)
        function setup(obj)
            % Configure layout and create axes
            tcl = getLayout(obj);
            tcl.GridSize = [1 2];
            obj.MapAxes = geoaxes(tcl);
            obj.HistogramAxes = axes(tcl);
            
            % Move histogram axes to second tile
            obj.HistogramAxes.Layout.Tile = 2;
            
            % Create Scatter and Histogram objects
            obj.ScatterObject = geoscatter(obj.MapAxes,NaN,NaN,'.');
            obj.HistogramObject = histogram(obj.HistogramAxes,categorical.empty,...
                'Orientation','horizontal');
            
            % Add titles to the axes
            title(obj.MapAxes,"Tower Locations")
            title(obj.HistogramAxes,"Tower Types")
            xlabel(obj.HistogramAxes,"Number of Towers")
        end
        
        function update(obj) 
            % Update Scatter object
            obj.ScatterObject.LatitudeData = obj.TowerData.Latitude;
            obj.ScatterObject.LongitudeData = obj.TowerData.Longitude;
            
            % Get tower types from STRUCTYPE table variable
            towertypes = obj.TowerData.STRUCTYPE;
            
            % Check for empty towertypes before updating histogram
            if ~isempty(towertypes)
                obj.HistogramObject.Data = towertypes;
                obj.HistogramObject.Categories = categories(towertypes);
            else
                obj.HistogramObject.Data = categorical.empty;
            end
        end
    end
end

function mustHaveRequiredVariables(tbl)
% Return error if table does not have required variables
assert(all(ismember({'STRUCTYPE','Latitude','Longitude'},...
    tbl.Properties.VariableNames)),...
    'MATLAB:TowerChart:InvalidTable',...
    'Table must have STRUCTYPE, Latitude, and Longitude variables.');
end
