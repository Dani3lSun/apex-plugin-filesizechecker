#Oracle APEX DynamicAction Plugin - Filesize Checker
This plugin checks/validates the max size of an file input field. The validation is handled on client side via Javascript.
If the input file is greater than max. allowed size a Javascript alert is thrown and the file item is cleared.

##Changelog
####1.1 - Added different alert types (simple JS alert and Apex dialog)
####1.0 - Initial Release

##Install
- Import plugin file "dynamic_action_plugin_de_danielh_filesizechecker.sql" from source directory into your application
- (Optional) Deploy the CSS/JS file from "server" directory on your webserver and change the "File Prefix" to webservers folder.

##Plugin Settings
The plugin settings are highly customizable and you can change:
- Max size (in byte) - Maximum allowed size of a file in Byte. Default is 1MB (1048576 bytes)
- File Input Item - Choose the file input item for this action
- Alert text - Alert text if the file size is greater than allowed max. size
- Alert Text (no Browser Support) - Alert text if the browser doesn´t support this feature.

## How to use
Create a new Dynamic Action with event "on change" on your file input item. As action choose "Filesize Checker".

##Demo Application
https://apex.oracle.com/pls/apex/f?p=57743:12

##Preview
![](https://github.com/Dani3lSun/apex-plugin-filesizechecker/blob/master/preview.png)
---
