classdef Counter < matlab.System
% COUNTER Compute an output value by incrementing the input value
  
  % All properties occur inside a properties declaration.
  % These properties have public access (the default)
  properties
    UseIncrement (1,1) logical = true    % Use custom increment value.
    UseWrapValue (1,1) logical = true    % Use max value.
    
    StartValue (1,1) {mustBeInteger,mustBePositive} = 1   % Value to start from.
    Increment (1,1) {mustBeInteger,mustBePositive} = 1    % What to add to Value every step.
    WrapValue (1,1) {mustBeInteger,mustBePositive} = 10   % Max value to wrap around.
  end

  properties(Access = protected)
      Value
  end

  methods
    % Constructor - Support name-value pair arguments when constructing object
    function obj = Counter(varargin)
        setProperties(obj,nargin,varargin{:})
    end

    function set.Increment(obj,val)
        if val >= 10
          error('The increment value must be less than 10');
        end
        obj.Increment = val;
    end
    
  end
  
  methods (Access = protected)
    % Validate the object properties  
    function validatePropertiesImpl(obj)
        if obj.UseIncrement && obj.UseWrapValue && ...
                (obj.WrapValue < obj.Increment)
          error('Wrap value must be greater than increment value');
        end
    end
    
    % Validate the inputs to the object
    function validateInputsImpl(~,x)
        if ~isnumeric(x)
          error('Input must be numeric');
        end
    end
    
    % Perform one-time calculations, such as computing constants
    function setupImpl(obj)
        obj.Value = obj.StartValue;
    end
  
    % Step
    function out = stepImpl(obj,in)
      if obj.UseIncrement
        % If using increment property, multiple the increment by the input.
        obj.Value = in*obj.Increment + obj.Value;
      else
         % If not using increment property, add the input.
        obj.Value = in + obj.Value;
      end
      if obj.UseWrapValue && obj.Value > obj.WrapValue
         % If UseWrapValue is true, wrap the value
         % if it is greater than the WrapValue.
         obj.Value = mod(obj.Value,obj.WrapValue);
      end
      out = obj.Value;
    end
  end
end