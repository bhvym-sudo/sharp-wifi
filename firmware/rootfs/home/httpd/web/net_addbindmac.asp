<%SendWebHeadStr(); %>
<TITLE>HGU-DHCP</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT>
/********************************************************************
**          on document submit
********************************************************************/
function on_submit(act)
{
 with ( document.form )
 {
  action.value = act;
  if(act == "sv")
  {
   if ( macAddr_Dhcp.value.length == 0 )
   {
    alert("<% multilang("1695" "LANG_INVALID_MAC_ADDR_SHOULD_NOT_EMPTY"); %>");
    return;
   }
   else if ( sji_checkmac(macAddr_Dhcp.value) == false )
   {
    msg = "<% multilang("90" "LANG_MAC_ADDRESS"); %> \"" + macAddr_Dhcp.value + "\" <% multilang("3053" "LANG_IS_INVALID"); %>.";
    alert(msg);
    return;
   }
   if ( ipAddr_Dhcp.value.length == 0 )
   {
    alert("<% multilang("2197" "LANG_IP_ADDRESS_CANNOT_BE_EMPTY"); %>.");
    return;
   }
   else if ( sji_checkvip(ipAddr_Dhcp.value) == false )
   {
    msg = "<% multilang("87" "LANG_IP_ADDRESS"); %> \"" + ipAddr_Dhcp.value + "\" <% multilang("3053" "LANG_IS_INVALID"); %>.";
    alert(msg);
    return;
   }
   submit();
  }
 }
}
// done hiding -->
</script>
   </head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
 <form action=/boaform/formMacAddrBase method="post" name="form">
  <b><% multilang("3556" "LANG_ADD_RESERVE_IP_PAGE"); %></b>
 <br>
 <br>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("90" "LANG_MAC_ADDRESS"); %>:<br>(e.g.,00-90-96-01-2A-3B)</th>
    <td valign="top"><input type="text" name="macAddr_Dhcp" size="20"></td>
   </tr>
   <tr>
    <th width=40%><% multilang("3557" "LANG_RESERVE_IP_ADDRESS"); %>:<br>(e.g.,192.168.1.2)</th>
    <td valign="top"><input type="text" name="ipAddr_Dhcp" size="20"></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <table>
   <tr>
    <td align="left" width="30%"><input type="button" class="link_bg" onClick="history.back();" value="<% multilang("1193" "LANG_BACK"); %>"></td>
    <td align="left"><input type="button" class="link_bg" onClick="on_submit('sv');" value="<% multilang("3392" "LANG_CONFIRM"); %>"></td>
    <input type="hidden" id="action" name="action" value="sv">
    <input type="hidden" name="submit-url" value="/net_mopreipaddr.asp">
   </tr>
  </table>
 </div>
 </form>
</body>
<%addHttpNoCache();%>
</html>
