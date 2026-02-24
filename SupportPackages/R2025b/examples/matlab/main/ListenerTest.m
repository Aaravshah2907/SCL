classdef ListenerTest < matlab.unittest.TestCase
    properties
        Source
        Listener
    end

    methods (TestMethodSetup)
        function setup(testCase)
            % Create the event source
            testCase.Source = MyHandle;
            % Add a listener to test execution of the callback code
            testCase.Listener = testCase.Source.addlistener( ...
                "SomethingHappened",@testCase.forbiddenCallback);
            % Remove the listener after the test
            testCase.addTeardown(@delete,testCase.Listener)
        end
    end

    methods (Test)
        function passingTest(testCase)
            % Disable the listener
            testCase.Listener.Enabled = false;
            testCase.Source.notify("SomethingHappened")   % Callback does not run
        end
        function failingTest(testCase)
            % The listener is enabled by default
            testCase.Source.notify("SomethingHappened")   % Callback runs
        end
    end

    methods
        function forbiddenCallback(testCase,~,~)
            % Test fails unconditionally
            testCase.verifyFail("This callback must not run!")
        end
    end
end