classdef HammingDistance < matlab.unittest.constraints.Tolerance
    properties
        Value
    end

    methods
        function tolerance = HammingDistance(value)
            tolerance.Value = value;
        end

        function tf = supports(~,expected)
            tf = isa(expected,"DNA");
        end

        function tf = satisfiedBy(tolerance,actual,expected)
            if ~isSameSize(actual.Sequence,expected.Sequence)
                tf = false;
                return
            end
            tf = hammingDistance(actual.Sequence,expected.Sequence) <= ...
                tolerance.Value;
        end

        function diagnostic = getDiagnosticFor(tolerance,actual,expected)
            import matlab.automation.diagnostics.StringDiagnostic
            if ~isSameSize(actual.Sequence,expected.Sequence)
                str = "The DNA sequences have different lengths.";
            else
                str = "The DNA sequences have a Hamming distance of " ...
                    + hammingDistance(actual.Sequence,expected.Sequence) ...
                    + "." + newline + "The allowable distance is " ...
                    + tolerance.Value + ".";
            end
            diagnostic = StringDiagnostic(str);
        end
    end
end

function tf = isSameSize(str1,str2)
tf = isequal(size(str1),size(str2));
end

function distance = hammingDistance(str1,str2)
distance = nnz(str1 ~= str2);
end