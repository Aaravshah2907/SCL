classdef ScalarStructClass < matlab.mixin.indexing.RedefinesDot & ...
    matlab.mixin.Scalar
     
    properties (Dependent, SetAccess=private)
        FieldNames
    end

    properties (Access=private)
        AddedFields struct
    end

    methods
        function out = get.FieldNames(obj)
            out = string(fieldnames(obj.AddedFields));
        end
    end

    methods (Access=public)
        function obj = ScalarStructClass(fieldName,fieldValue)
            if nargin == 1
                obj.AddedFields = fieldName;
                return;
            end
            obj.AddedFields = struct(fieldName,fieldValue);
        end

        function out = getAddedFields(obj)
            out = obj.AddedFields;
        end
    end

    methods (Access=protected)
        function varargout = dotReference(obj,indexOp)
            [varargout{1:nargout}] = obj.AddedFields.(indexOp);
        end

        function obj = dotAssign(obj,indexOp,varargin)
            [obj.AddedFields.(indexOp)] = varargin{:};
        end
        
        function n = dotListLength(obj,indexOp,indexContext)
            n = listLength(obj.AddedFields,indexOp,indexContext);
        end
    end
end