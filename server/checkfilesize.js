function checkFilesize(fileSize, itemName, alertText, browserSupportText) {
    if (window.File && window.FileReader && window.FileList && window.Blob) {
        var fsize = $(itemName)[0].files[0].size;
        if (fsize > fileSize) {
           alert(alertText + "\n" + Math.round(fsize / 1024) + " kb");
           $(itemName).val("");
        }
    } else {
        alert(browserSupportText);
    }
}