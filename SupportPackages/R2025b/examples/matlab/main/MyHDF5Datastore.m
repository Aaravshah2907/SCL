%% STEP 1
classdef MyHDF5Datastore < matlab.io.Datastore ...
                       & matlab.io.datastore.Subsettable

    properties
        Filename            (1, 1) string
        Datasets            (:, 1) string {mustBeNonmissing} = "/"
        CurrentDatasetIndex (1, 1) double {mustBeInteger, mustBeNonnegative} = 1
    end

%% STEP 2
    methods
        function ds = MyHDF5Datastore(Filename, Location)
            arguments
                Filename (1, 1) string
                Location (1, 1) string {mustBeNonmissing} = "/"
            end

            ds.Filename = Filename;
            ds.Datasets = listHDF5Datasets(ds.Filename, Location);
        end

        function [data, info] = read(ds, varargin)
            if ~hasdata(ds)
                error(message("No more datasets to read."));
            end

            dataset = ds.Datasets(ds.CurrentDatasetIndex);
            data = { h5read(ds.Filename, dataset, varargin{:}) };
            if nargout > 1
                info =   h5info(ds.Filename, dataset);
            end

            ds.CurrentDatasetIndex = ds.CurrentDatasetIndex + 1;
        end

        function tf = hasdata(ds)
            tf = ds.CurrentDatasetIndex <= numel(ds.Datasets);
        end

        function reset(ds)
            ds.CurrentDatasetIndex = 1;
        end
    end

    methods (Access = protected)
        function subds = subsetByReadIndices(ds, indices)
            datasets = ds.Datasets(indices);

            subds = copy(ds);
            subds.Datasets = datasets;
            reset(subds);
        end

        function n = maxpartitions(ds)
            n = numel(ds.Datasets);
        end
    end
end

%% STEP 3
function datasets = listHDF5Datasets(filename, location, args)
    arguments
        filename (1, 1) string
        location (1, 1) string
        args.IncludeSubGroups (1, 1) logical = true
    end

    if strlength(location) == 0
        location = "/";
    end

    info = h5info(filename, location);

    datasets = listDatasetsInH5infoStruct(info, location, IncludeSubGroups=args.IncludeSubGroups);
end

function datasets = listDatasetsInH5infoStruct(S, location, args)
    arguments
        S (1, 1) struct
        location (1, 1) string
        args.IncludeSubGroups (1, 1) logical = true
    end

    datasets = string.empty(0, 1);

    if isfield(S, "Datatype")
        datasets = location;
    elseif isfield(S, "Datasets")
        if ~isempty(S.Datasets)
            datasets = location + "/" + {S.Datasets.Name}';
        end

        if args.IncludeSubGroups
            listFcn = @(group) listDatasetsInH5infoStruct(group, group.Name, IncludeSubGroups=true);
        else
            listFcn = @(group) string(group.Name);
        end

        childDatasets = arrayfun(listFcn, S.Groups, UniformOutput=false);
        childDatasets = vertcat(childDatasets{:});

        datasets = [datasets; childDatasets];
    end

end
