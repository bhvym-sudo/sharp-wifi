<%SendWebHeadStr(); %>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<SCRIPT>
//var wlan1Disabled = 0, wlan2Disabled = 0;
var role=<% getInfo("multi_ap_controller"); %>;
function wpsTrigger(obj)
{
 obj.isclick = 1;
 postTableEncrypt(document.forms[0].postSecurityFlag, document.forms[0]);
    return true;
}
function loadInfo()
{
 //wlan1Disabled = <% getIndex("interface_info_query_00"); %>;
 //wlan2Disabled = <% getIndex("interface_info_query_10"); %>;
 //load role from mib and set radio button accordingly
 if (role == 0) {
  document.getElementById("role_disabled").checked = true;
 } else if (role == 1) {
  document.getElementById("role_controller").checked = true;
  document.getElementById("wsc_trigger").innerHTML = '<th>'+'<% multilang("247" "LANG_WLAN_WPS_TRIGGER"); %>'+':</th><td><input type="submit" value="'+'<%multilang("227" "LANG_START_PBC"); %>'+'" class="link_bg" name="start_wsc" onClick="return wpsTrigger(this)"></td>';
 /*
	} else if (role == 2) {
		document.getElementById("role_agent").checked = true;
		document.getElementById("wsc_trigger").innerHTML   = '<th>'+'<% multilang(LANG_WLAN_WPS_TRIGGER); %>'+':</th><td><input type="submit" value="'+'<%multilang(LANG_START_PBC); %>'+'" class="link_bg" name="start_wsc" onClick="return wpsTrigger(this)"></td>';
	*/
 }
 //save role into prev_role
 if (role == 0) {
  document.getElementById("role_prev").value = "disabled";
 } else if (role == 1) {
  document.getElementById("role_prev").value = "controller";
 } /* else if (role == 2) {
		document.getElementById("role_prev").value = "agent";
	} */
}
function resetClick()
{
 location.reload(true);
}
function saveChanges(obj)
{
 if (!document.getElementById("role_disabled").checked) {
  if ("" == document.getElementById("device_name_text").value) {
   alert("<% multilang("250" "LANG_WLAN_EASY_MESH_DEVICE_NAME_CANNOT_BE_EMPTY"); %>");
   return false;
  }
 }
 var dot11kvDisabled = <% checkWrite("is_dot11kv_disabled"); %>;
 if (dot11kvDisabled && (!document.getElementById("role_disabled").checked)) {
  if(!confirm("<% multilang("251" "LANG_WLAN_EASY_MESH_11KV_ENABLE_WARNING_MESSAGE"); %>")){
   return false;
  }
  document.getElementById("needEnable11kv").value = "1";
 }
/*
	var securitySettingWrong = <% checkWrite("is_security_setting_wrong"); %>;
	if (securitySettingWrong && (role == 1)) {
		alert("<% multilang(LANG_WLAN_EASY_MESH_SECURTITY_WRONG_MESSAGE); %>");
		return false;
	}
*/
 if (<% checkWrite("needPopupBackhaul"); %> && (role == 1)) {
  if(!confirm("<% multilang("253" "LANG_WLAN_EASY_MESH_ALERT_VAP1_AUTO_MANAGED_MESSAGE"); %>")){
   return false;
  }
 }
 obj.isclick = 1;
 postTableEncrypt(document.forms[0].postSecurityFlag, document.forms[0]);
    return true;
}
function isControllerOnChange(){
 if (document.getElementById("role_controller").checked == true) {
  role = 1;
 } /* else if (document.getElementById("role_agent").checked == true){
		role = 2;
	} */ else {
  role = 0;
 }
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onload="loadInfo();">
<blockquote>
<form action=/boaform/formMultiAP method=POST name="MultiAP">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("244" "LANG_WLAN_EASY_MESH_INTERFACE_SETUP"); %></p><br>
  <p class="intro_content"><% multilang("254" "LANG_WLAN_EASY_MESH_DESC"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
 <table width="400">
  <tr id="device_name">
   <th><% multilang("97" "LANG_DEVICE_NAME"); %>:</th>
   <td>
    <input type="text" id="device_name_text" name="device_name_text" value="<% getInfo("map_device_name"); %>">
   </td>
  </tr>
  <tr id="is_controller">
   <th><% multilang("246" "LANG_ROLE"); %>:</th>
   <td>
   <input type="radio" id="role_controller" name="role" value="controller" onclick="isControllerOnChange()"><% multilang("248" "LANG_CONTROLLER"); %>&nbsp;&nbsp;
   <input type="radio" id="role_disabled" name="role" value="disabled" onclick="isControllerOnChange()"><% multilang("165" "LANG_DISABLED"); %></td>
  </tr>
  <tr id="wsc_trigger">
  </tr>
   </table>
 <table style="display:none;" id="staticIpTable" border="0" width=640>
  <% dhcpRsvdIp_List();%>
 </table>
 </div>
 <br>
 <table>
 <tr>
 <td>
      <input type="submit" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" class="link_bg" name="save_apply" onClick="return saveChanges(this)">&nbsp;&nbsp;
      <input type="reset" value="<% multilang("208" "LANG_RESET"); %>" class="link_bg" name="reset" onClick="resetClick()">
   <input type="hidden" value="/multi_ap_setting_general.asp" name="submit-url">
   <input type="hidden" value="0" name="needEnable11kv" id="needEnable11kv">
   <input type="hidden" value="<% getIndex("needPopupBackhaul"); %>" name="needPopupBackhaul">
   <input type="hidden" value="" name="role_prev" id="role_prev">
   <input type="hidden" name="postSecurityFlag" value="">
 </td>
 </tr>
 </table>
 </form>
 </blockquote>
</body>
</html>
