$(document).ready(function () {
    // Trap the RN Categories form dropdown, for multiple selections and screen reader use
    document.addEventListener('click', function (event) {
        const dopdownContainer = document.getElementById('rn-form-categories-dropdown');
        const dropdownMenu = document.getElementById('rn-category-group');
        const isClickInsideDropdown = dopdownContainer.contains(event.target);
        const isDropdownOpen = dropdownMenu.classList.contains('show');

        // Escape the trap and submit the changes, if the click is outside the dropdown and the dropdown is open
        if (!isClickInsideDropdown && isDropdownOpen) {
            document.forms.rnform.submit();
        }
    }, true); // The `true` here signifies that the listener is set up for the capturing phase or else it may not catch the event
})

let releaseNotesType = 'lucene'; // For web doc
if ($("meta[name=productrntype][content=installed]").length == 1){
    // For installed doc (though text filter and product filter won't work without MATLAB).
    releaseNotesType = 'saxonjs';
}

window.JST = window.JST || {};

/* Used only in Lucene implementation to take advantage of SaxonJS nav elements */
function getSaxonNavItems() {
    const mysourceLocation = "release-notes-content" + langcode + ".html";
    // We can't retrieve the stylesheet location from the HTML, so build it up here
    let thisRelease = allRnReleases[allRnReleases.length - 1];
    SaxonJS.transform({
        stylesheetLocation: `/help/releases/${thisRelease}/includes/shared/scripts/releasenotes-sef.json`,
        sourceLocation: mysourceLocation,
        stylesheetParams: {
            "valid_release_dates": allRnReleases,
            "shortname": shortname,
            "rncatkey": rncatkey,
            "rncatlabel": rncatlabel,
            "product_list_location": product_list_location,
            "leftnav_only": true
        }
    }, 'async').then(function () {
        showCategories(rncatkey);
        showPageShareButton(doccentertype);
    });
}

