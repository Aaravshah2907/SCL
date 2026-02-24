classdef (SharedTestFixtures = { ...
        RemoveFolderFromPathFixture(fullfile(pwd,'helperFiles'))}) ...
        SampleTestB < matlab.unittest.TestCase
    methods (Test)
        function test1(testCase)
            import matlab.unittest.constraints.ContainsSubstring
            f = testCase.getSharedTestFixtures;
            addpath('helperFiles')
            testCase.assertThat(path,ContainsSubstring(f.Folder))
        end
    end
end