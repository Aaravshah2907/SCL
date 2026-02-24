classdef Match
    properties
        Name
        Timestamp
    end
    methods
        function m = Match(name)
            m.Name = name;
            m.Timestamp = datetime;
        end
        function hash = keyHash(m)
            hash = keyHash(m.Name);
        end
        function tf = keyMatch(m1,m2)
            tf = keyMatch(m1.Name,m2.Name);
        end
    end
end