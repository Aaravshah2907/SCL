classdef AddOne < matlab.System
% ADDONE Compute an output value that increments the input by one

    methods (Access = protected)
       % Implement algorithm. Calculate y as a function of input x.
       function y = stepImpl(~,x)
          y = x + 1;
       end    
    end
end