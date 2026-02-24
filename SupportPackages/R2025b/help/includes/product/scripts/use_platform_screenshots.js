/*global window, $, document */

function usePlatformScreenshots() {
    "use strict";
    let d1;
    let connectorDocSource = getConnectorDocSource();

    const archFromCookie = getArchFromCookie();

    // If we are able to retrieve the arch from the mw-docsearch provided cookie then update and return
    if (archFromCookie) {
        updatepath(archFromCookie);
        return;
    }

    // Otherwise, use connector service to determine arch
    if (connectorDocSource) {
        d1 = getArchDeferred();
    }

    if (d1) {
        $.when(d1).done(updatepath);
    }
}

function updatepath(archVal) {
    let platformPattern = /\/examples\/(\w+)\/(glnxa64|maci64|maca64|win64)\//;
    let platform = 'win64';
    if (isFromMatlabOnline()) {
        platform = 'glnxa64';
    } else if (archVal) {
        platform = archVal;
    }

    $('img').each(function () {
        let img = $(this),
            src = img.attr('src');
        src = src.replace(platformPattern, '/examples/$1/' + platform + '/');
        img.attr('src', src);
        let mwCardContainer = img.parent().parent('.mw_card_image');
        if (mwCardContainer.length === 1) {
            let cardMediaDiv = mwCardContainer.first();
            let backgroundImgSrc = cardMediaDiv.css('background-image');
            backgroundImgSrc = backgroundImgSrc.replace(platformPattern, '/examples/$1/' + platform + '/');
            cardMediaDiv.css('background-image', backgroundImgSrc);
        }
    });
}

function getConnectorDocSource() {
    let supportedSources = getSupportedSources();  
    if(supportedSources.indexOf("mw") > -1) {
        return "mw";
    } else {
        return undefined;
    }
}

function getSupportedSources() {
   let supportedSources;
   let searchSource = getSessionStorageItem('searchsource');
   
   if (searchSource) {
      searchSource = searchSource.replace("+", " ");
      supportedSources = searchSource.split(" ");
   } else {
      supportedSources = [];
   }
   return supportedSources;
}

function getArchFromCookie() {
    const cookieRegexp = /InstalledDocArch=([^;]*)/;
    const archMatch = cookieRegexp.exec(document.cookie);
    if (archMatch && archMatch.length > 1) {
        const validArchValues = new Set(['glnxa64', 'maci64', 'maca64', 'win64']);
        const archValue = archMatch[1];
        if (validArchValues.has(archValue)) {
            return archValue;
        }
    }
    return null;
}

function getArchDeferred() {
    let deferred = $.Deferred(function() {});
    let request = new XMLHttpRequest();
    let url = "/messageservice/json/secure";
	let arch;

	request.open("POST", url, true);
	request.setRequestHeader("Content-type", "application/json");
	request.onreadystatechange = function() {
		if(request.readyState == 4) {  // value 4 = state DONE
			if(request.status == 200) { // value 200 = state DONE
			try {
				let myArr = JSON.parse(request.responseText);
				arch = myArr.messages.ArchMessageResponse[0].arch;
			} catch (e) {
				arch = 'win64';
			}
				deferred.resolve(arch);
			} else {
				deferred.reject();
            }
		}
	};
	let msg = "{\"uuid\": \"123\",\"messages\": {\"ArchMessage\": [{}]}}";
	request.send(msg);
	
	return deferred;   
}

$(document).ready(usePlatformScreenshots);

$(window).bind('examples_cards_added', function(e) {
   usePlatformScreenshots();
});