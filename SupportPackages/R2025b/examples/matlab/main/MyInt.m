classdef MyInt < int8
    methods
        function obj = MyInt(value)
            obj = obj@int8(value);
        end
    end
end