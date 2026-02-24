classdef TrellisChart < matlab.graphics.chartcontainer.ChartContainer
   
    properties
        Data(:,:) {mustBeNumeric}
        ColNames(1,:) string 
        TitleText(1,:) string
    end
    
    methods (Access = protected)
        function setup(obj)
            % Use one toolbar for all of the axes
            axtoolbar(getLayout(obj),'default');
        end
        
        function update(obj)
            % Get the layout and store it as tcl
            tcl = getLayout(obj);
            numvars = size(obj.Data,2);
             
            % Reconfigure layout if needed
            if numvars ~= tcl.GridSize(1)
                % Delete layout contents to change the grid size
                delete(tcl.Children);
                if numvars>0
                    tcl.GridSize = [numvars numvars];
                    for i = 1:numvars^2
                        nexttile(tcl,i);
                    end
                end
            end
            
            % Populate the layout with the axes
            ax = gobjects(numvars,numvars);
            for col = 1:numvars
                for row = 1:numvars
                    % Get the axes at the current row/column
                    t = col + (row-1) * numvars;
                    ax(row,col)=nexttile(tcl,t);
                    if col==row
                        % On the diagonal, draw histograms
                        histogram(ax(row,col),obj.Data(:,col));
                        ylabel(ax(row,col),'Count')
                    else
                        % Off the diagonal, draw scatters
                        scatter(ax(row,col),obj.Data(:,col),...
                            obj.Data(:,row),'filled','MarkerFaceAlpha',0.6)
                        if length(obj.ColNames) >= row
                            ylabel(ax(row,col),obj.ColNames(row));
                        end
                    end
                    
                    if length(obj.ColNames) >= col
                        xlabel(ax(row,col),obj.ColNames(col));
                    end
                end
                
                % Link the x-axis for each column, so that panning or zooming
                % affects all axes in the column.
                linkaxes(ax(:,col),'x')
            end
            
            % Chart title
            title(tcl,obj.TitleText,'FontSize',16);
        end
    end
end