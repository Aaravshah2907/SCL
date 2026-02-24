classdef Employee
    properties (SetAccess=immutable)
        Name
    end
    properties (Access=private)
        Location
    end
    methods
        function obj = Employee(name,location)
            arguments
                name = "";
                location = "";
            end
            obj.Name = name;
            obj.Location = location;
        end
    end
end