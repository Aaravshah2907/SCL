% This example shows how to implement a MATLAB class and object to collect
% the raw BLE characteristic value, on demand for a desired duration.

%   Copyright 2023 The MathWorks, Inc.

classdef bleDataCollector<handle
    properties(GetAccess=public,SetAccess=private,Dependent)
        % Characteristic name of the BLE device
        BLECharacteristicName (1,1) {mustBeTextScalar}
    end

    properties(Access=private)
        % BLE characteristic object
        CharObj   matlabshared.blelib.Characteristic {mustBeScalarOrEmpty}
        % All the characteristic value collected
        CollectedData (1,:) = []
    end

    methods
        function obj = bleDataCollector(bleObj,serviceInput,characteristicInput)
            % Connect to the characteristic of a BLE device to collect the
            % data sent by the device.
            %
            % bleObj              - ble connection object
            % serviceInput        - Service name or UUID
            % characteristicInput - Characteristic name or UUID
            %
            % Example:
            % obj = bleDataCollector(bleObj,"180D","2A37")
            arguments
                bleObj              ble   {mustBeScalarOrEmpty}
                serviceInput        (1,1) {mustBeTextScalar}
                characteristicInput (1,1) {mustBeTextScalar}
            end
            % Create BLE characteristic object
            obj.CharObj = characteristic(bleObj,serviceInput,characteristicInput);
            % Initialize the callback function to collect the
            % characteristic value sent by the BLE device
            obj.CharObj.DataAvailableFcn = (@(src,event)collectCharacteristicValue(obj,src,event));
            % Disable characteristic value collection. Enable it on demand
            unsubscribe(obj.CharObj);
        end

        function data = collectDataForDuration(obj,duration)
            % Collect the ble characteristic value for a given duration.
            %
            % obj      - Object of bleDataCollector class
            % duration - Duration for which data needs to be collected
            %
            % Examples:
            % Collect the characteristic value for 5seconds
            % collectDataForDuration(bleDataObj,5)
            arguments
                obj      (1,1) bleDataCollector
                duration (1,1) {mustBePositive}
            end
            % Initialize the data to be collected
            data = [];
            % Subscribe to the characteristic value notification or
            % indication. This will enable the callback function to be
            % triggered whenever BLE device has new characteristic value
            subscribe(obj.CharObj);
            % Pause till the required data is collected
            pause(duration);
            % Disable characteristic value collection after the required
            % duration
            unsubscribe(obj.CharObj);
            % Return the collected data. This data is the raw
            % characteristic value collected from the BLE device. Implement
            % additional decoding logic for specific end application
            % requirements.
            data = obj.CollectedData;
        end

        function value = get.BLECharacteristicName(obj)
            % Getter function to fetch the BLE characteristic name
            value = obj.CharObj.Name;
        end
    end

    methods(Access=private,Hidden)

        function collectCharacteristicValue(obj,charObj,~)
            % After subscribing to the notification or indication of
            % BLE characteristic value, this callback function will be
            % triggered each time the BLE device sends new characteristic
            % data.
            currentData = read(charObj,'oldest');
            % Append the new data with the existing data
            obj.CollectedData = [obj.CollectedData currentData];
        end

        function delete(obj)
            % Destructor
            if ~isempty(obj.CharObj)
                % Clear the characteristic object
                clear obj.CharObj;
            end
        end
    end

end
