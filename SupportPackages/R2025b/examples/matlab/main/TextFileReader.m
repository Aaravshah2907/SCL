classdef (StrictDefaults)TextFileReader < matlab.System & matlab.system.mixin.FiniteSource
%TextFileReader Delimited text data file reader
%   FILEREADER = TextFileReader returns a text file reader System
%   object(TM), which streams multichannel numeric data from a
%   delimiter-separated text data file using the default settings.
% 
%   FILEREADER = TextFileReader('PropertyName', PropertyValue, ...)
%   returns a delimited text data file reader System object, with each
%   specified property set to a specified value.
%
%   Y = FILEREADER() reads multichannel data from the file specified in
%   FILEREADER.Filename in into output matrix Y. TextFileReader assumes that data
%   rows are stored in separate lines, each containing a number of
%   delimiter-separated values equal to the number of columns returned in
%   the output matrix Y.
%   The first call to step starts reading from the line immediately
%   following the initial textual header.
%   Subsequent calls to step resume reading from the last line read.
%   Internally, the step method uses the built-in MATLAB function fscanf.
% 
%   Instead of call the System object directly, you can use
%   the step method. For example, y = step(obj) and y = obj() are
%   equivalent.
%
%   TextFileReader methods:
%
%   step        - See above description for use of this method
%   release     - Release control of the file and cause the object to
%                 re-initialize when step is next called
%   clone       - Create a new text file reader object with the same
%                 property values and internal states. The original and the
%                 cloned objects are able to read from the same file
%                 independently. The cloned object will keep pointing at
%                 the same file location as the original object
%   reset       - Resume data reading from the beginning of the data as
%                 specified by HeaderLines
%   isDone      - Returns true of all data available is the file is read.
%                 If PlayCount > 1, isDone does not return true unless the
%                 data has been read PlayCount times.
% 
%   BinaryFileReader properties:
% 
%   Filename        - Name of the file from which to read the data
%   HeaderLines     - Number of lines to skip at the beginning of the file
%   DataFormat      - Data format used to read individual numerical values
%   Delimiter       - Textual delimiter used to separate columns in the
%                     text file
%   SamplesPerFrame - Number of rows in the output matrix returned by step
%   PlayCount       - Number of times the object can wrap around reading
%                     of the data content in the file
%

