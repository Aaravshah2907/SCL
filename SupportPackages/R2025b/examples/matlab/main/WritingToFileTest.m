classdef WritingToFileTest < matlab.unittest.TestCase
    properties
        Folder
    end

    methods (TestMethodSetup)
        function setup(testCase)
            testCase.Folder = testCase.createTemporaryFolder();
        end
    end

    methods (Test)
        function test1(testCase)
            file = fullfile(testCase.Folder,"myFile.txt");
            fid = fopen(file,"w");
            testCase.addTeardown(@fclose,fid)
            testCase.assertNotEqual(fid,-1,"IO Problem")
            txt = repmat("ab",1,1000);
            dataToWrite = join(txt);
            fprintf(fid,"%s",dataToWrite);
            testCase.verifyEqual(string(fileread(file)),dataToWrite)
        end

        function test2(testCase)
            file = fullfile(testCase.Folder,"myFile.txt");
            fid = fopen(file,"w");
            testCase.addTeardown(@fclose,fid)
            testCase.assertNotEqual(fid,-1,"IO Problem")
            txt = repmat("A B",1,1000);
            dataToWrite = join(txt);
            fprintf(fid,"%s",dataToWrite);
            testCase.verifyEqual(string(fileread(file)),dataToWrite)
        end
    end
end