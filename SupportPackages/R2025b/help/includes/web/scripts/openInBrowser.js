function getOpenWithConfig (component, exampleId) {
    var config = {
        coordinates: {
            component: component,
            exampleId: exampleId
        },
        repository: "MATLAB Examples",
        initializationCode: "openExample('" + component + "/" + exampleId +"');",
        targetViewer: "MATLAB_ONLINE",
        containerType: "external"
    }

    return config;
}

function getOpenWithContainerOptions() {
    var containerOpts = {
        containerType: "external"
    };
    return containerOpts;
}

function getOpenWithLabel(isModel) {
    this.getString = function() { 
        if (isModel) {
			return getLocalizedString("open_in_simulink_online");
        } else {
			return getLocalizedString("open_in_matlab_online");
        }
    }

    this.getStatus = function() { 
        if (isModel) {
            return "SL_Online";
        } else {
            return "open_in_MO";
        }
    }
}