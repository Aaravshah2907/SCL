$(document).ready( function() {
    /* Windows load */
    $(window).on("load", function() {
        if (typeof showMotwMessageBar === 'function') {
            requestMotwMessageBar(); 
        }
    });
});

function requestMotwMessageBar(){
    var docTemplateCookie = readCookie("MW_Doc_Template");
    if (docTemplateCookie !== null && docTemplateCookie.indexOf('ONLINE') !== -1) {
        checkMotwSupport();
    }
} 

function checkMotwSupport() {
    var jsonLd = document.querySelectorAll('script[type="application/ld+json"]');
    for (let item of jsonLd) {
        try {
            var jsonLdData = JSON.parse(item.innerText);
            if (jsonLdData && jsonLdData.name && jsonLdData.name === 'UISupport' && jsonLdData.value && jsonLdData.value === 'Desktop') {
                showMotwMessageBar({'before_link': "This functionality is not supported in MATLAB Online (see ",
                                    'link': "details",
                                    'after_link': ")."});
                return;
            }
        } catch (e) {
            // Do nothing.
        }
    };
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function getMotwMessageBarInfo(messagebarText) {
    var htmlContent =  '<div id="message_bar" class="alert alert-info alert-dismissible fade in" role="alert" style="display:none;">' +
        '<div class="messagebar_info"></div>' +
        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">' +
            '<span aria-hidden="true">×</span>' +
        '</button> ' +
        messagebarText.before_link + '<a href="https://www.mathworks.com/products/matlab-online/limitations.html" target="_blank" id="message_bar_title"> ' + messagebarText.link + '</a>' + messagebarText.after_link
    '</div>';

    return htmlContent;
}

function showMotwMessageBar(messagebarText) {
    var messagebarVisible = localStorage.getItem('motwmessagebar');
    if (messagebarVisible !== 'hide') {        
        var messagebar = getMotwMessageBarInfo(messagebarText);
        if ($('#message_bar').length) {
                
        } else {
            $('.sticky_header_container').addClass("messagebar_active"); // fix the left nav breadcrumb scroll fixed top
            $('.sticky_header_container').prepend(messagebar);
            $("#message_bar").show();   
            $(window).trigger('content_resize'); // fix the scroll
            $('div#message_bar').on('close.bs.alert', function () {
                //
                localStorage.setItem('motwmessagebar', 'hide');
                $('.sticky_header_container').removeClass("messagebar_active");  // fix the left nav breadcrumb scroll fixed top
                $(window).trigger('content_resize'); // fix the scroll
            });
        }
    }   
}