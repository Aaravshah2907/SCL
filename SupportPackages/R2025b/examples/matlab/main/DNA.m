classdef DNA
    properties (SetAccess=immutable)
        Sequence char {mustHaveValidLetters}
    end

    methods
        function dna = DNA(sequence)
            dna.Sequence = sequence;
        end
    end
end

function mustHaveValidLetters(sequence)
validLetters = ...
    sequence == 'A' | ...
    sequence == 'C' | ...
    sequence == 'T' | ...
    sequence == 'G';

if ~all(validLetters,"all")
    error("Sequence contains one or more invalid letters.")
end
end
