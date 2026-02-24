classdef TextStyle
    properties
        FontSize 
        FontColor
    end

    enumeration
        Body (12, [0 0 0])
        Heading1 (18, [0 0.4470 0.7410])
        Heading2 (16, [0.3010 0.7450 0.9330])
        Title (24, [0.6350 0.0780 0.1840])
    end

    methods
        function obj = TextStyle(size,color)
            obj.FontSize = size;
            obj.FontColor = color;
        end
    end
end