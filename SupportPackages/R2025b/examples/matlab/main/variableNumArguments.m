function varargout = variableNumArguments(varargin)
if nargout > nargin
    error("variableNumArguments:TooManyOutputs", ...
        "Number of outputs must not exceed the number of inputs.")
end
varargout = cell(1,nargout);
for i = 1:nargout
    varargout{i} = class(varargin{i});
end
end