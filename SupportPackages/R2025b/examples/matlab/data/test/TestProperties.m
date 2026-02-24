classdef TestProperties < matlab.unittest.TestCase
    properties (ClassSetupParameter)
        classToTest = {'ClassA','ClassB','ClassC'};
    end

    properties (TestParameter)
        propertyToTest
    end
    
    properties
        ObjectToTest
    end

    methods (TestParameterDefinition,Static)
        function propertyToTest = initializeProperty(classToTest)
            propertyToTest = properties(classToTest);
        end
    end

    methods (TestClassSetup)
        function classSetup(testCase,classToTest)
            constructor = str2func(classToTest);
            testCase.ObjectToTest = constructor();
        end
    end

    methods (Test)
        function testProperty(testCase,propertyToTest)
            value = testCase.ObjectToTest.(propertyToTest);
            testCase.verifyNotEmpty(value)
        end
    end
end