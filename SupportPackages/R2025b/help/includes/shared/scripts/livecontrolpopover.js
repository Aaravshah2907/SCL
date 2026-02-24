/**
 * Initializes interactive popovers for live script control examples on the page. 
 * Handles different use cases like web docs vs. installed (system and help) browser and matlabmobile.
 * Populates popover content dynamically based on environment.
 * Registers event handlers to open examples on popover click.
 * Leverages the inSystemBrowser and callOW functions from matlab_dialog_shared
*/
$(function () {

    function initPopovers() {
        const currentUrl = window.location.href;
        const examplesShortList = document.getElementsByClassName("examples_short_list");
        let exampleProductBaseCodes;
        // Don't produce array of base codes if example_short_list does not exist
        if (examplesShortList[0] && examplesShortList[0].getAttribute("data-products")) {
            exampleProductBaseCodes = examplesShortList[0].getAttribute("data-products").split(' ');
        }

        $('[data-bs-toggle="popover"]').each(function () {
            // The Copy Affordance buttons are also use popover data-bs-toggles, adding this check to avoid conflicts
            if ($(this).data('examplename')) {
                const $el = $(this);
                const cmd = $el.data('examplename');
                const systemBrowser = inSystemBrowser();
                let content;

                // Confirm we are not in System Browser or on a matlabmobile page
                if (!systemBrowser && !currentUrl.includes('matlabmobile')) {
                    // Check if Open With available (Web Doc Use Case)
                    if (window.ow) {
                        // Check if current product is supported by OpenWith
                        callOW(exampleProductBaseCodes, ow.isProductSupported).then(function (supportData) {
                            if (!supportData) {
                                content = `open the example in MATLAB`
                                populatePopover($el, content)
                            } else {
                                content = `<a href="matlab:${cmd}">try it in your browser</a>`;
                                populatePopover($el, content)
                                let openWithCommand = null;
                                let match = cmd.match(/openExample\('(.*)'\)/);
                                if (match) {
                                    openWithCommand = match[1];
                                }

                                $(window).on('shown.bs.popover', function (eventShown) {
                                    let $popup = $('#' + $(eventShown.target).attr('aria-describedby'));
                                    $popup.find('a').click(function (e) {
                                        e.preventDefault();
                                        ow.startOpenWith(openWithCommand);
                                        ow.loadExample(openWithCommand);
                                    });
                                })
                            }
                        })

                    }
                    // Installed Doc CEF Help Browser, so Open in MATLAB 
                    else {
                        content = `<a class="no-matlab" href="matlab:${cmd}">open the live script</a>`;
                        populatePopover($el, content)
                    }
                } else {
                    content = `open the example in MATLAB`
                    populatePopover($el, content)
                }
            }
        });

    }

    /**
     * Populate a Bootstrap popover on the given element with the provided content.
     * 
     * @param {jQuery} element - Element to attach the popover to.
     * @param {string} content - HTML content for the popover.
     */
    function populatePopover(element, content) {
        element.popover({
            sanitize: false,
            title: 'Interactive Control',
            content: `<span>In live scripts, controls like this one let you set the value of a variable interactively. To use the controls in this example, ${content}.</span>`
        })
    }

    // Init popovers on load and when added  
    initPopovers();

    $(window).on('popover_added', initPopovers);

});