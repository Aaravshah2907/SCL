classdef ColorPickerComponentTest < matlab.uitest.TestCase

    methods (Test)
        function testEditField(testCase)
            % Setup
            callbackCalled = false;
            function testCallback(src,event)
                callbackCalled = true;
            end
            fig = uifigure;
            c = ColorPickerComponent(fig,ColorChangedFcn=@testCallback);
            testCase.addTeardown(@delete,fig)

            % Exercise
            testCase.type(c.RedField,0.7)

            % Verify
            testCase.verifyEqual(c.Button.BackgroundColor(1),0.7)
            testCase.verifyTrue(callbackCalled);
        end
    end

end