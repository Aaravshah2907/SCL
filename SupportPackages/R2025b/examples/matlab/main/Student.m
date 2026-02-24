classdef Student
    properties (SetAccess=immutable)
        Name
        Age
    end
    properties (Access=private)
        Field
    end
    methods
        function obj = Student(name,age,field)
            arguments
                name = "";
                age = [];
                field = "";
            end
            obj.Name = name;
            obj.Age = age;
            obj.Field = field;
        end
    end
end