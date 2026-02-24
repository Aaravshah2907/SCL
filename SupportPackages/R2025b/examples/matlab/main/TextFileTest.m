classdef TextFileTest < matlab.unittest.TestCase
    methods (Test)
        function testWithTemporaryFolder(testCase)
            folder = testCase.createTemporaryFolder();
            file = fullfile(folder,"myFile.txt");
            fid = fopen(file,"w");
            testCase.addTeardown(@fclose,fid)
            testCase.assertNotEqual(fid,-1,"IO Problem")
            
            txt = repmat("ab",1,1000);
            dataToWrite = join(txt);
            fprintf(fid,"%s",dataToWrite);
            testCase.verifyEqual(string(fileread(file)),dataToWrite)
        end
    end
end