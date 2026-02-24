classdef BookEntityResolver < matlab.io.xml.dom.EntityResolver
    
    properties
        BaseDir
    end
    
    methods
        
        function obj =  BookEntityResolver(baseDir)
            obj@matlab.io.xml.dom.EntityResolver()
            obj.BaseDir = baseDir;
        end
        
        function res = resolveEntity(obj,ri)
            import matlab.io.xml.dom.ResourceIdentifierType
            if getResourceIdentifierType(ri) == ResourceIdentifierType.ExternalEntity
                res = fullfile(obj.BaseDir, ri.SystemID);
            end
        end
    end
    
end