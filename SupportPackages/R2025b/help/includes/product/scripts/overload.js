$(document).ready( function() {
    /** 
     * Remove window load event listener as this is causing a sporadic issue where overload will not be displayed.
     * This fix is proposed over here: g3419263.
    */ 
    if (typeof requestHttpOverloadCommand === 'function') {
        requestHttpOverloadCommand(); 
    }
});

function requestHttpOverloadCommand(){
    if($.getParameterByName("overload")) {
        var overloadCommand = $.getParameterByName("overload");

        var overloadRegex = /^(.*)[\s+](true|false)$/;
        var commandMatch = overloadCommand.match(overloadRegex);

        if (commandMatch.length <= 1) {
            return;
        }
        var helpTopic = commandMatch[1];

        getOverloadData().then(function(data) {
            findOverloads(helpTopic, data);
        });
    }
}

//===============================================================================
////==================overload page templates======================================

window.JST = window.JST || {};

// Overload function message bar
JST['messagebar'] = _.template(
    '<div id="message_bar" class="alert alert-info alert-dismissible fade show" role="alert" style="display:none;">' +
        '<div class="messagebar_info"></div>' +
        // Suppressing the padding here as bootstrap.min.css is adding a padding of 1.5rem 1rem, which is causing the button to overflow.
        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding:5px 15px;">' +
        '</button>' +
        '<a href="#" id="overload_message_bar_title" data-bs-toggle="modal" data-bs-target="#helpcenter-overload-function-dialog"><%= linktext %></a>' +
    '</div>'
);

// Modal Dialog with overload function list body
JST['overloaddialog'] = _.template(
    '<div class="modal fade" id="helpcenter-overload-function-dialog" tabindex="-1" role="dialog" aria-labelledby="helpcenterOverloadFunctionDialog">' +
        '<div class="modal-dialog modal-lg" role="document">' +
            '<div class="modal-content">' +
                '<div class="modal-header">' +
                    '<h3 class="overload-dialog-title modal-title" id="helpcenterOverloadFunctionDialog" style="color:#C45400"><%= overloadData.title %></h3>' +
                    '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                '</div>' +
                '<div class="modal-body">' +
                    '<pre id="dialog-overload">' +
                        '<% _.each(overloadData.products, function(product) { %>' +
                            '<p style="font-weight:bold; font-size:11px;"><%= product.name %></p>' +
                            '<ul class="list-unstyled" style="margin-bottom:0px;">' +
                                '<% _.each(product.overloads, function(overload, i) { %>' +
                                '<li class="overload_func" style="margin-left: 25px; font-size:12px;">' +
                                    '<% var parameterSeparator = overload.Path.indexOf("?") !== -1 ? "&" : "?"; %>' +
                                    '<span class="icon-<%= getEntityTypeIconClass(overload.Type)%> icon_16" style="padding-right:4px;"></span>' +
                                    '<a class="overload_func_link" href="<%= overload.fullPath %>">' +
                                      '<%= overloadData.topic %>' +
                                    '</a>' +
                                    '<span> - <%= overload.Purpose %></span>' +
                                '</li>' +
                                '<% }) %>' +
                            '</ul>' +
                        '<% }) %>' +
                    '</pre>' +
                '</div>' +
                '<div class="modal-footer">' +
                    '<button type="button" class="btn btn-default" data-bs-dismiss="modal" data-test-id="overload-close-button">CLOSE</button>' +
                '</div>' +
            '</div>' +
        '</div>' +
    '</div>'
);

function getOverloadData() {
    const url = findDocRoot() + '/overloads/overloads.json';
    return fetch(url).then(function (response) {
        if (response.ok) {
            return response.json();
        } else {
            return {};
        }
    });
}

function findDocRoot() {
    var docRootMatches = document.location.href.match(/^.*\/help(\/releases\/R20\d\d[ab])?(\/prereleases\/R20\d\d[ab])?/);
    return docRootMatches.length > 0 ? docRootMatches[0] : "/help";
}

function findOverloads(helpTopic, data) {
    const topicEntry = data.find(item => item.name === helpTopic);
    if (topicEntry) {
        groupOverloads(topicEntry);
    }
}

function groupOverloads(topicEntry) {
    const products = [];
    const docroot = findDocRoot();
    for (let overload of topicEntry.refitems) {
        overload.fullPath = docroot + '/' + overload.HelpLocation + '/' + overload.Path;
        
        let product = products.find(product => product.name === overload.ProductName);
        if (product) {
            product.overloads.push(overload);
        } else {
            products.push({
                'name' : overload.ProductName,
                'overloads' : [overload]
            });
        }
    }
    
    products.sort(compareProducts);
    const title = getLocalizedString('overloads_title').replace(/\{0\}/, topicEntry.name);
    const otheruses = getLocalizedString('overloads_other_uses').replace(/\{0\}/, topicEntry.name);
    const overloadData = {
        'topic' : topicEntry.name,
        'other_uses' : otheruses,
        'title' : title,
        'products' : products
    };
    populateOverloadStrings(overloadData);
}

function compareProducts(prod1, prod2) {
    let name1 = prod1.name;
    let name2 = prod2.name;
    if (name1 === 'MATLAB' || name1 === 'Simulink') {
        name1 = '0_' + name1;
    }
    if (name2 === 'MATLAB' || name2 === 'Simulink') {
        name2 = '0_' + name2;
    }
    return name1.localeCompare(name2);
}

function getOverloadFunctionsListHtml(overloadFunctionsJson) {
    var jsonData = {overloadData: overloadFunctionsJson};
    return JST['overloaddialog'](jsonData);
}

function getOverloadMessageBarInfo(overloadFunctionsJson) {
    var jsonData = {linktext: overloadFunctionsJson.other_uses};
    return JST['messagebar'](jsonData);
}

function storeMessagebarStatus() {
    sessionStorage.setItem('overloadmessagebar', 'hide');
}

function loadMessagebarStatus() {
    return sessionStorage.getItem('overloadmessagebar');
}

function getEntityTypeIconClass(type) {
    switch (type) {
        case "function" :
        case "method" :
        case "class" : return "function";
        case "block" : return "block";
        case "sysobj" : return "systemobject";
        case "app" : return "app";
        default : return "function";
    }
}

function populateOverloadStrings(overloadData) {
    var messagebarVisible = loadMessagebarStatus();
    if (overloadData !== 'undefined' && overloadData !== null && messagebarVisible !== 'hide') {        
        var messagebar = getOverloadMessageBarInfo(overloadData);
        if ($('#message_bar').length === 0) {
            /**
             * This sticky_header_container class is now only available in installed doc. web doc has localnav 
             * Thus any changes to the content of messagebar will only be available in installed doc.
             * Docrunner will handle the overload messagebar in web doc. Docrunner geck: g3549275
            */
            $('.sticky_header_container').addClass("messagebar_active"); // fix the left nav breadcrumb scroll fixed top
            $('.sticky_header_container').prepend(messagebar);
            $("#message_bar").show();   
            $(window).trigger('content_resize'); // fix the scroll
            $('div#message_bar').on('close.bs.alert', function () {
                //
                storeMessagebarStatus();
                $('.sticky_header_container').removeClass("messagebar_active");  // fix the left nav breadcrumb scroll fixed top
                $(window).trigger('content_resize'); // fix the scroll
            });
        }

        var  html = getOverloadFunctionsListHtml(overloadData);
        $('#responsive_offcanvas').prepend(html);
    }   
}