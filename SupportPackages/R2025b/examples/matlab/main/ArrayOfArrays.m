classdef ArrayOfArrays < matlab.mixin.indexing.RedefinesParen & ...
        matlab.mixin.indexing.RedefinesBrace
   
    properties (Access=private)
        Arrays (1,:) cell
    end

    methods (Access=protected)
        function varargout = braceReference(obj,indexOp)
            [varargout{1:nargout}] = obj.Arrays.(indexOp);
        end

        function obj = braceAssign(obj,indexOp,varargin)
            if isscalar(indexOp)
                [obj.Arrays.(indexOp)] = varargin{:};
                return;
            end
            [obj.Arrays.(indexOp)] = varargin{:};
        end

        function n = braceListLength(obj,indexOp,indexContext)
            n = listLength(obj.Arrays,indexOp,indexContext);
        end

        function out = parenReference(obj,indexOp)
            ErrorForUnsupportedIndexing(indexOp);
            out = obj;
            out.Arrays = obj.Arrays.(indexOp);
        end

        function obj = parenAssign(obj,indexOp,in)
            ErrorForUnsupportedIndexing(indexOp);
            ErrorForUnexpectedRightHandSide(in);
            obj.Arrays.(indexOp) = in.Arrays;
        end

        function n = parenListLength(~,~,~)
            n = 1;
        end

        function obj = parenDelete(obj,indexOp)
            obj.Arrays.(indexOp) = [];        
        end
    end

    methods (Access=public)
        function obj = ArrayOfArrays(varargin)
            if nargin > 0
                obj.Arrays = varargin;
            else
                obj.Arrays = [];
            end
        end

        function out = cat(~,varargin)
            out = ArrayOfArrays;
            for ix = 1:length(varargin)
                tmp = varargin{ix};
                if isa(tmp,'ArrayOfArrays')
                    out.Arrays = [out.Arrays,tmp.Arrays];
                else
                    out.Arrays{end+1} = tmp;
                end
            end
        end

        function varargout = size(obj,varargin)
            [varargout{1:nargout}] = size(obj.Arrays,varargin{:});
        end
    end
    
    methods (Static)
        function out = empty()
            out = ArrayOfArrays();
        end
    end
end

function ErrorForUnsupportedIndexing(indexOp)
    if ~isscalar(indexOp)
        error('Indexing after parentheses indexing is not supported.');
    end
end

function ErrorForUnexpectedRightHandSide(val)
    if ~isa(val,'ArrayOfArrays')
        error(['Parentheses assignment is only supported when the ' ...
            'right-hand side is an ArrayOfArrays.']);
    end
end