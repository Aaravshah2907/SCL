%% Create Custom Tolerance
% Determine if two DNA sequences have a Hamming distance within a
% specified tolerance. For two DNA sequences of the same
% length, the Hamming distance is the number of positions in which the
% nucleotides (letters) of one sequence differ from the other.

% Copyright 2021 The MathWorks, Inc.

%% Create |DNA| Class
% To represent DNA sequences, create the |DNA| class in a file named
% |DNA.m| in your current folder.
% 
% <include>DNA.m</include>
%
%% Create |HammingDistance| Class
% In a file named |HammingDistance.m| in your current folder, create the
% |HammingDistance| class by subclassing 
% |matlab.unittest.constraints.Tolerance|. Add a property |Value| so that 
% you can specify the maximum allowable Hamming distance.
% 
% Classes that derive from the |Tolerance| class must implement the
% |supports|, |satisfiedBy|, and |getDiagnosticFor| methods:
%
% * |supports| method &#8212; Specify that the tolerance must support
% objects of the |DNA| class.
% * |satisfiedBy| method &#8212; Specify that for the actual and expected
% values to be within the tolerance, they must be the same size and their
% Hamming distance must be less than or equal to the tolerance value.
% * |getDiagosticFor| method &#8212; Create and return a |StringDiagnostic|
% object that contains diagnostic information about the comparison.
% 
% <include>HammingDistance.m</include>
%
%% Compare DNA Sequences
% To compare DNA sequences using a tolerance, first import the necessary
% classes and create a test case for interactive testing.
import matlab.unittest.TestCase
import matlab.unittest.constraints.IsEqualTo
testCase = TestCase.forInteractiveUse;
%%
% Create two |DNA| objects and compare them without specifying a tolerance.
% The test fails because the objects are not equal.
sampleA = DNA("ACCTGAGTA");
sampleB = DNA("ACCACAGTA");
testCase.verifyThat(sampleA,IsEqualTo(sampleB))
%%
% Verify that the DNA sequences are equal within a
% Hamming distance of |1|. The test fails and the testing framework
% displays additional diagnostic information produced by the
% |getDiagnosticFor| method.
testCase.verifyThat(sampleA,IsEqualTo(sampleB,"Within",HammingDistance(1)))
%%
% Verify that the DNA sequences are equal within a Hamming distance
% of |2|. The test passes.
testCase.verifyThat(sampleA,IsEqualTo(sampleB,"Within",HammingDistance(2)))