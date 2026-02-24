classdef ConfigurePlotAppExampleTest < matlab.uitest.TestCase
    methods (Test)
        function testSampleSize(testCase)
            app = ConfigurePlotAppExample;
            testCase.addTeardown(@delete,app)

            testCase.type(app.SampleSizeEditField,12)
            testCase.press(app.UpdatePlotButton)

            ax = app.UIAxes;
            surfaceObj = ax.Children;
            testCase.verifySize(surfaceObj.ZData,[12 12])
        end

        function testColormap(testCase)
            app = ConfigurePlotAppExample;
            testCase.addTeardown(@delete,app)

            testCase.choose(app.ColormapDropDown,"Winter")
            testCase.press(app.UpdatePlotButton)

            expectedMap = winter;
            ax = app.UIAxes;
            testCase.verifyEqual(ax.Colormap,expectedMap)
        end
    end
end