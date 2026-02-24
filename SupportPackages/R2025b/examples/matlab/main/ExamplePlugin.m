classdef ExamplePlugin < matlab.unittest.plugins.TestRunnerPlugin
    properties (SetAccess=immutable)
        Output
    end

    methods
        function plugin = ExamplePlugin(stream)
            arguments
                stream (1,1) matlab.automation.streams.OutputStream
            end
            plugin.Output = stream;
        end
    end

    methods (Access=protected)
        function runTest(plugin,pluginData)
            print(plugin.Output,"### Running test: %s\n",pluginData.Name)
            % Invoke the superclass method
            runTest@matlab.unittest.plugins.TestRunnerPlugin( ...
                plugin,pluginData)
        end
    end
end