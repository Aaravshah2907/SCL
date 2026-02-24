classdef IPAddressComponent < matlab.ui.componentcontainer.ComponentContainer
    % IPAddressComponent a set of 4 edit fields for IP Address input
    properties
        Value (1,4) {mustBeNonnegative, mustBeInteger, mustBeLessThanOrEqual(Value, 255)} = [192 168 1 2];
    end
    
    events (HasCallbackProperty, NotifyAccess = protected)
        ValueChanged % ValueChangedFcn callback property will be generated
    end

    
    properties (Access = private, Transient, NonCopyable)
        NumericField (1,4) matlab.ui.control.NumericEditField
        GridLayout matlab.ui.container.GridLayout
    end
    
    methods (Access=protected)
        function setup(obj)
            % Set the initial position of this component
            obj.Position = [100 100 150 22];
            
            % Layout
            obj.GridLayout = uigridlayout(obj,[1,4], ...
                'RowHeight',{22},'ColumnWidth',{'1x','1x','1x','1x'},...
                'Padding',0,'ColumnSpacing',2);
            
            % Building blocks
            for k = 1:4
                obj.NumericField(k) = uieditfield(obj.GridLayout, 'numeric',...
                    'Limits', [0 255], 'RoundFractionalValues', true, ...
                    'FontName', 'Courier New', 'FontWeight', 'bold', ...
                    'ValueChangedFcn',@(src,event) obj.handleNewValue());
            end
          
        end
        
        function update(obj)
            % Update view
            for k = 1:4
                obj.NumericField(k).Value = obj.Value(k);
            end
        end
    end
       
    methods (Access=private)
        function handleNewValue(obj)
            obj.Value = [obj.NumericField.Value];  
            
            % Execute the event listeners and the ValueChangedFcn callback property
            notify(obj,'ValueChanged');
        end
    end
end
