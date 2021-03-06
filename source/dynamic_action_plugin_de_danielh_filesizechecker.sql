set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.2.00.06'
,p_default_workspace_id=>96713923238010156
,p_default_application_id=>57743
,p_default_owner=>'DHTEST'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/de_danielh_filesizechecker
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(14836131378023040163)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'DE.DANIELH.FILESIZECHECKER'
,p_display_name=>'Filesize Checker'
,p_category=>'INIT'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'/*-------------------------------------',
' * Filesize checker JS functions',
' * Version: 1.1 (17.10.2015)',
' * Author:  Daniel Hochleitner',
' *-------------------------------------',
'*/',
'FUNCTION render_filesizechecker(p_dynamic_action IN apex_plugin.t_dynamic_action,',
'                                p_plugin         IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_dynamic_action_render_result IS',
'  --',
'  -- plugin attributes',
'  l_result               apex_plugin.t_dynamic_action_render_result;',
'  l_max_size             NUMBER := p_dynamic_action.attribute_01;',
'  l_file_item            VARCHAR2(100) := p_dynamic_action.attribute_02;',
'  l_alert_text           VARCHAR2(100) := p_dynamic_action.attribute_03;',
'  l_browser_support_text VARCHAR2(400) := p_dynamic_action.attribute_04;',
'  l_alert_type           VARCHAR2(100) := p_dynamic_action.attribute_05;',
'  -- other vars',
'  l_js_string VARCHAR2(2000);',
'  --',
'BEGIN',
'  -- Debug',
'  IF apex_application.g_debug THEN',
'    apex_plugin_util.debug_dynamic_action(p_plugin         => p_plugin,',
'                                          p_dynamic_action => p_dynamic_action);',
'  END IF;',
'  --',
'  -- add js & css',
'  apex_javascript.add_library(p_name           => ''checkfilesize'',',
'                              p_directory      => p_plugin.file_prefix,',
'                              p_version        => NULL,',
'                              p_skip_extension => FALSE);',
'  --',
'  apex_css.add_file(p_name      => ''checkfilesize'',',
'                    p_directory => p_plugin.file_prefix);',
'  --',
'  -- replace special chars',
'  l_alert_text           := REPLACE(apex_escape.html(l_alert_text),',
'                                    '','');',
'  l_browser_support_text := REPLACE(apex_escape.html(l_browser_support_text),',
'                                    '','');',
'  --',
'  -- build js string',
'  l_js_string := ''checkFilesize('' || l_max_size || '', ''''#'' || l_file_item ||',
'                 '''''', '''''' || l_alert_text || '''''', '''''' || l_alert_type ||',
'                 '''''', '''''' || l_browser_support_text || '''''');'';',
'  --',
'  l_result.javascript_function := ''function(){'' || l_js_string || ''}'';',
'  --',
'  RETURN l_result;',
'  --',
'END render_filesizechecker;'))
,p_render_function=>'render_filesizechecker'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'This plugin checks/validates the max size of an file input field.',
'The validation is handled on client side via Javascript.'))
,p_version_identifier=>'1.1'
,p_about_url=>'https://github.com/Dani3lSun/apex-plugin-filesizechecker'
,p_files_version=>203
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(14836132055474062789)
,p_plugin_id=>wwv_flow_api.id(14836131378023040163)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Max size (in byte)'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'1048576'
,p_is_translatable=>false
,p_help_text=>'Maximum allowed size of a file in Byte. Default is 1MB (1048576 bytes).'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(14836132300985065977)
,p_plugin_id=>wwv_flow_api.id(14836131378023040163)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'File Input Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Choose the file input item for this action.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(14836137442827193060)
,p_plugin_id=>wwv_flow_api.id(14836131378023040163)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Alert text'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'File is too big!'
,p_is_translatable=>false
,p_help_text=>'Alert text if the file size is greater than allowed max. size.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(14836132637825093181)
,p_plugin_id=>wwv_flow_api.id(14836131378023040163)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Alert Text (no Browser Support)'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'Please upgrade your browser because your current browser lacks some new features we need!'
,p_is_translatable=>false
,p_help_text=>'Alert text if the browser doesn´t support this feature.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(14922200671268604010)
,p_plugin_id=>wwv_flow_api.id(14836131378023040163)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>35
,p_prompt=>'Alert type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'alert'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Choose the type of the alert. Either a simple Javascript alert or a Apex 5 dialog window.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(14922202085730605465)
,p_plugin_attribute_id=>wwv_flow_api.id(14922200671268604010)
,p_display_sequence=>10
,p_display_value=>'Javascript Alert'
,p_return_value=>'alert'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(14922214197426608697)
,p_plugin_attribute_id=>wwv_flow_api.id(14922200671268604010)
,p_display_sequence=>20
,p_display_value=>'Apex 5 Dialog'
,p_return_value=>'dialog'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E20636865636B46696C6573697A652866696C6553697A652C206974656D4E616D652C20616C657274546578742C20616C657274547970652C2062726F77736572537570706F72745465787429207B0A202020206966202877696E646F';
wwv_flow_api.g_varchar2_table(2) := '772E46696C652026262077696E646F772E46696C655265616465722026262077696E646F772E46696C654C6973742026262077696E646F772E426C6F6229207B0A2020202020202020766172206673697A65203D2024286974656D4E616D65295B305D2E';
wwv_flow_api.g_varchar2_table(3) := '66696C65735B305D2E73697A653B0A2020202020202020696620286673697A65203E2066696C6553697A6529207B0A202020202020202020202069662028616C65727454797065203D3D20226469616C6F672229207B0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(4) := '766172207761726E54657874203D20616C65727454657874202B2022202D2022202B204D6174682E726F756E64286673697A65202F203130323429202B2022204B4222202B2022202D206D61782E20616C6C6F7765643A2022202B204D6174682E726F75';
wwv_flow_api.g_varchar2_table(5) := '6E642866696C6553697A65202F203130323429202B2022204B42223B0A202020202020202020202020202428273C64697620636C6173733D226D795F7761726E5F6D657373616765223E27202B207761726E54657874202B20273C2F6469763E27292E64';
wwv_flow_api.g_varchar2_table(6) := '69616C6F67280A20202020202020202020202020207B206175746F4F70656E2020203A20747275652C0A202020202020202020202020202020207469746C652020202020203A20275761726E696E67272C0A202020202020202020202020202020206D6F';
wwv_flow_api.g_varchar2_table(7) := '64616C2020202020203A20747275652C0A2020202020202020202020202020202077696474682020202020203A20276175746F272C0A20202020202020202020202020202020627574746F6E73202020203A205B207B2020746578743A274F4B272C2063';
wwv_flow_api.g_varchar2_table(8) := '6C6173733A276D795F6469616C6F675F627574746F6E272C20636C69636B3A2066756E6374696F6E2829207B20242874686973292E6469616C6F672827636C6F736527293B207D207D205D200A20202020202020202020202020207D0A20202020202020';
wwv_flow_api.g_varchar2_table(9) := '202020202020293B0A20202020202020202020207D20656C7365207B0A20202020202020202020202020616C65727428616C65727454657874202B20225C6E22202B204D6174682E726F756E64286673697A65202F203130323429202B2022204B422220';
wwv_flow_api.g_varchar2_table(10) := '2B20225C6E22202B20226D61782E20616C6C6F7765643A2022202B204D6174682E726F756E642866696C6553697A65202F203130323429202B2022204B4222293B0A20202020202020202020207D0A202020202020202020202024286974656D4E616D65';
wwv_flow_api.g_varchar2_table(11) := '292E76616C282222293B0A20202020202020207D0A202020207D20656C7365207B0A2020202020202020616C6572742862726F77736572537570706F727454657874293B0A202020207D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(14722375485510437160)
,p_plugin_id=>wwv_flow_api.id(14836131378023040163)
,p_file_name=>'checkfilesize.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6D795F7761726E5F6D657373616765207B2070616464696E673A20313570782021696D706F7274616E743B207D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(14922249614356635382)
,p_plugin_id=>wwv_flow_api.id(14836131378023040163)
,p_file_name=>'checkfilesize.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
