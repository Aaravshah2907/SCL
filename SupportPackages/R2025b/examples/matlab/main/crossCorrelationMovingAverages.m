classdef crossCorrelationMovingAverages < matlab.System
    % Find the cross-correlation between two moving averages.
    
    % Public, tunable properties
    properties(Nontunable,Dependent)
        % WindowLength Moving window length
        WindowLength1;
        WindowLength2;
    end
    
    properties (Access=private)
        % This example class contains two moving average filters (more can be added
        % in the same way)
        MovingAverageFilter1
        MovingAverageFilter2
    end
    
    methods
        function obj = crossCorrelationMovingAverages(varargin)
            % Support name-value pair arguments when constructing object
            setProperties(obj,nargin,varargin{:})
        end
        
        % This example class has properties that are all dependent on the
        % corresponding properties of the two contained moving average filters.
        % Setting/getting these dependent properties means
        % setting/getting the corresponding properties in the contained
        % filters.
        function set.WindowLength1(obj,WindowLength1)
            % Set the window length of one moving average filter
            obj.MovingAverageFilter1.WindowLength = WindowLength1;
        end
        function WindowLength = get.WindowLength1(obj)
            % Read window length from one of the moving average filters
            WindowLength = obj.MovingAverageFilter1.WindowLength;
        end
        function set.WindowLength2(obj,WindowLength2)
            % Set the window length of one moving average filter
            obj.MovingAverageFilter2.WindowLength = WindowLength2;
        end
        function WindowLength = get.WindowLength2(obj)
            % Read window length from one of the moving average filters
            WindowLength = obj.MovingAverageFilter2.WindowLength;
        end
    end
    methods(Access = protected)
        function setupImpl(obj,~)
            % Set up moving average objects with default values
            obj.MovingAverageFilter1 = movingAverageFilter(...
                'WindowLength',obj.WindowLength1);
            obj.MovingAverageFilter2 = movingAverageFilter(...
                'WindowLength',obj.WindowLength2);
        end
        
        function [c,lags] = stepImpl(obj,u,v)
            % Implement algorithm. Calculate y as a function of input u, v, and
            % states.
            yMovingAverage1 = step(obj.MovingAverageFilter1, u);
            yMovingAverage2 = step(obj.MovingAverageFilter2, v);
            [c,lags] = xcov(yMovingAverage1,yMovingAverage2);
        end
        
        function resetImpl(obj)
            % Reset contained moving average filters
            reset(obj.MovingAverageFilter1);
            reset(obj.MovingAverageFilter2);
        end
        
        function releaseImpl(obj)
            % Release the contained filters
            release(obj.MovingAverageFilter1);
            release(obj.MovingAverageFilter2);
        end
        function s = saveObjectImpl(obj)
            % Default implementaion saves all public properties
            s = saveObjectImpl@matlab.System(obj);
            % Save the contained filters
            s.MovingAverageFilter1 = matlab.System.saveObject(obj.MovingAverageFilter1);
            s.MovingAverageFilter2 = matlab.System.saveObject(obj.MovingAverageFilter2);
        end
        
        function s = loadObjectImpl(obj, s, wasLocked)
            % Re-load contained filters
            obj.MovingAverageFilter1 = matlab.System.loadObject(s.MovingAverageFilter1);
            obj.MovingAverageFilter2 = matlab.System.loadObject(s.MovingAverageFilter2);
            % Call default implementation
            loadObjectImpl@matlab.System(obj,s,wasLocked);
        end
        
    end
end
