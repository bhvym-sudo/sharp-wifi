<%SendWebHeadStr(); %>
<title>HGU</title>
<META http-equiv=content-type content="text/html; charset=gbk">
<script type="text/javascript" src="share.js">
</script>
<script>
function addClick()
{
 dTelnet = getDigit(document.acc.w_telnet_port.value, 1);
 dFtp = getDigit(document.acc.w_ftp_port.value, 1);
 dWeb = getDigit(document.acc.w_web_port.value, 1);
 if (dTelnet == dFtp || dTelnet == dWeb) {
  alert("<% multilang("3571" "LANG_PORT_FILTERING_ERR_1");%>");
  document.acc.w_telnet_port.focus();
  return false;
 }
 if (dFtp == dWeb) {
  alert("<% multilang("3571" "LANG_PORT_FILTERING_ERR_1");%>");
  document.acc.w_ftp_port.focus();
  return false;
 }
 if (document.acc.w_telnet.checked) {
  if (document.acc.w_telnet_port.value=="") {
   alert("<% multilang("3572" "LANG_PORT_FILTERING_ERR_2");%>");
   document.acc.w_telnet_port.focus();
   return false;
  }
  if ( validateKey( document.acc.w_telnet_port.value ) == 0 ) {
   alert("<% multilang("3573" "LANG_PORT_FILTERING_ERR_3");%>");
   document.acc.w_telnet_port.focus();
   return false;
  }
  //d1 = getDigit(document.acc.w_telnet_port.value, 1);
  //if (d1 > 65535 || d1 < 1) {
  if (dTelnet > 65535 || dTelnet < 1) {
   alert("<% multilang("3572" "LANG_PORT_FILTERING_ERR_2");%>");
   document.acc.w_telnet_port.focus();
   return false;
  }
  }
 if (document.acc.w_ftp.checked) {
  if (document.acc.w_ftp_port.value=="") {
   alert("<% multilang("3572" "LANG_PORT_FILTERING_ERR_2");%>");
   document.acc.w_ftp_port.focus();
   return false;
  }
  if ( validateKey( document.acc.w_ftp_port.value ) == 0 ) {
   alert("<% multilang("3573" "LANG_PORT_FILTERING_ERR_3");%>");
   document.acc.w_ftp_port.focus();
   return false;
  }
  //d1 = getDigit(document.acc.w_ftp_port.value, 1);
  //if (d1 > 65535 || d1 < 1) {
  if (dFtp > 65535 || dFtp < 1) {
   alert("<% multilang("3572" "LANG_PORT_FILTERING_ERR_2");%>");
   document.acc.w_ftp_port.focus();
   return false;
  }
 }
 if (document.acc.w_web.checked) {
  if (document.acc.w_web_port.value=="") {
   alert("<% multilang("3572" "LANG_PORT_FILTERING_ERR_2");%>");
   document.acc.w_web_port.focus();
   return false;
  }
  if ( validateKey( document.acc.w_web_port.value ) == 0 ) {
   alert("<% multilang("3573" "LANG_PORT_FILTERING_ERR_3");%>");
   document.acc.w_web_port.focus();
   return false;
  }
  //d1 = getDigit(document.acc.w_web_port.value, 1);
  //if (d1 > 65535 || d1 < 1) {
  if (dWeb > 65535 || dWeb < 1) {
   alert("<% multilang("3572" "LANG_PORT_FILTERING_ERR_2");%>");
   document.acc.w_web_port.focus();
   return false;
  }
 }
 return true;
}
</script>
</head>
<body>
<blockquote>
<form action=/boaform/formSAC method=POST name=acc>
<div class="intro_main ">
 <p class="intro_content"><% multilang("3559" "LANG_PORT_FILTERING_PAGE"); %></p>
</div>
<div class="data_common data_common_notitle data_vertical">
 <table>
 <tr>
  <th width=25% align=center><% multilang("278" "LANG_SERVICE_NAME");%></th>
  <th width=25% align=center>LAN</th>
  <th width=25% align=center>WAN</th>
  <th width=25% align=center><% multilang("199" "LANG_PORT"); %></th>
  <th width=25% align=center><% multilang("384" "LANG_REMOTE_HOST"); %></th>
 </tr>
<% rmtaccItem(); %>
</table>
</div>
<br>
<div class="btn_ctl">
 <td><input class="link_bg" type="submit" value="<% multilang("797" "LANG_SUBMIT"); %>" name="set" onClick="return addClick()"></td>
 <td><input type="hidden" value="/rmtacc.asp" name="submit-url"></td>
</div>
<script>
 <% accPost(); %>
</script>
</form>
</blockquote>
</body>
</html>
