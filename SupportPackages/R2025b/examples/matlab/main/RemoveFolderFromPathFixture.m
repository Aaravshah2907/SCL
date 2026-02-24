classdef RemoveFolderFromPathFixture < matlab.unittest.fixtures.Fixture
    properties (SetAccess = immutable)
        Folder (1,1) string % Full path to the folder
    end
    methods
        function fixture = RemoveFolderFromPathFixture(folder)
            fixture.Folder = folder;
        end
        function setup(fixture)
            originalPath = path;
            fixture.addTeardown(@()path(originalPath));
            rmpath(fixture.Folder)
        end
    end
    methods (Access = protected)
        function tf = isCompatible(fixture1,fixture2)
            tf = fixture1.Folder == fixture2.Folder;
        end
        function tf = needsReset(fixture)
            foldersOnPath = split(path,pathsep);
            tf = ismember(fixture.Folder,foldersOnPath);
        end
    end
end