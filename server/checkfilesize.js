function checkFilesize(fileSize, itemName, alertText, alertType, browserSupportText) {
    if (window.File && window.FileReader && window.FileList && window.Blob) {
        var fsize = $(itemName)[0].files[0].size;
        if (fsize > fileSize) {
           if (alertType == "dialog") {
             var warnText = alertText + " - " + Math.round(fsize / 1024) + " KB" + " - max. allowed: " + Math.round(fileSize / 1024) + " KB";
             $('<div class="my_warn_message">' + warnText + '</div>').dialog(
              { autoOpen   : true,
                title      : 'Warning',
                modal      : true,
                width      : 'auto',
                buttons    : [ {  text:'OK', class:'my_dialog_button', click: function() { $(this).dialog('close'); } } ] 
              }
             );
           } else {
             alert(alertText + "\n" + Math.round(fsize / 1024) + " KB" + "\n" + "max. allowed: " + Math.round(fileSize / 1024) + " KB");
           }
           $(itemName).val("");
        }
    } else {
        alert(browserSupportText);
    }
}