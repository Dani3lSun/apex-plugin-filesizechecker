/*-------------------------------------
 * Filesize checker JS functions
 * Version: 1.1 (17.10.2015)
 * Author:  Daniel Hochleitner
 *-------------------------------------
*/
FUNCTION render_filesizechecker(p_dynamic_action IN apex_plugin.t_dynamic_action,
                                p_plugin         IN apex_plugin.t_plugin)
  RETURN apex_plugin.t_dynamic_action_render_result IS
  --
  -- plugin attributes
  l_result               apex_plugin.t_dynamic_action_render_result;
  l_max_size             NUMBER := p_dynamic_action.attribute_01;
  l_file_item            VARCHAR2(100) := p_dynamic_action.attribute_02;
  l_alert_text           VARCHAR2(100) := p_dynamic_action.attribute_03;
  l_browser_support_text VARCHAR2(400) := p_dynamic_action.attribute_04;
  l_alert_type           VARCHAR2(100) := p_dynamic_action.attribute_05;
  -- other vars
  l_js_string VARCHAR2(2000);
  --
BEGIN
  -- Debug
  IF apex_application.g_debug THEN
    apex_plugin_util.debug_dynamic_action(p_plugin         => p_plugin,
                                          p_dynamic_action => p_dynamic_action);
  END IF;
  --
  -- add js & css
  apex_javascript.add_library(p_name           => 'checkfilesize',
                              p_directory      => p_plugin.file_prefix,
                              p_version        => NULL,
                              p_skip_extension => FALSE);
  --
  apex_css.add_file(p_name      => 'checkfilesize',
                    p_directory => p_plugin.file_prefix);
  --
  -- replace special chars
  l_alert_text           := REPLACE(apex_escape.html(l_alert_text),
                                    ',');
  l_browser_support_text := REPLACE(apex_escape.html(l_browser_support_text),
                                    ',');
  --
  -- build js string
  l_js_string := 'checkFilesize(' || l_max_size || ', ''#' || l_file_item ||
                 ''', ''' || l_alert_text || ''', ''' || l_alert_type ||
                 ''', ''' || l_browser_support_text || ''');';
  --
  l_result.javascript_function := 'function(){' || l_js_string || '}';
  --
  RETURN l_result;
  --
END render_filesizechecker;