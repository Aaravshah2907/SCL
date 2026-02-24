classdef MyParseErrorHandler < matlab.io.xml.dom.ParseErrorHandler

    properties
        Errors  % Object to store error list
    end
    methods
        function cont = handleError(obj,error)
            
            import matlab.io.xml.dom.*
            
            % Create index for individual errors 
            idx = numel(obj.Errors) + 1;
            
            severity = getSeverity(error);
            
            % Assign severity and messages of the errors
            obj.Errors(idx).Severity = severity;
            obj.Errors(idx).Message = error.Message;
            
            % Find location of the error
            loc = getLocation(error);

            obj.Errors(idx).Location.FilePath = loc.FilePath;
            obj.Errors(idx).Location.LineNo = loc.LineNumber;
            obj.Errors(idx).Location.ColNo = loc.ColumnNumber;

            % Set the condition for the method output and to halt parsing
            if severity == "fatalError"
                cont = false; % Halt parsing
            else
                cont = true; % Continue parsing
            end
        end
    end
end