/* Used only in Saxon-JS implementation */
function getProductFilteredReleaseNotes(mystylesheetLocation, shortname, allRnReleases, doccentertype, langcode, relpathtohelptop, product_list_location, rncatkey, rncatlabel) {

  var mysourceLocation = "release-notes-content" + langcode + ".html";

  /* Make 1 or 2 asynchronous calls. Expected cases:
     A. User specified rntext, so call Bleve
       A1. From MATLAB: Bleve and product filter both succeed
       A2. W/o MATLAB:  Bleve and product filter both fail
     B. User did not specify rntext, so skip call to Bleve
       B1. From MATLAB: Product filter succeeds
       B2. W/o MATLAB:  Product filter fails
  */    

  var d1 = getProductsDeferred();
  var d2 = undefined;
  var searchParams = new URLSearchParams(window.location.search.slice(1));
  var textParams = alignFilterWithHighlightParam({
      "rntext": searchParams.get('rntext'),
      "searchHighlight": searchParams.get('searchHighlight')
  })
  var rntext = textParams.rntext;

  if (rntext) {
    var pathtoproduct = window.location.href.replace(/^.*\/help\//,'').replace(/\/release-notes.*$/,'')
    d2 = getBleveDeferred(rntext,pathtoproduct);
  }

  $.when(d1,d2).done(function (v1,v2) {
    // Set up product filter output for Saxon-JS.
    var prodlist = v1.prodnavlist;
    if (typeof prodlist === "string") {
      prodlist = $.parseJSON(prodlist);
    }        
    var productfilter_shortnames = new Array(prodlist.length);
    for (var i = 0; i < prodlist.length; i++) {
      if (!products_without_rn.includes(prodlist[i].shortname)) {
        productfilter_shortnames[i] = prodlist[i].shortname;
      }
    }
    // Set up Bleve output for Saxon-JS, if Bleve was called.
    var rntext_result_ids = null; // Will map to empty sequence in Saxon-JS
    if (v2) {
      rntext_result_ids = v2.response;
      // In local storage, store the words Bleve found. Later,
      // the applySearchHighlight function will retrieve them
      // when highlighting exact or inexact matches.      
      var highlightexpand = {};
      for (const key in v2.wordmatchmap){
        if(v2.wordmatchmap.hasOwnProperty(key)){
          highlightexpand[key] = v2.wordmatchmap[key].split(",");
        }
      }
      storeHighlightExpand(rntext, highlightexpand);
    }

    document.rnform.style="display:none;"; // Saxon-JS shows left nav when ready
    SaxonJS.transform({
      stylesheetLocation: mystylesheetLocation,
      sourceLocation: mysourceLocation,
      stylesheetParams: {
        "valid_release_dates": allRnReleases,
        "shortname": shortname,
        "doccentertype": doccentertype,
        "langcode": langcode,
        "productfilter_shortnames": productfilter_shortnames,
        "relpathtohelptop": relpathtohelptop,
        "product_list_location": product_list_location,
        "rncatkey": rncatkey,
        "rncatlabel": rncatlabel,
        "rntext_result_ids": rntext_result_ids
      }
    },'async').then(function(){ postSaxonJSoperations(rncatkey,doccentertype); });

  }).fail(function (jqXHR, textStatus, error) {
    SaxonJS.transform({
      stylesheetLocation: mystylesheetLocation,
      sourceLocation: mysourceLocation,
      stylesheetParams: {
        "valid_release_dates": allRnReleases,
        "shortname": shortname,
        "doccentertype": doccentertype,
        "langcode": langcode,
        "productfilter_shortnames": [],
        "relpathtohelptop": relpathtohelptop,
        "product_list_location": product_list_location,
        "rncatkey": rncatkey,
        "rncatlabel": rncatlabel
      }
    },'async').then(function(){ postSaxonJSoperations(rncatkey,doccentertype); });
  });

}

// JavaScript code to call only after Saxon-JS has completed transform
function postSaxonJSoperations(rncatkey,doccentertype) {
  applySearchHighlight();
  addSmoothScroll();
  expandCollapsedContent(true);
  populateProductUpdatesSaxonJS();
  //initDocSurvey();
  showCategories(rncatkey);
  showPageShareButton(doccentertype);
  findActiveProduct();
  highlightJSHandler();
}

// Unhide categories dropdown and add nuggets, as applicable
function showCategories(rncatkey) {
    if (rncatkey != undefined && rncatkey.length > 0) {
        let categoryDropDown = document.querySelector("#rn-form-categories-dropdown");
        let params = parseParams();
        categoryDropDown.removeAttribute('hidden');
        updateButtonWithSelectedCategories();
        addNuggets(params,'categories');
    }
}

// Unhide Release Notes Page Share Button, if not in Installed/Product Doc
function showPageShareButton(doccentertype) {
    if(doccentertype !== 'product') {
        const shareButton = document.getElementById('release-note-share-button');
        const shareButtonAnchor = document.getElementById('release-note-share-button-anchor');
        shareButton.removeAttribute('hidden');
        shareButton.addEventListener('click', function(event) {
            getShareLink(shareButtonAnchor,'page');
        });
    }
}

// Add Update release information to page that Saxon-JS has rendered
function populateProductUpdatesSaxonJS() {
  var d2 = getProductUpdates();
  $.when(d2).done(function (productUpdates) {
    for (var releasename in productUpdates) {
      var productUpdatesForRelease = productUpdates[releasename];
      if (productUpdatesForRelease) {
        var productUpdateMarkup = getProductUpdateMarkup(productUpdatesForRelease);
        if (productUpdateMarkup && productUpdateMarkup.length > 0) {
          // Replace <div id="R####x_updates"/> with computed markup,
          // if such a div is present. It is present when user sorted
          // by release and included this particular release in
          // the release range.
          $("#" + releasename + "_updates").replaceWith(productUpdateMarkup);
        }
      }
    } // end of for loop
  }); // end of "done" callback function
}

/* Used only in Saxon-JS implementation */
function getBleveDeferred(rntext,pathtoproduct) {

  var deferred = $.Deferred(function() {});
  var services = {
    "rnservice": "help/search/rnquery",
    "localservice": "/help/search/rnquery"
  };
  var searchData = {
    "rntext": rntext,
    "pathtoproduct": pathtoproduct,
  };
  var errorhandler = function(err, textStatus, jqXHR) {
    deferred.reject();
  }
  var successhandler = function(data) {
    deferred.resolve(data);
  }
  requestHelpService(searchData, services, successhandler, errorhandler);
  return deferred;
}

function init() {

    if (releaseNotesType === 'lucene') {
        window.rnLocaleSuffix = getLocaleSuffix();
        handleReleaseNotes();
        $(window).on('hashchange', checkHash);
    }
    $(document.forms.rnform).submit(function() {
        if (document.forms.rnform.searchHighlight) {
            document.forms.rnform.searchHighlight.value = document.forms.rnform.rntext.value;
        }
    });
    if (releaseNotesType === 'saxonjs') {
        handleReleaseNotes();
    //} else {
        //initDocSurvey();
    } 
}

function handleReleaseNotes() {
    if (releaseNotesType === 'lucene') {
        id = parseHash();
        if (id && id.length > 0) {
            handleId(id);
        } else {
            var params = parseParams();
            populateDefaults(params);
            populateForm(params);
            populateSort(params);
            expandReleases(params);
            addReleaseRange(params);
            addNuggets(params);
            if (params.rntype && params.rntype.includes('highlight')) {
                let thisRelease = allRnReleases[allRnReleases.length - 1];
                getProductFilteredReleaseNotes(`/help/releases/${thisRelease}/includes/shared/scripts/releasenotes-sef.json`, shortname, allRnReleases, doccentertype, langcode, relpathtohelptop, product_list_location, rncatkey, rncatlabel);
            } else {
                getAllReleaseNotes(params);
            }
            getSaxonNavItems(); // Call to Saxon to get left nav and categories for the form
        }
    } else {
        var params = parseParams();
        populateDefaults(params);
        populateForm(params);
        populateSort(params);
        addNuggets(params);
    }
}

function resetNotes() {
    document.location = document.location.pathname;
}

/* Used only in Lucene implementation */
function checkHash() {
    var id = parseHash();
    if (id && id.trim().length > 0 && $("#" + id).length == 0) {
        handleId(id);
    }
}

/* Used only in Lucene implementation */
function parseHash() {
    var hash = window.location.hash;
    if (hash && hash.length > 0) {
        return hash.replace(/^#/,"");
    } else {
        return "";
    }
}

/* Used only in Lucene implementation */
function handleId(id) {
    var params = {"id":id};
    populateDefaults(params);
    getAllReleaseNotes(params);
}

function alignFilterWithHighlightParam(params) {
    if (params.rntext) {
        params.searchHighlight = params.rntext;
    } else if (params.searchHighlight) {
        params.rntext = params.searchHighlight.replace(/&#34;/g,'"');
    }
    return params;
}

function parseParams() {
	var params = {};
    var qs = window.location.search;
    if (qs && qs.length > 0) {
        var paramsArray = qs.replace(/^\?/,"").split("&");
        for (var i = 0; i < paramsArray.length; i++) {
            var nameValPair = paramsArray[i].split("=");
            var name = nameValPair[0];
            var value = nameValPair.length > 1 ? nameValPair[1] : "";
            if (name === 'category') {
                value = '"' + value + '"';
            }
            if (name && name.length > 0) {
                value = decodeURIComponent(value.replace(/\+/g," "));
                if (params[name]) {
                    params[name] += "," + value;
                } else {
                    params[name] = value;
                }
            }
        }
    }
    params = alignFilterWithHighlightParam(params);
    return params;
}

function populateDefaults(params) {
    params.product = shortname;
    if (!params.groupby) {
        params.groupby = "release";
        params.sortby = "descending";
    }
}

function populateSort(params) {
    var sortvalue = params.groupby;
    if (params.sortby) {
        sortvalue += "-" + params.sortby;
    }
    var sortSelect = document.getElementById('selectsort');
    for (var i = 0; i < sortSelect.options.length; i++) {
    	var sortOption = sortSelect.options[i];
        if (sortOption.value === sortvalue) {
            sortOption.selected = true;
            break;
        }
    }
}

function handleSort(sortOption) {
    var optionParts = sortOption.split(/-/);
    var searchForm = document.forms.rnform;
    searchForm.groupby.value = optionParts[0];
    searchForm.sortby.value = optionParts[1];
    searchForm.submit();
}

function populateForm(params) {
    populateReleaseFields(params);
    populateTextFields(params, ["rntext","groupby","sortby","searchHighlight"]);
    document.forms.rnform.searchHighlight.value = document.forms.rnform.rntext.value;

    var searchForm = document.forms.rnform;
    
    var checkboxes = document.forms.rnform.rntype; // This is a NodeList of checkboxes
    
    // Iterate over the checkboxes and update the rntype ones as necessary
    for (var i = 0; i < checkboxes.length; i++) {
    if (params.rntype) {
        checkboxes[i].checked = hasRntype(params, checkboxes[i].value);
    } else {
        checkboxes[i].checked = false; // Optionally uncheck all if no rntype is specified
    }
}

    if (params.category) {
        var categories = getCategoriesFromParams(params);
        $("input[name='category']").each(function(i,checkboxElt) {
            checkboxElt.checked = categories.indexOf(checkboxElt.value) >= 0;
        });
    }
}

function getCategoryDataFromParams(params) {
    var categories = getCategoriesFromParams(params);
    var categoryData = [];
    $("input[name='category']").each(function(i,checkboxElt) {
        if (categories.indexOf(checkboxElt.value) >= 0) {
            categoryData.push({"label":checkboxElt.value, "displaytext":checkboxElt.parentElement.innerText});
        }
    });
    return categoryData;
}

function getCategoriesFromParams(params) {
    var catString = params.category;
    catString = catString.replace(/^"(.*)"$/, "$1");
    return catString.split(/","/);
}

function populateTextFields(params, names) {
    var searchForm = document.forms.rnform;
    for (var i = 0; i < names.length; i++) {
        var fieldName = names[i];
        searchForm[fieldName].value = params[fieldName] ? params[fieldName] : "";
    }
}

function populateReleaseFields(params) {
    findSelectedReleases(params);
    var searchForm = document.forms.rnform;
    populateReleaseOptions(searchForm.startrelease, params.startrelease);
    populateReleaseOptions(searchForm.endrelease, params.endrelease);
}

function findSelectedReleases(params) {
    if (!params.endrelease) {
        params.endrelease = allRnReleases[allRnReleases.length-1];
    }
    
    if (!params.startrelease) {
        if (params.searchHighlight) {
            params.startrelease = allRnReleases[0];
        } else {
            var endindex = allRnReleases.indexOf(params.endrelease);
            var startindex = Math.max(0,endindex - 6);
            params.startrelease = allRnReleases[startindex];
        }
    }
}

function populateReleaseOptions(selectElt, selectedValue) {
    var found = false;
    for (var i = allRnReleases.length-1; i >= 0; i--) {
        var release = allRnReleases[i];
        var startOption = $("<option>").html(release);
        if (release === selectedValue) {
            startOption.attr("selected","selected");
            found = true;
        }
        $(selectElt).append(startOption);
    }
    
    if (!found) {
        $(selectElt).children().first().attr("selected","selected");
    }
}


/* Used only in Lucene implementation */
function getAllReleaseNotes(params) {
    var d1 = getReleaseNotes(params);
    var d2 = getProductUpdates();

    $.when(d1,d2).done(function (v1,v2) {
        addReleaseNotes(v1,v2);
    }).fail(function (jqXHR, textStatus, error) {
        if (d1.state() === 'rejected') {
            showAllNotesForReleases(params.releases);
        } else if (d2.state() === 'rejected') {
            $.when(d1).done(function (v1) {
                addReleaseNotes(v1);
            }).fail(function (jqXHR, textStatus, error) {
                showAllNotesForReleases(params.releases);
            });
        }
    });
}

/* Used only in Lucene implementation */
function getReleaseNotes(params) {
    $("#notes").empty();
    var deferred = $.Deferred(function() {});
    var services = {
        "messagechannel":"releasenotes",
        "requesthandler":"releasenotes://search",
        "webservice":getWebServiceUrl()
    }
    var errorhandler = function() {
        deferred.reject();
    }
    var successhandler = function(data) {
        deferred.resolve(data);
    }
    requestHelpService(params, services, successhandler, errorhandler);
    return deferred;
}

/* Used only in Lucene implementation */
function getWebServiceUrl() {
    var lang = getPageLanguage() || "en";

    var release = getDocReleaseFromSearchBox();
    if (typeof getDocRelease === 'function') {
        release = getDocRelease();
    }
    
    return "/help/search/releasenotes/doccenter/" + lang + "/" + release;
}

function getProductUpdates() {
    var deferred = $.Deferred(function() {});
    var params = {};
    var url = "/support/bugreports/updates/" + basecode;
    var services = {
        "messagechannel":"productupdates",
        "webservice":url
    }
    var errorhandler = function() {
        deferred.reject();
    }
    var successhandler = function(data) {
        deferred.resolve(data);
    }
    requestHelpService(params, services, successhandler, errorhandler);
    return deferred;
}

/* Used only in Lucene implementation */
function showAllNotesForReleases(releases) {
    var warning = '<div class="alert alert-warning" style="margin-top:10px">' +
        '<span class="alert_icon icon-alert-warning"></span>' +
        '<p>Could not retrieve release notes from server.</p>' +
        '</div>';
    $("#notes").append(warning);
    getRnPage(releases.split(",").reverse());
}

/* Used only in Lucene implementation */
function getRnPage(releases) {
    var onSuccess = function(data, release) {
        content = $(data).find("#doc_center_content");
        $("#notes").append(content.children());
    }
    var onComplete = function() {
        // No Op
    }
    
    getReleaseContent(releases, false, onSuccess, onComplete);
}

/* Used only in Lucene implementation */
function expandReleases(params) {
    var searchForm = document.forms.rnform;
    var startElt = searchForm.startrelease;
    var endElt = searchForm.endrelease;
    
    var selectedReleases = [startElt.options[startElt.selectedIndex].value, endElt.options[endElt.selectedIndex].value];
    selectedReleases.sort(); // Releases sort alphabetically just fine.
    var startIndex = allRnReleases.indexOf(selectedReleases[0]);
    var endIndex = allRnReleases.indexOf(selectedReleases[1])+1;
	params.releases = allRnReleases.slice(startIndex, endIndex).join(",");
}

/* Used only in Lucene implementation */
function addReleaseNotes(releaseNotes, productUpdates) {
    if (releaseNotes.filter) {
        populateReleaseFields(releaseNotes.filter);
        addReleaseRange(releaseNotes.filter);
    }
    storeHighlightExpand(document.forms.rnform.rntext.value, releaseNotes.highlightexpand);

    var totalNotes = 0;
	var notesDiv = $("#notes");
    var groups = releaseNotes.rngroups;
	for (var i = 0; i < groups.length; i++) {
		var groupObj = groups[i];
        var contentDiv = $('<div class="expandableContent"></div>');
        notesDiv.append(contentDiv);

		var hasContent = groupObj.notes || groupObj.rngroups;
        var expandedClass = hasContent ? "expanded" : "no_content expanded";
        var headerHtml = '<span id="' + groupObj.label + '" class="anchor_target"></span><div class="expand ' + expandedClass + '">' +
                         '<h2 id="' + groupObj.uniqueid + '">' + groupObj.label + '</h2>';
        var desc = groupObj.description ? groupObj.description : "&nbsp;";
        headerHtml += '<div class="doc_topic_desc">' + desc + '</div>';
        if (hasContent) {
            headerHtml += '<div class="switch"><a class="expandAllLink" href="javascript:void(0);"> expand all </a></div></div>';
            if (productUpdates) {
                var productUpdatesForRelease = productUpdates[groupObj.label];
                if (productUpdatesForRelease) {
                    var productUpdateMarkup = getProductUpdateMarkup(productUpdatesForRelease);
                    if (productUpdateMarkup && productUpdateMarkup.length > 0) {
                        headerHtml += productUpdateMarkup;  
                    }
                }                
            }
        }
		
        contentDiv.append(headerHtml);
        if (groupObj.notes) {
            var collapseDiv = $('<div class="collapse" style="display:block;"></div>');
            appendNotes(collapseDiv, groupObj.notes);
            contentDiv.append(collapseDiv);
            totalNotes += groupObj.notes.length;
		}
		
        var subGroups = groupObj.rngroups;
		if (subGroups) {
			for (var j = 0; j < subGroups.length; j++) {
				var subGroupObj = subGroups[j];
                collapseDiv = $('<div class="collapse" style="display:block;"></div>');
				collapseDiv.append('<h3 id="' + subGroupObj.uniqueid + '">' + subGroupObj.label + '</h3>');
                contentDiv.append(collapseDiv);
				appendNotes(collapseDiv, subGroupObj.notes);
                totalNotes += subGroupObj.notes.length;
			}
		}
	}
    
    $("#num-notes").html(totalNotes);
    $("#num-notes-container").show();
	
    var releases = Object.getOwnPropertyNames(releaseNotes.releases);
    
    var onSuccess = function(data, release) {
        var ids = releaseNotes.releases[release];
        handleRelease(data, ids, release);
    }
    
    var onComplete = function() {
        highlightJSHandler();
        applySearchHighlight();
        addSmoothScroll();
        expandCollapsedContent(true);
        if (registerMatlabCommandDialogAction && typeof registerMatlabCommandDialogAction === 'function') {
            /* Conditional is because the function is in web/, not shared/. */
            registerMatlabCommandDialogAction();
        }
    }
    
    getReleaseContent(releases, false, onSuccess, onComplete);
}

function getProductUpdateMarkup(productUpdatesForRelease) {
    if (productUpdatesForRelease) {
        const localizedText = getLocalizedText('bug_fixes', 'Bug Fixes');
        const updatesForRelease = [];
        const keys1 = Object.keys(productUpdatesForRelease);

        for (let ctr1 = 0; ctr1 < keys1.length; ctr1++) {
            let key1 = keys1[ctr1];
            let entry = productUpdatesForRelease[key1];

            let keys2 = Object.keys(entry);
            for (let ctr2 = 0; ctr2 < keys2.length; ctr2++) {
                // Filter out links to the Update Bug Fixes
                if (!keys2[ctr2].includes('Update')) {
                    const startIndex = entry[keys2[ctr2]].indexOf('fir');
                    const endIndex = entry[keys2[ctr2]].indexOf('&', startIndex);
                    const updatedUrl = entry[keys2[ctr2]].slice(0, startIndex) + entry[keys2[ctr2]].slice(endIndex + 1);
                    updatesForRelease.push({ "label": keys2[ctr2], "url": updatedUrl, "localizedtext": localizedText });
                }
            }
        }
        const compiledTmpl = JST['updatesTmpl']({ updates: updatesForRelease });
        return compiledTmpl;
    }
    return '';
}

JST['updatesTmpl'] = _.template(
       '<div class="collapse" style="display:block;">' +
       '<ul class="list-unstyled">' +
       '<% _.each(updates, function(update) { %>' +
         '<li><%= update.label %>: <a href="<%= update.url %>"><%= update.localizedtext %></a></li>' +
       '<% }); %>' +
       '</ul>' +
       '</div>'
);

/* Used only in Lucene implementation */
function getLocalizedText(l10nKey, defaultString) {
    var localizedString = defaultString;
    if (typeof getLocalizedString !== "undefined") {
        localizedString = getLocalizedString(l10nKey);
    } 
    return localizedString;
}

/* Used in Saxon-JS and Lucene implementations */
function storeHighlightExpand(searchTerm, highlightExpand) {
    if (searchTerm && highlightExpand) {
        if (localStorage && localStorage.setItem) {
            localStorage.setItem(searchTerm, JSON.stringify(highlightExpand));    
        }
    }
}

/* Used only in Lucene implementation */
function getLocaleSuffix() {
    var localeRegexp = /release-notes(_.*)\.html/;
    var localeMatch = localeRegexp.exec(window.location.pathname);
    if (localeMatch) {
        return localeMatch[1];
    } else {
        return "";
    }
}

// Retrieve the content for each release to display.
//   releases: an array containing all of the releases to retrieve.
//   fallback: a boolean indicating whether to fall back to English (used for installed
//             translated doc only.
//   onSuccess: a function called each time a release's content is retrieved.
//   onComplete: a function called when all release not content has been retrieved.
function getReleaseContent(releases, fallback, onSuccess, onComplete) {
    if (releases.length === 0) {
        onComplete();
        return;
    }
    
    var release = releases[0];
    var localeSuffix = fallback ? "" : window.rnLocaleSuffix;
    var url = "release-notes-" + release + localeSuffix + ".html";
    var jqxhr = $.get(url);
    jqxhr.done(function(data) {
        onSuccess(data, release);
        releases.shift();
        getReleaseContent(releases, false, onSuccess, onComplete);
    });
    jqxhr.fail(function() {
        if (localeSuffix.length > 0) {
            // Attempt to fall back to English.
            getReleaseContent(releases, true, onSuccess, onComplete);
        } else {
            releases.shift();
            getReleaseContent(releases, false, onSuccess, onComplete);
        }
    });
}

/* Used only in Lucene implementation */
function appendNotes(contentDiv, notes) {
    // Check if URL includes a hash, if not then expand first note for each category/release
    const url = new URL(window.location.href);
    const expandFirstNote = !url.hash;

    // Do not expand the Check Bug Reports for Qualified Products section
    if (!notes[0].id.includes('CBRQP')) {
        createExpandableContent(contentDiv, notes[0], expandFirstNote ? 'expand expanded' : 'expand', expandFirstNote, true);
    } else {
        createExpandableContent(contentDiv, notes[0], 'expand', false, false, false);
    }

    for (let i = 1; i < notes.length; i++) {
        const note = notes[i];
        createExpandableContent(contentDiv, note, 'expand', false, true);
    }
}

function createExpandableContent(contentDiv, note, expandClass, expandFirstNote, shareContent) {
    const containerDiv = $(`<div class="expandableContent" id="container-${note.id}"></div>`);
    const expandDiv = $(`<div class="${expandClass}"></div>`);
    const titleDiv = $(`<h4 id="${note.id}">${note.title}</h4>`);
    let collapseDiv = $(`<div class="collapse" id="content-${note.id}"></div>`);
    const shareLink = $(`<a href="javascript:void(0)" class="share_link" data-bs-toggle="tooltip" data-bs-trigger="focus" title="Copy link to clipboard" data-original-title="Link Copied!"><span class="icon-link icon_16"><span class="visually-hidden">Share</span></span></a>`);

    if (expandFirstNote) {
        collapseDiv = $(`<div class="collapse" style="display: block;" id="content-${note.id}"></div>`);
    }

    expandDiv.append(titleDiv);
    containerDiv.append(expandDiv, collapseDiv);
    if (shareContent) {
        collapseDiv.append(shareLink);
    }
    contentDiv.append(containerDiv);

    // Attach event listener to the shareLink element
    shareLink.on('click', function () {
        getShareLink(this,'note');
    });
}


/* Used only in Lucene implementation */
function handleRelease(data, ids, release) {
	var rn = $(data);
	for (var i = 0; i < ids.length; i++) {
		var id = ids[i];
		var noteContents = rn.find("#" + id).parent().next();
        if (noteContents && noteContents.length > 0) {
            $("#content-" + id).append(noteContents[0].innerHTML);
        }
	}
}

/* Used only in Lucene implementation */
function addReleaseRange(params) {
    $('#start-release').html(params.startrelease);
    $('#end-release').html(params.endrelease);
}

function addNuggets(params, context) {

    const nuggetsDiv = $("#nugget-container");
    let numNuggets = 0;

    // Saxon is going to manage the category selections, so handle that context here to avoid duplicating
    if (context !== 'categories') {
       
       if (params.rntype) {
        if (hasRntype(params,"incompatibility")) {
            nuggetsDiv.show();
            $('#nugget-incompat').show();
            $('#nugget-incompat').on("click", function () { removeTypes("incompatibility"); });
            numNuggets++;
        }

        if (hasRntype(params,"highlight")) {
            nuggetsDiv.show();
            $('#nugget-highlight').show();
            $('#nugget-highlight').on("click", function () { removeTypes("highlight"); });
            numNuggets++;
            }
            }

        if (params.rntext && params.rntext.length > 0) {
            addNugget(params.rntext, "rntext", removeText);
            numNuggets++;
        }
    }

    if (params.category) {
        var categories = getCategoryDataFromParams(params);
        for (var i = 0; i < categories.length; i++) {
            var category = categories[i];
            addNugget(category.displaytext, category.label, removeCategory);
            numNuggets++;
        }
    }

    if (numNuggets > 1) {
        var nuggetSpan = nuggetsDiv.find("span[class='nuggets']");
        var removeAllSpan = $('<span class="nugget nugget_remove_all"><a href="javascript:void(0);"><span class="label">Remove All</span></a></span>');
        removeAllSpan.on("click", removeAllNuggets);
        nuggetSpan.append(removeAllSpan);
    }

}

// Helper function to check if params.rntype includes a given type
 function hasRntype(params, type) {
    // Ensure params.rntype is treated as a string and check if it contains the 'type' value
    var rntypeStr = String(params.rntype).toLowerCase(); // Convert to string and to lower case for case-insensitive comparison
    var typeStr = type.toLowerCase(); // Also lower case the type for case-insensitive comparison

    // Check if the type string is contained within the rntype string
    // This approach is valid so long as params.rntype is a string of values
    return rntypeStr.includes(typeStr);
}

function addNugget(displayText, label, removeFcn) {
    var nuggetsDiv = $("#nugget-container");
    if (nuggetsDiv.find("span.label#" + label).length > 0) {
        // A nugget with this label already exists, so don't create a new one
        return;
    }
    nuggetsDiv.show();
    var nuggetSpan = nuggetsDiv.find("span[class='nuggets']");
    var newSpan = $('<span class="nugget"></span>');
    var newNugget = $('<a href="javascript:void(0);" class="icon-remove"></a>');
    var labelSpan = $('<span class="label" id="' + label +'"></span>');
    labelSpan.append(document.createTextNode(displayText));
    newNugget.append(labelSpan);
    newNugget.on("click", {"label":label}, removeFcn);
    newSpan.append(newNugget);
    nuggetSpan.append(newSpan);
}

function removeCategory(event) {
	const selectedID = ( $( this).find('.label').attr('id') );
    const checkbox = $("input[name='category'][value='" + selectedID + "']");
    $(checkbox).prop("checked",false);
    document.forms.rnform.submit();
}

function removeTypes(typeToRemove) {
    // Get all elements with the name 'rntype'
    var rntypes = document.forms.rnform.rntype;
    // Iterate over the NodeList and uncheck if the value matches the typeToRemove
    for (var i = 0; i < rntypes.length; i++) {
        if (rntypes[i].value === typeToRemove) {
            rntypes[i].checked = false;
        }
    }
    document.forms.rnform.submit();
}

function removeText(event) {
    document.forms.rnform.rntext.value = "";
    document.forms.rnform.searchHighlight.value = "";
    document.forms.rnform.submit();
}

function removeAllNuggets(event) {
    const catCheckboxArr = $("input[name='category']");
    catCheckboxArr.each(function () {
        $(this).prop("checked", false);
    });
    const catTypeArr = $("input[name='rntype']");
    catTypeArr.each(function () {
        $(this).prop("checked", false);
    });
    const rnForm = document.forms.rnform;
    rnForm.rntext.value = "";
    rnForm.searchHighlight.value = "";
    rnForm.submit();
}

function getShareLink(shareLink,context) {
    const $shareLink = $(shareLink);
    $shareLink.tooltip();

    try {
        // Get the URL and remove any hash fragment
        const url = new URL(window.location.href);
        url.hash = '';
        const helpBrowserSessionStorageKey = sessionStorage.getItem("help_browser_container");
        let copyContent;

        if(context === 'note') {
            // Get the parent element's id and remove the 'content-' prefix to get the heading element id
            const parentId = shareLink.parentNode.id.replace('content-', '');
            copyContent = `${url.toString()}#${parentId}`;
            /* Append the heading id to the URL and copy it to the user's clipboard
            If the help browser session storage key exists, copy using a temporary input element (deprecated method, but necessary for support in CEF)
            Else, use the modern clipboard API approach */
        } else {
            copyContent = url.toString();
        }

        if (helpBrowserSessionStorageKey === null) {
            navigator.clipboard.writeText(copyContent);
        } else {
            // Create a temporary input element to hold the URL
            const tempInput = document.createElement('input');

            // Append the heading id to the URL
            tempInput.value = copyContent;

            // Append the temporary input to the document, select its content, and copy it to the clipboard
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand("copy");

            // Remove the temporary input from the document
            document.body.removeChild(tempInput);
        }

        // Bootstrap will reset the title attributes, so we override that here
        $shareLink.attr('data-original-title', "Link Copied!");

        // Show the tooltip after it has been initialized
        $shareLink.tooltip('show');

        $shareLink.attr('title', "Copy to clipboard");
    } catch (error) {
        console.error('An error occurred:', error);
    }
}

function findActiveProduct() {
    // Delay setting the container variable by 1 milliseconds to account for the active status switching
    setTimeout(() => {
        let activeTabPane = document.querySelector('.tab-pane.active');
        // Find the active li within the active tab-pane
        let activeLi = activeTabPane.querySelector('li.active');
        if (activeTabPane.id === "tab_doc_categories") {
            activeLi = activeTabPane.querySelector('#nav_siblings > li > ul > li.active');
        }
        if (activeLi) {
            // Scroll the active li into view
            activeLi.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'start' });
        }
    }, 1);
}

function toggleList(event) {
    event.preventDefault(); // Prevent default anchor action
    let listItem = event.target.nextElementSibling;

    // Hide any open nav lists, except the ones associated with the current product
    const allLists = document.querySelectorAll('li > ul');
    allLists.forEach(function (list) {
        if (list !== listItem && !list.querySelector('.active')) {
            list.style.display = 'none';
        }
    });

    // Toggle the display of the targeted list
    if (listItem.style.display === 'block') {
        listItem.style.display = 'none';
    } else {
        listItem.style.display = 'block';
    }
}

function updateButtonWithSelectedCategories() {
    // Maximum length for the button text
    const maxLength = 30;
    const checkboxes = document.querySelectorAll('#rn-category-group input[type="checkbox"]');
    let selectedCategories = [];

    checkboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            let label = checkbox.parentNode.textContent.trim();
            selectedCategories.push(label);
        }
    });

    let button = document.getElementById('dropdownMenu');
    let caretSpan = document.createElement('span');

    caretSpan.className = 'caret';

    // Update the button text. If no checkboxes are selected, show "Categories"
    if (selectedCategories.length > 0) {
        // Concatenate the selected categories into a string
        let buttonText = selectedCategories.join(', ');
        // Truncate the button text if it's too long
        if (buttonText.length > maxLength) {
            buttonText = buttonText.substr(0, maxLength - 3) + '...'; // Subtract 3 to account for the length of the ellipsis
            button.textContent = buttonText;
        } else {
            button.textContent = buttonText;
        }
    } else {
        button.textContent = 'Categories   ';
    }
    button.appendChild(caretSpan);
}

function highlightJSHandler() {
    // Check if RN contents have code to highlight
    if(document.querySelector('code[class^="language-"], code[class*=" language-"]')) {
        // Check if matlab_dialog_share is available
        if (typeof initHighlight === 'function') {
            initHighlight();
        }
      }
}

$(init);
