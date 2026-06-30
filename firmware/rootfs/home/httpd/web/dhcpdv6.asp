<%SendWebHeadStr(); %>
<TITLE>DHCP Server Setup</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<% language=javascript %>
<SCRIPT language="javascript" type="text/javascript">
function showDhcpv6Svr(ip)
{
 var html;
 if (document.dhcpd.dhcpdenable[0].checked == true)
  document.getElementById('displayDhcpSvr').innerHTML=
   '<input type="submit" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save">&nbsp;&nbsp;';
 else if (document.dhcpd.dhcpdenable[1].checked == true)
  document.getElementById('displayDhcpSvr').innerHTML=
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr><b><% multilang("718" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_UPPER_INTERFACE_SERVER_LINK_FOR_DHCPV6_RELAY"); %></b></tr>'+
   '<tr><hr size=1 noshade align=top></tr>'+
   '</table>'+
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
      '<tr>'+
                '<td width="30%">Upper Interface:</td>'+
                               '<td width="35%">'+
                                  '<select name="upper_if">'+
                                  '<% if_wan_list("all2"); %>'+
                                  '</select>'+
                               '</td>'+
                           '</tr>'+
   '</table>'+
   '<input type="submit" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save">&nbsp;&nbsp;';
 else if (document.dhcpd.dhcpdenable[2].checked == true) {
  html=
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr><b><% multilang("720" "LANG_ENABLE_THE_DHCPV6_SERVER_IF_YOU_ARE_USING_THIS_DEVICE_AS_A_DHCPV6_SERVER_THIS_PAGE_LISTS_THE_IP_ADDRESS_POOLS_AVAILABLE_TO_HOSTS_ON_YOUR_LAN_THE_DEVICE_DISTRIBUTES_NUMBERS_IN_THE_POOL_TO_HOSTS_ON_YOUR_NETWORK_AS_THEY_REQUEST_INTERNET_ACCESS"); %></b></tr>'+
    '</table>'+
   '<table border=0 width="500" cellspacing=4 cellpadding=0>';
  html+='<tr>'+
    '<td width="30%">IP Pool Range start:</td>'+
    '<td width="70%"><input type="text" name="dhcpRangeStart" size=40 maxlength=39 value="<% getInfo("dhcpv6s_range_start"); %>">&nbsp;</td>'+
    '</tr>';
  html+='<tr>'+
    '<td width="30%">IP Pool Range end:</td>'+
    '<td width="70%"><input type="text" name="dhcpRangeEnd" size=40 maxlength=39 value="<% getInfo("dhcpv6s_range_end"); %>">&nbsp;</td>'+
    '</tr>';
  html += '<tr>'+
   '<td width="30%"><% multilang("445" "LANG_PREFIX_LENGTH"); %>:</td>'+
   '<td width="70%">'+
   '<input type="text" name="prefix_len" size=10 maxlength=3 value="<% getInfo("dhcpv6s_prefix_length"); %>">'+
   '</td>'+
   '</tr>';
  html += '<tr>'+
   '<td width="30%"><% multilang("721" "LANG_VALID_LIFETIME"); %>:</td>'+
   '<td width="70%">'+
   '<input type="text" name="Dltime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_default_LTime"); %>"> seconds'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><% multilang("722" "LANG_PREFERRED_LIFETIME"); %>:</td>'+
   '<td width="70%">'+
   '<input type="text" name="PFtime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_preferred_LTime"); %>"> seconds'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><% multilang("723" "LANG_RENEW_TIME"); %>:</td>'+
   '<td width="70%">'+
   '<input type="text" name="RNtime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_renew_time"); %>"> seconds'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><% multilang("724" "LANG_REBIND_TIME"); %>:</td>'+
   '<td width="70%">'+
   '<input type="text" name="RBtime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_rebind_time"); %>"> seconds'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><% multilang("725" "LANG_CLIENT"); %> DUID:</td>'+
   '<td width="70%">'+
   '<input type="text" name="clientID" size=42 maxlength=41 value="<% getInfo("dhcpv6s_clientID"); %>">'+
   '</td>'+
   '</tr>'+
   '</table>'+
   '<input type="submit" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;'+
   '<tr><hr size=1 noshade align=top></tr>'+
   '<tr>'+
    '<td><b>domain:</b></td>'+
    '<td><input type="text" name="domainStr" size="15" maxlength="50">&nbsp;&nbsp;</td>'+
    '<td><input type="submit" value="<% multilang(LANG_
ADD); %>" name="addDomain">&nbsp;&nbsp;</td>'+
   '</tr>'+
   '<br>'+
   '<br>'+
   '<table border=0 width="300" cellspacing=4 cellpadding=0>'+
   '<tr>Domain Search Table:</tr>'+
   <% showDhcpv6SDOMAINTable(); %>
   '</table>'+
   '<br>'+
   '<input type="submit" value="<% multilang("210" "LANG_DELETE_SELECTED"); %>" name="delDomain">&nbsp;&nbsp;'+
   '<input type="submit" value="<% multilang("211" "LANG_DELETE_ALL"); %>" name="delAllDomain">&nbsp;&nbsp;&nbsp;'+
   '<br>'+
   '<br>'+
   '<tr><hr size=1 noshade align=top></tr>'+
   '<tr>'+
    '<td><b><% multilang("727" "LANG_NAME_SERVER"); %> IP:</b></td>'+
    '<td><input type="text" name="nameServerIP" size="15" maxlength="40">&nbsp;&nbsp;</td>'+
    '<td><input type="submit" value="<% multilang("207" "LANG_ADD"); %>" name="addNameServer">&nbsp;&nbsp;</td>'+
   '</tr>'+
   '<br>'+
   '<br>'+
   '<table border=0 width="300" cellspacing=4 cellpadding=0>'+
   '<tr>Name Server Table:</tr>'+
   <% showDhcpv6SNameServerTable(); %>
   '</table>'+
   '<br>'+
   '<input type="submit" value="<% multilang("210" "LANG_DELETE_SELECTED"); %>" name="delNameServer">&nbsp;&nbsp;'+
   '<input type="submit" value="<% multilang("211" "LANG_DELETE_ALL"); %>" name="delAllNameServer">&nbsp;&nbsp;&nbsp;';
  document.getElementById('displayDhcpSvr').innerHTML=html;
 }
 else if (document.dhcpd.dhcpdenable[3].checked == true){
 html=
   '<table>'+
   '<tr><b><% multilang("1274" "LANG_CONFIG"); %> DHCPv6 Server</b></tr>'+
    '</table>'+
   '<table>';
  html+='<tr>'+
    '<th width="40%"><% multilang("487" "LANG_START"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>'+
    '<td width="60%"><input type="text" name="dhcpRangeStart" size=20 maxlength=19 value="<% getInfo("dhcpv6s_min_address"); %>">&nbsp;(<% multilang("3070" "LANG_IP_LAST_64_BITS"); %>)</td>'+
    '</tr>';
  html+='<tr>'+
    '<th width="40%"><% multilang("591" "LANG_END"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>'+
    '<td width="60%"><input type="text" name="dhcpRangeEnd" size=20 maxlength=19 value="<% getInfo("dhcpv6s_max_address"); %>">&nbsp;(<% multilang("3070" "LANG_IP_LAST_64_BITS"); %>)</td>'+
    '</tr>'+
  /* Add by jzh for mission#0007472*/
   '<tr>'+
   '<th width="40%"><% multilang("721" "LANG_VALID_LIFETIME"); %>:</th>'+
   '<td width="60%"><input type="text" name="Dltime" size=20 maxlength=19 value="<% getInfo("dhcpv6s_default_LTime"); %>"> seconds </td>'+
   '</tr>'+
   '<tr>'+
   '<th width="40%"><% multilang("722" "LANG_PREFERRED_LIFETIME"); %>:</th>'+
   '<td width="60%">'+
   '<input type="text" name="PFtime" size=20 maxlength=19 value="<% getInfo("dhcpv6s_preferred_LTime"); %>"> seconds'+
   '</td>'+
   '</tr>'+
  /* End of mission#0007472 */
   '</table><br>'+
   '<div class="btn_ctl"><input type="submit" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()"></div>&nbsp;&nbsp;';
  document.getElementById('displayDhcpSvr').innerHTML=html;
    }
}
function checkDigitRange_leaseTime(str, min)
{
  d = parseInt(str, 10);
  if ( d < min || d == 0)
       return false;
  return true;
}
function validateKey_leasetime(str)
{
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
      (str.charAt(i) == '-' ) )
   continue;
 return 0;
  }
  return 1;
}
function saveChanges()
{
 if (document.dhcpd.dhcpRangeStart.value =="") {
  alert('<% multilang("2097" "LANG_START_IP_ADDRESS_CANNOT_BE_EMPTY_FORMAT_IS_IPV6_ADDRESS_FOR_EXAMPLE_2000_0200_10"); %>');
  document.dhcpd.dhcpRangeStart.value = document.dhcpd.dhcpRangeStart.defaultValue;
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 } else {
  if (! isUnicastIpv6AddressForDHCPv6( '0::'+document.dhcpd.dhcpRangeStart.value) ){
   alert('<% multilang("2098" "LANG_INVALID_START_IP"); %>');
   document.dhcpd.dhcpRangeStart.focus();
   return false;
  }
 }
 if (document.dhcpd.dhcpRangeEnd.value =="") {
  alert('<% multilang("2099" "LANG_END_IP_ADDRESS_CANNOT_BE_EMPTY_FORMAT_IS_IPV6_ADDRESS_FOR_EXAMPLE_2000_0200_20"); %>');
  document.dhcpd.dhcpRangeEnd.value = document.dhcpd.dhcpRangeEnd.defaultValue;
  document.dhcpd.dhcpRangeEnd.focus();
  return false;
 } else {
  if (! isUnicastIpv6AddressForDHCPv6( '0::'+document.dhcpd.dhcpRangeEnd.value) ){
   alert('<% multilang("2100" "LANG_INVALID_END_IP"); %>');
   document.dhcpd.dhcpRangeEnd.focus();
   return false;
  }
 }
 return true;
}
function enabledhcpd()
{
 document.dhcpd.dhcpdenable[2].checked = true;
 //ip = ShowIP(document.dhcpd.lan_ip.value);
 showDhcpv6Svr();
}
function disabledhcpd()
{
 document.dhcpd.dhcpdenable[0].checked = true;
 showDhcpv6Svr();
}
function enabledhcprelay()
{
 document.dhcpd.dhcpdenable[1].checked = true;
 showDhcpv6Svr();
}
function autodhcpd()
{
 document.dhcpd.dhcpdenable[3].checked = true;
 showDhcpv6Svr();
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
<form action=/boaform/formDhcpv6Server method=POST name="dhcpd">
 <div class="intro_main ">
  <p class="intro_title">DHCPV6 <% multilang("356" "LANG_SETTINGS"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
      <th width=40%>DHCPv6 <% multilang("129" "LANG_MODE"); %>:</th>
      <td><% checkWrite("dhcpV6Mode"); %></td>
    </tr>
  </table>
 </div>
 <br>
 <div class="data_common data_common_notitle">
  <table>
     <tr><td ID="displayDhcpSvr" width="150"></td></tr>
  </table>
 </div>
    <br>
      <input type="hidden" value="/dhcpdv6.asp" name="submit-url">
<script>
 <% initPage("dhcpv6-mode"); %>
 showDhcpv6Svr();
</script>
 </form>
</blockquote>
</body>
</html>
