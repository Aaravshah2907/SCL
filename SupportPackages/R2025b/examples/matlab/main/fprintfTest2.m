classdef fprintfTest2 < matlab.perftest.TestCase
    methods(Test)
        function testPrintingToFile(testCase)
            file = tempname;
            
            testCase.startMeasuring();
            fid = fopen(file,'w');
            testCase.stopMeasuring();
            
            testCase.assertNotEqual(fid,-1,'IO Problem');
            stringToWrite = repmat('abcdef',1,1000000);
            
            testCase.startMeasuring();
            fprintf(fid,'%s',stringToWrite);
            testCase.stopMeasuring();
            
            testCase.verifyEqual(fileread(file),stringToWrite);
            
            testCase.startMeasuring();
            fclose(fid);
            testCase.stopMeasuring();
        end
    end
end