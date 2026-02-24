classdef AddTogether2 < matlab.System
    % Add inputs together.  The number of inputs is controlled by the
    % nontunable property |NumInputs|.
    
    properties (Nontunable)
        NumInputs = 3;   % Default value
    end
    methods (Access = protected)
        function y = stepImpl(obj,x1,x2,x3)
            switch obj.NumInputs
                case 1
                    y = x1;
                case 2
                    y = x1 + x2;
                case 3
                    y = x1 + x2 + x3;
                otherwise
                    y = [];
            end  
        end
        function validatePropertiesImpl(obj)
            if ((obj.NumInputs < 1) ||...
                    (obj.NumInputs > 3))
                error("Only 1, 2, or 3 inputs allowed.");
            end
        end
        
        function numIn = getNumInputsImpl(obj)
            numIn = obj.NumInputs;
        end
    end
end
