classdef RGBEventData < event.EventData
    properties
        PreviousRGB
        RGB
    end

    methods
        function eventData = RGBEventData(prevRGB,newRGB)
            eventData.PreviousRGB = prevRGB;
            eventData.RGB = newRGB;
        end
    end
end