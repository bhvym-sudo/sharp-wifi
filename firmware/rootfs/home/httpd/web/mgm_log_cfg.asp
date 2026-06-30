<%SendWebHeadStr(); %>
<title><% multilang("3551" "LANG_STD_DEVICE_TITLE"); %></title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script type="text/javascript" src="share.js"></script>
<script >
<% checkWrite("get-syslog-server"); %>
/*
var addr = <% getInfo("syslog-server-ip"); %>;
var port = <% getInfo("syslog-server-port"); %>;
*/
function getLogPort()
{
 if (isNaN(port) || port == 0)
  port = 514; // default system log server port is 514
 return port;
}
/********************************************************************
**          on document update
********************************************************************/
function on_updatectrl()
{
 with (document.forms[0]) {
  <% checkWrite("on_updatectrl_init"); %>
  /*if (syslogEnable[0].checked) {
			recordLevel.disabled = true;
			dispLevel.disabled = true;
			sysMode.disabled = true;
			logAddr.disabled = true;
			logPort.disabled = true;
			logAddr.value = '';
			logPort.value = '';
		} else {
			recordLevel.disabled = false;
			dispLevel.disabled = false;
			sysMode.disabled = false;
			logAddr.disabled = false;
			logPort.disabled = false;
			logAddr.value = addr;
			logPort.value = getLogPort();
		}
		srvInfo.style.display = (sysMode.value & 2) ? "block" : "none";*/
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with (document.forms[0]) {
  <% checkWrite("on_submit_init"); %>
  /*if (syslogEnable[1].checked == true && sysMode.value & 2) {
			if (sji_checkvip(logAddr.value) == false) {
				logAddr.focus();
				alert("<% multilang(LANG_SERVER); %><% multilang(LANG_IP_ADDRESS); %>\"" + logAddr.value +
				      "\"<% multilang(LANG_IS_INVALID); %>,<% multilang(LANG_TRY_AGAIN); %>!");
				return;
			}
			if (sji_checkdigitrange(logPort.value, 1, 65535) ==
			    false) {
				logPort.focus();
				alert("<% multilang(LANG_SERVER); %><% multilang(LANG_UDP_PORT); %>\"" + logPort.value +
				      "\"<% multilang(LANG_IS_INVALID); %>,<% multilang(LANG_TRY_AGAIN); %>!");
				return;
			}
		}*/
  submit();
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form id="form" action="/boaform/admin/formSysLogConfig" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3248" "LANG_SYSLOG_CONFIGURATION"); %></p><br>
  <p class="intro_content"><% multilang("3249" "LANG_SYSLOG_CONFIGURATION_PAGE_1"); %></p><br>
  <p class="intro_content"><% multilang("3250" "LANG_SYSLOG_CONFIGURATION_PAGE_2"); %></p><br>
  <% checkWrite("syslog-explain-init"); %>
<!--
  <p class="intro_content"><% multilang("3251" "LANG_SYSLOG_CONFIGURATION_PAGE_3"); %></p><br>
  <p class="intro_content"><% multilang("3252" "LANG_SYSLOG_CONFIGURATION_PAGE_4"); %></p><br>
-->
  <p class="intro_content"><% multilang("3253" "LANG_SYSLOG_CONFIGURATION_PAGE_5"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("3254" "LANG_RECORD_TITLE"); %></th>
    <td><input name="syslogEnable" type="radio" value="0" onClick="on_updatectrl();" <% checkWrite("log-cap0"); %>><% multilang("233" "LANG_DISABLE");%>&nbsp;&nbsp;<input name="syslogEnable" type="radio" value="1" onClick="on_updatectrl();"<% checkWrite("log-cap1"); %>><% multilang("234" "LANG_ENABLE"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("3255" "LANG_RECORD_LEVEL_TITLE"); %></th>
    <td><select name="recordLevel" size="1" style="width:120px "><% checkWrite("syslog-log"); %></select></td>
   </tr>
   <tr>
    <th width=40%><% multilang("3256" "LANG_DISPLAY_LEVEL_TITLE"); %></th>
    <td><select name="dispLevel" size="1" style="width:120px "><% checkWrite("syslog-display"); %></select></td>
   </tr>
   <% checkWrite("syslog-mode-init"); %>
<!--
   <tr>
    <th width=40%><% multilang("129" "LANG_MODE"); %>:</th>
    <td><select name="sysMode" size="1" style="width:120px "><% checkWrite("syslog-mode"); %></select></td>
   </tr>
-->
  </table>
   <% checkWrite("syslog-server-init"); %>
<!--
  <table id="srvInfo" >
   <tr>
    <th width=40%><% multilang("3257" "LANG_SERVER_IP_ADDR_TITLE"); %></th>
    <td><input type="text" name="logAddr"></td>
   </tr>
   <tr>
    <th width=40%><% multilang("3258" "LANG_SERVER_UDP_PORT_TITLE"); %></th>
    <td><input type="text" name="logPort"></td>
   </tr>
  </table>
-->
 </div>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="on_submit()" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>">
  <input type="hidden" name="submit-url" value="/mgm_log_cfg.asp">
 </div>
 <script>
  on_updatectrl();
 </script>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
