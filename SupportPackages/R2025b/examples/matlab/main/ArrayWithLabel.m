classdef ArrayWithLabel < matlab.mixin.indexing.RedefinesParen

    properties (Access=private)
        ContainedArray
    end
    
    properties (Access=public)
        Label
    end
    
    methods
        function obj = ArrayWithLabel(val)
            obj.ContainedArray = val;
        end
    end

    methods (Access=protected)
        function varargout = parenReference(obj, indexOp)
            obj.ContainedArray = obj.ContainedArray.(indexOp(1));
            if isscalar(indexOp)
                varargout{1} = obj;
                return;
            end
            [varargout{1:nargout}] = obj.(indexOp(2:end));
        end

        function obj = parenAssign(obj,indexOp,varargin)
            % Ensure object instance is the first argument of call.
            if isempty(obj)
                obj = varargin{1};
            end
            if isscalar(indexOp)
                assert(nargin==3);
                rhs = varargin{1};
                obj.ContainedArray.(indexOp) = rhs.ContainedArray;
                return;
            end
            [obj.(indexOp(2:end))] = varargin{:};
        end

        function n = parenListLength(obj,indexOp,ctx)
            if numel(indexOp) <= 2
                n = 1;
                return;
            end
            containedObj = obj.(indexOp(1:2));
            n = listLength(containedObj,indexOp(3:end),ctx);
        end

        function obj = parenDelete(obj,indexOp)
            obj.ContainedArray.(indexOp) = [];
        end
    end

    methods (Access=public)
        function out = value(obj)
            out = obj.ContainedArray;
        end
        
        function out = sum(obj)
            out = sum(obj.ContainedArray,"all");
        end
        
        function out = cat(dim,varargin)
            numCatArrays = nargin-1;
            newArgs = cell(numCatArrays,1);
            for ix = 1:numCatArrays
                if isa(varargin{ix},'ArrayWithLabel')
                    newArgs{ix} = varargin{ix}.ContainedArray;
                else
                    newArgs{ix} = varargin{ix};
                end
            end
            out = ArrayWithLabel(cat(dim,newArgs{:}));
        end

        function varargout = size(obj,varargin)
            [varargout{1:nargout}] = size(obj.ContainedArray,varargin{:});
        end
    end

    methods (Static, Access=public)
        function obj = empty()
            obj = ArrayWithLabel([]);
        end
    end
end