<%SendWebHeadStr(); %>
<title>Active Wireless Client Table</title>
<link rel="stylesheet" type="text/css" href="common_style.css" />
<script type="text/javascript" src="share.js"> </script>
<style>
.on {display:on}
.off {display:none}
</style>
<script language="JavaScript" type="text/javascript">
var vap_num;
var vap_id;
function init()
{
 var url_tmp = location.href;
 var url_tmp_1 = url_tmp.split("?");
 var found = url_tmp_1[1].indexOf("%3D");
 if (found == -1) {
  var id = url_tmp_1[1].split("=");
  vap_id = id[1]*1;
 }
 else
  vap_id = parseInt(url_tmp_1[1].substring(5, 6));
 get_by_id("submit-url").value = "/admin/wlstatbl_vap.asp?id="+vap_id;
}
</script>
</head>
<body>
<form action=/boaform/admin/formWirelessVAPTbl method=POST name="formWirelessVAPTbl">
<input type="hidden" value="" id="submit-url" name="submit-url">
<blockquote>
<!-- <h2 class="page_title"><% multilang("3594" "LANG_ACTIVE_WIRELESS_CLIENT_TABLE"); %> -->
<b><% multilang("3594" "LANG_ACTIVE_WIRELESS_CLIENT_TABLE"); %>
<script>
 init();
 if (vap_id == 1) {
  document.write(" - AP1");
  vap_num = 1;
 }
 else if (vap_id == 2) {
  document.write(" - AP2");
  vap_num = 2;
 }
 else if (vap_id == 3) {
  document.write(" - AP3");
  vap_num = 3;
 }
 else if (vap_id == 4) {
  document.write(" - AP4");
  vap_num = 4;
 }
 else {
  alert("<% multilang("2464" "LANG_WE_CAN_NOT_PROCESS_AP_THE_WINDOWS_WILL_BE_CLOSED"); %>");
  window.opener=null;
  window.open("","_self");
  window.close();
 }
</script>
</b><br>
<!-- </h2> -->
<table border=0 width="600" cellspacing=0 cellpadding=0>
 <tr><font size=2>
 <% multilang("3595" "LANG_ACTIVE_WIRELESS_CLIENT_TABLE_PAGE"); %>
 </tr>
 <tr><hr size=1 noshade align=top></tr>
</table>
<script> if (vap_num != 1) document.write("</table><span class = \"off\" ><table>"); </script>
<table border='1' width="600">
<tr bgcolor=#7f7f7f>
<td width="100" class="table_item"><% multilang("90" "LANG_MAC_ADDRESS"); %></td>
<td width="60" class="table_item"><% multilang("129" "LANG_MODE"); %></td>
<td width="60" class="table_item"><% multilang("144" "LANG_TX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("145" "LANG_RX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("146" "LANG_TX_RATE_MBPS"); %></td>
<td width="60" class="table_item"><% multilang("147" "LANG_POWER_SAVING"); %></td>
<td width="60" class="table_item"><% multilang("148" "LANG_EXPIRED_TIME_SEC"); %></td></tr>
<% wirelessVAPClientList(" ", "1"); %>
<script> if (vap_num != 1) document.write("</table></span><table border='1' width=\"600\">"); </script>
<script> if (vap_num != 2) document.write("</table><span class = \"off\" ><table>"); </script>
<tr bgcolor=#7f7f7f><td width="100" class="table_item"><% multilang("90" "LANG_MAC_ADDRESS"); %></td>
<td width="60" class="table_item"><% multilang("129" "LANG_MODE"); %></td>
<td width="60" class="table_item"><% multilang("144" "LANG_TX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("145" "LANG_RX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("146" "LANG_TX_RATE_MBPS"); %></td>
<td width="60" class="table_item"><% multilang("147" "LANG_POWER_SAVING"); %></td>
<td width="60" class="table_item"><% multilang("148" "LANG_EXPIRED_TIME_SEC"); %></td></tr>
<% wirelessVAPClientList(" ", "2"); %>
<script> if (vap_num != 2) document.write("</table></span><table border='1' width=\"600\">"); </script>
<script> if (vap_num != 3) document.write("</table><span class = \"off\" ><table>"); </script>
<tr bgcolor=#7f7f7f><td width="100" class="table_item"><% multilang("90" "LANG_MAC_ADDRESS"); %></td>
<td width="60" class="table_item"><% multilang("129" "LANG_MODE"); %></td>
<td width="60" class="table_item"><% multilang("144" "LANG_TX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("145" "LANG_RX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("146" "LANG_TX_RATE_MBPS"); %></td>
<td width="60" class="table_item"><% multilang("147" "LANG_POWER_SAVING"); %></td>
<td width="60" class="table_item"><% multilang("148" "LANG_EXPIRED_TIME_SEC"); %></td></tr>
<% wirelessVAPClientList(" ", "3"); %>
<script> if (vap_num != 3) document.write("</table></span><table border='1' width=\"600\">"); </script>
<script> if (vap_num != 4) document.write("</table><span class = \"off\" ><table>"); </script>
<tr bgcolor=#7f7f7f><td width="100" class="table_item"><% multilang("90" "LANG_MAC_ADDRESS"); %></td>
<td width="60" class="table_item"><% multilang("129" "LANG_MODE"); %></td>
<td width="60" class="table_item"><% multilang("144" "LANG_TX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("145" "LANG_RX_PACKETS"); %></td>
<td width="60" class="table_item"><% multilang("146" "LANG_TX_RATE_MBPS"); %></td>
<td width="60" class="table_item"><% multilang("147" "LANG_POWER_SAVING"); %></td>
<td width="60" class="table_item"><% multilang("148" "LANG_EXPIRED_TIME_SEC"); %></td></tr>
<% wirelessVAPClientList(" ", "4"); %>
<script> if (vap_num != 4) document.write("</table></span><table border='1' width=\"600\">"); </script>
</table>
  <p><input type="submit" value="<% multilang("414" "LANG_REFRESH"); %>" name="refresh">&nbsp;&nbsp;
  <input type="button" value=" <% multilang("708" "LANG_CLOSE"); %> " name="close" onClick="javascript: window.close();"></p>
</form>
</blockquote>
</body>
</html>