properties (Nontunable)
        %Filename File name
        % Name of the file to read, including
        % a file extension. The file should be on the current MATLAB
        % search path
        Filename   = 'tempfile.txt'
        %HeaderLines Number of header lines
        % Number of lines used by the header at the
        % beginning of the file, which also defines the beginning of the 
        % data within the file. This is the number of lines skipped by the
        % object before starting to look for valid numerical data.
        % The first call to step starts reading
        % from line number HeaderLines+1. Subsequent calls to step keep
        % reading from the line immediately following the previously read
        % line. Calling reset will resume reading from line HeaderLines+1.
        HeaderLines = 4
    end
    
    properties
        %DataFormat Data format
        % Numeric format of each data sample read
        % from the file. DataFormat accepts any value assignable as
        % Conversion Specifier within the formatSpec string used
        % by the MATLAB built-in function fprintf. 
        % DataFormat applies to all channels written to the file. 
        % The default for this property is '%g', which can read data in
        % integer, fractional and scientific format.
        DataFormat = '%g'
        %Delimiter Data delimiter
        % Character used to separate samples from
        % within a line in the file read.
        % TextFileReader look at the first data line following the header,
        % and it infers the number of channels in the file by counting the
        % number of delimiters present and adding 1. It then returns an
        % output matrix with a number of columns equal to the number of
        % channels found. The default value for Delimiter is ',', and it
        % can be set to any character string.
        Delimiter = ','
        %SamplesPerFrame Samples per frame
        % Number of rows of the output matrix Y
        % returned by step. The size of Y is SamplesPerFrame x NumChannels.
        % At every call to step, TextFileReader advances through the file
        % by a number of lines equal to SamplesPerFrame.
        % When the last data sample in the file is reached before
        % reaching the number of data required to fill Y, then additional
        % sample values are added to Y to reach the target size. If
        % PlayCount is greater than 1 and the maximum number of counts has
        % not yet been reached, then reading resumes from the beginning of
        % the file, until a whole data frame is completed. If PlayCount is
        % 1 or the total number of counts has been reached, zeros are
        % concatenated to the available data to form a fully-sized output
        % matrix Y. 
        SamplesPerFrame = 1024
        %PlayCount Play count
        % Number of times the object can wrap around
        % reading the data content of the file. After reading has resumed
        % from the beginning of the data PlayCount-1 times and the end of
        % the data is reached, the object returns zeros and all calls to
        % isDone return true.        
        PlayCount = 1
    end
    
    properties(Access = private)
        % Saved value of the file identifier
        pFID = -1
        % Number of channels detected in the file
        pNumChannels
        % Complete line format
        pLineFormat
        % Number of times reading reached the end of the file
        pNumEofReached = 0
    end
    
    properties(Constant, Hidden)
        PadValue = 0
    end
    
    methods
        % Constructor for the System object
        function obj = TextFileReader(varargin)
            setProperties(obj, nargin, varargin{:});
        end
    end
    
    % Overridden implementation methods
    methods(Access = protected)
        % initialize the object
        function setupImpl(obj)
            % Populate obj.pFID
            getWorkingFID(obj)

            % Go to start of data
            goToStartOfData(obj)
            % Use first data line to lock format and number of channels
            % based on number of delimiters present
            lockNumberOfChannelsUsingCurrentLine(obj)            
        end
        
        % reset the state of the object
        function resetImpl(obj)
            % Go to beginning of the file and skip header lines
            goToStartOfData(obj)
            obj.pNumEofReached = 0;
        end
        
        % execute the core functionality
        function y = stepImpl(obj)
            spf = obj.SamplesPerFrame;
            rawData = readNDataRows(obj, spf);
            y = reshape(rawData,obj.pNumChannels,[]).';
        end
        
        % release the object and its resources
        function releaseImpl(obj)
            fclose(obj.pFID);
            obj.pFID = -1;
        end
        
        % indicate if we have reached the end of the file
        function tf = isDoneImpl(obj)
            tf = logical(feof(obj.pFID));
        end
        
        function processTunedPropertiesImpl(obj)
            lockNumberOfChannelsUsingCurrentLine(obj)
        end
        
        function loadObjectImpl(obj,s,wasLocked)
            % Call base class method
            loadObjectImpl@matlab.System(obj,s,wasLocked);

            % Re-load state if saved version was locked
            if wasLocked
                % All the following were set at setup
                
                % Set obj.pFID - needs obj.Filename (restored above)
                obj.pFID = -1; % Superfluous - already set to -1 by default
                getWorkingFID(obj);
                % Go to saved position
                fseek(obj.pFID, s.SavedPosition, 'bof');
                
                obj.pNumChannels = s.pNumChannels;
                obj.pLineFormat = s.pLineFormat;
                obj.pNumEofReached = s.pNumEofReached;
            end

        end
        
        function s = saveObjectImpl(obj)
            % Default implementation saves all public properties
            s = saveObjectImpl@matlab.System(obj);

            if isLocked(obj)
                % All the fields in s are properties set at setup
                s.SavedPosition = ftell(obj.pFID);
                s.pNumChannels = obj.pNumChannels;
                s.pLineFormat = obj.pLineFormat;
                s.pNumEofReached = obj.pNumEofReached;
            end
        end
        
    end
    
    methods(Access = private)
        
        function getWorkingFID(obj)
            if(obj.pFID < 0)
                [obj.pFID, err] = fopen(obj.Filename, 'r');
                if ~isempty(err)
                    error(message('dsp:FileReader:fileError', err));
                end
            end

        end
        
        function goToStartOfData(obj)
            fid = obj.pFID;
            fseek(fid, 0, 'bof');
            % Skip header lines
            for k = 1:obj.HeaderLines
                fgets(fid);
            end
        end
        
        function currline = peekCurrentLine(obj)
            % Get FID
            fid = getWorkingFID(obj);
            % Save position
            oldpos = ftell(fid);
            % Get current line (and advance implicit pointer)
            currline = fgets(fid);
            % Go back to position before reading
            fseek(fid, oldpos, 'bof');
            % No need to save obj.pPosition...
        end
        
        function lockNumberOfChannelsUsingCurrentLine(obj)
            % Get FID
            fid = obj.pFID;
            % Save position
            oldpos = ftell(fid);
            % Get current line (and advance implicit pointer)
            currentLine = fgets(fid);
            % Go back to position before reading
            fseek(fid, oldpos, 'bof');
            % Position now restored...

            % Infer number of channels from delimiter and first data line
            delimiter = obj.Delimiter;
            delimitersPositions = strfind(currentLine, delimiter);
            numChannels = numel(delimitersPositions)+1;
            obj.pNumChannels = numChannels;
             
            % Compose and lock down line-reading format, based on
            % - Data Format (Provided as property)
            % - Delimiter (Provided as property)
            % - Number of channels detected (Just inferred)
            obj.pLineFormat = [...
                repmat([obj.DataFormat,delimiter],1,numChannels-1),...
                obj.DataFormat,'\n'];

        end
        
        function rawData = readNDataRows(obj, numLines)
            numChannels = obj.pNumChannels;

            tmp = fscanf(obj.pFID, obj.pLineFormat, numLines*numChannels);

            numValuesRead = numel(tmp);
            numLinesRead = floor(numValuesRead/numChannels);
            if(numLinesRead == numLines)&&(~feof(obj.pFID))
                rawData = tmp;
            else
                % End of file - may also need to complete frame
                obj.pNumEofReached = obj.pNumEofReached + 1;
                if(obj.pNumEofReached < obj.PlayCount)
                    % Keep reading from start of file
                    goToStartOfData(obj)
                    moreData = readNDataRows(obj, numLines-numLinesRead);
                    rawData = [tmp; moreData];
                else
                    % First pad with pad value, then reshape
                    padVector = repmat(obj.PadValue, ...
                        numLines*numChannels - numValuesRead, 1);
                    rawData = [tmp; padVector];
                end
            end
        end
        
    end

end


