$(document).ready(function () {
    registerMatlabCommandDialogAction();
});

$(window).bind('examples_cards_added', function(e) {
  $('.mw_card a[href^="matlab:"]').off('click');
  registerMatlabCommandDialogAction();
});

function registerMatlabCommandDialogAction() {
  $('a[href^="matlab:"]').on('click', function (e) {
      e.preventDefault();
      var href = $(this).attr('href'),
      match = href.match(/matlab:(.*)/),
      matlabCommand = null;

      if (match) {
        matlabCommand = match[1];
      }

      if (!isFromMatlabOnline()) {
        handleDialog(matlabCommand);
      }
  });
}

function handleDialog(matlabCommand) {
  if (matlabCommand) {
    $("#matlab-command-dialog #dialog-body #dialog-matlab-command").text(matlabCommand);
  } else {
    $("#matlab-command-dialog #dialog-body #dialog-matlab-command").hide();
  }
  $("#matlab-command-dialog").modal();
}

function isFromMatlabOnline() {
   var cookieRegexp = /MW_Doc_Template="?([^;"]*)/;
   var cookies = document.cookie;
   var matches = cookieRegexp.exec(cookies);
   if (matches != null && matches.length > 0) {
       var docCookie = matches[1];
       var parts = docCookie.split(/\|\|/);
       if (parts[0].indexOf("ONLINE") !== -1) {
           return true;
       }
   } 
   return false;
}