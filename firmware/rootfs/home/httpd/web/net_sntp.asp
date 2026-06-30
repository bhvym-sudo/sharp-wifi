<%SendWebHeadStr(); %>
<title>Time Server</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script language="javascript" type="text/javascript">
var ntpServers = new Array();
ntpServers.push("clock.fmt.he.net");
ntpServers.push("clock.nyc.he.net");
ntpServers.push("clock.sjc.he.net");
ntpServers.push("clock.via.net");
ntpServers.push("ntp1.tummy.com");
ntpServers.push("time.cachenetworks.com");
ntpServers.push("time.nist.gov");
function ntpChange(optionlist, textbox)
{
 textbox.disabled = (optionlist.value == "Other") ? false : true;
}
function ntpEnblChange()
{
 if (document.forms[0].ntpEnabled.checked)
  status = 'visible';
 else
  status = 'hidden';
 if (document.getElementById)
  document.getElementById('ntpConfig').style.visibility = status;
 else if (!document.layers)
  document.all.ntpConfig.style.visibility = status;
}
function writeNtpList(select, other, server, needed)
{
 var flag = 0;
 if (!needed)
  select.add(new Option("None"));
 for (var i = 0; i < ntpServers.length; i++) {
  if (server.value == ntpServers[i]) {
   select.add(new Option(ntpServers[i], ntpServers[i], true, true));
   flag = 1;
  } else {
   select.add(new Option(ntpServers[i]));
  }
 }
 if (flag || !needed && server.value.length == 0) {
  select.add(new Option("Other"));
  other.disabled = true;
  other.value = "";
 } else {
  select.add(new Option("Other", "Other", true, true));
  other.disabled = false;
  other.value = server.value;
 }
}
function if_typeChange()
{
 var if_type = document.forms[0].if_type.value;
 var if_wan = document.forms[0].if_wan;
 var keyword, i;
 switch (if_type) {
  case "0":
   keyword = "INTERNET";
   break;
  case "1":
   keyword = "VOICE";
   break;
  case "2":
   keyword = "TR069";
   break;
  case "3":
  default:
   keyword = "Other";
   break;
 }
 for (i = 0; i < if_wan.options.length; i++) {
  if (if_wan.options[i].text.search(keyword) == -1) {
   //if_wan.options[i].style.display = "none";		//this is not workable with IE
   if_wan.options[i].disabled = true;
  } else {
   //if_wan.options[i].style.display = "block";
   if_wan.options[i].disabled = false;
  }
 }
 /* deselect when the previous selected interface does not match the new selected if_type */
 if (if_wan.selectedIndex == -1 || (if_wan.selectedIndex >= 0 && if_wan.options[if_wan.selectedIndex].text.search(keyword) == -1))
 {
  if_wan.selectedIndex = -1;
  /* Find first available interface */
  for (i = 0; i < if_wan.options.length; i++)
  {
   if (if_wan.options[i].text.search(keyword) > 0)
    if_wan.selectedIndex = i;
  }
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 var select1 = document.getElementById("ntpServerHost1");
 var srv1 = select1.options[select1.selectedIndex].text;
 var select2 = document.getElementById("ntpServerHost2");
 var srv2 = select2.options[select2.selectedIndex].text;
 with (document.forms[0]) {
  if (ntpEnabled.checked) {
   if (srv1 == "Other") {
    if (ntpServerOther1.value.length == 0) { // == Other
     alert('<% multilang("3075" "LANG_NTP_SERVER_OTHER1"); %>');
     return;
    } else {
     server1.value = document.timeZone.ntpServerOther1.value;
    }
   } else {
    server1.value = srv1;
   }
   if (srv2 == "Other") {
    if (ntpServerOther2.value.length == 0) { // == Other
     alert('<% multilang("3076" "LANG_NTP_SERVER_OTHER2"); %>');
     return;
    } else {
     server2.value = ntpServerOther2.value;
    }
   } else {
    if (ntpServerHost2.selectedIndex > 0)
     server2.value = srv2;
    else
     server2.value = "";
   }
   if (interval.value == 0) {
    alert("<% multilang("3074" "LANG_INTERVAL_SHOULD_NOT_BE_0"); %>");
    return;
   }
  }
 }
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form action=/boaform/admin/formTimezone method=POST name="timeZone" id="timeZone" >
 <div class="intro_main ">
  <p class="intro_title"><% multilang("2901" "LANG_TIMER_CONFIG"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("537" "LANG_CURRENT_TIME"); %>:</th>
    <td><% getInfo("date"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("538" "LANG_TIME_ZONE_SELECT"); %>:</th>
    <td><select name='tmzone' size="1"><% timeZoneList(); %></select></td>
   </tr>
   <tr>
    <th width=40%><% multilang("539" "LANG_ENABLE_DAYLIGHT_SAVING_TIME"); %></th>
    <td><input type='checkbox' name='dstEnabled'></td>
   </tr>
   <tr>
    <th width=40%><% multilang("540" "LANG_ENABLE_SNTP_CLIENT_UPDATE"); %></th>
    <td><input type='checkbox' name='ntpEnabled' onClick='ntpEnblChange()'></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ntpConfig'>
  <table>
   <tr>
    <th width=40%>NTP <% multilang("301" "LANG_PRIMARY"); %> <% multilang("76" "LANG_TIME"); %> <% multilang("89" "LANG_SERVER"); %>:</th>
    <td><select id='ntpServerHost1' name='ntpServerHost1' size="1" onChange='ntpChange(ntpServerHost1, ntpServerOther1)'></select></td>
    <td><input type='text' name='ntpServerOther1' disabled></td>
   </tr>
   <tr>
    <th width=40%>NTP <% multilang("302" "LANG_SECONDARY"); %> <% multilang("76" "LANG_TIME"); %> <% multilang("89" "LANG_SERVER"); %>:</th>
    <td><select id='ntpServerHost2' name='ntpServerHost2' size="1" onChange='ntpChange(ntpServerHost2, ntpServerOther2)'></select></td>
    <td><input type='text' name='ntpServerOther2' disabled></td>
   </tr>
  </table>
  <table>
   <tr>
    <th width=40%><% multilang("3072" "LANG_SYNCHRONIZING_TYPE"); %>:</th>
    <td>
     <select name='if_type' onClick='if_typeChange()'>
      <option value = "0" selected>INTERNET</option>
      <option value = "1">VOICE</option>
      <option value = "2">TR069</option>
      <option value = "3">Other</option>
       </select>
    </td>
   </tr>
   <tr>
    <th width=40%><% multilang("3073" "LANG_SYNCHRONIZING_WAN_INTERFAVE"); %>:</th>
    <td><select name="if_wan"><% if_wan_list("rt"); %></select></td>
   </tr>
   <tr>
    <th width=40%><% multilang("978" "LANG_INTERVAL"); %>:</th>
    <td><input type='text' name='interval'></td>
   </tr>
  </table>
 </div>
 <br><br>
 <div class="btn_ctl">
  <input type='submit' class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick='on_submit();'>
  <input type='hidden' name="server1" value="">
  <input type='hidden' name="server2" value="">
  <input type="hidden" name="submit-url" value="/net_sntp.asp">
 </div>
   </form>
   <script language="javascript">
    with (document.forms[0]) {
     <% init_sntp_page(); %>
     writeNtpList(ntpServerHost1, ntpServerOther1, server1, true);
     writeNtpList(ntpServerHost2, ntpServerOther2, server2, false);
     ntpEnblChange();
    }
   </script>
   </div>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
