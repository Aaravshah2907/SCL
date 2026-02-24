classdef PathFixtureTest < matlab.unittest.TestCase
    methods (Test)
        function testPath(testCase)
            import matlab.unittest.fixtures.PathFixture
            import matlab.unittest.constraints.ContainsSubstring
            f = testCase.applyFixture(PathFixture(["folderA" "folderB"]));
            testCase.verifyThat(path,ContainsSubstring(f.Folders(1)))
            testCase.verifyThat(path,ContainsSubstring(f.Folders(2)))
        end
    end
end