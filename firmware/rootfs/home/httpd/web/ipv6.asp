<%SendWebHeadStr(); %>
<TITLE>HGU-DHCP</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" src="share.js"></SCRIPT>
<SCRIPT>
var popUpWin=0;
//var cgi = new Object();
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
//	sji_docinit(document, cgi);
}
/********************************************************************
**          on document update
********************************************************************/
function popUpWindow(URLStr, left, top, width, height)
{
 if(popUpWin)
 {
  if(!popUpWin.closed) popUpWin.close();
 }
 popUpWin = open(URLStr, "popUpWin", "toolbar=yes,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width="+width+",height="+height+",left="+left+", top="+top+",screenX="+left+",screenY="+top+"");
}
/********************************************************************
**          on document submit
********************************************************************/
function on_lanipv6addrform_submit(reboot)
{
 if(reboot)
 {
  var loc = "mgm_dev_reboot.asp";
  var code = "location.assign(\"" + loc + "\")";
  eval(code);
 }
 else
 {
  with ( document.forms[0] )
  {
   if ( document.lanipv6addrform.lanIpv6addr.value == "" )
   {
    document.lanipv6addrform.lanIpv6addr.focus();
    alert("IP <% multilang("2997" "LANG_ADDRESS"); %> \"" + document.lanipv6addrform.lanIpv6addr.value + "\" <% multilang("1704" "LANG_TINVALID_IP"); %>");
    return false;
   }
   else
   {
    if ( isLinkLocalIpv6Address(document.lanipv6addrform.lanIpv6addr.value) == 0) {
     alert("<% multilang("2396" "LANG_INVALID_LAN_IPV6_IP"); %>"); //Invalid LAN IPv6 address!
     document.lanipv6addrform.lanIpv6addr.focus();
     document.lanipv6addrform.lanIpv6addr.value ="<% checkWrite("lanipv6addr"); %>";
     return false;
    }
   }
   submit();
  }
 }
}
function prefixModeChange()
{
 with ( document.lanipv6prefixmodeform )
 {
  var prefix_mode =ipv6lanprefixmode.value;
  v6delegated_WANConnection.style.display = 'none';
  staticipv6prefix.style.display = 'none';
  switch(prefix_mode){
   case '0': //WANDelegated
     v6delegated_WANConnection.style.display = 'block';
     break;
   case '1': //Static
     staticipv6prefix.style.display = 'block';
     break;
  }
 }
}
function dnsModeChange()
{
 with ( document.lanipv6dnsform )
 {
  var dns_mode =ipv6landnsmode.value;
  v6dns_WANConnection.style.display = 'none';
  v6dns_Staic.style.display = 'none';
  switch(dns_mode){
   case '0': //HGWProxy
     break;
   case '1': //WANConnection
     v6dns_WANConnection.style.display = 'block';
     break;
   case '2': //Static
     v6dns_Staic.style.display = 'block';
     if(Ipv6Dns1.value == "::") //clear the value
      Ipv6Dns1.value ="";
     if(Ipv6Dns2.value == "::")
      Ipv6Dns2.value ="";
     break;
  }
 }
}
//Handle DNSv6 mode
function on_lanipv6dnsform_submit(reboot)
{
 with ( document.lanipv6dnsform )
 {
  if ( ipv6landnsmode.value==2 ){ //static
    if(Ipv6Dns1.value == "" && Ipv6Dns2.value == "" ) //Both DNS setting is NULL
    {
     Ipv6Dns1.focus();
     alert("IPv6¡¡DNS <% multilang("2997" "LANG_ADDRESS"); %> " + Ipv6Dns1.value + "\" <% multilang("1998" "LANG_INVALID_6RD_PREFIX_ADDRESS"); %>");
     return false;
    }
    else if (Ipv6Dns1.value != "" || Ipv6Dns2.value != ""){
     if(Ipv6Dns1.value != "" ){
      if (! isUnicastIpv6Address( Ipv6Dns1.value) ){
        alert("<% multilang("1994" "LANG_INVALID_PRIMARY_IPV6_DNS_ADDRESS"); %>");
        Ipv6Dns1.focus();
        return false;
      }
     }
     if(Ipv6Dns2.value != "" ){
      if (! isUnicastIpv6Address( Ipv6Dns2.value) ){
        alert("<% multilang("1995" "LANG_INVALID_SECONDARY_IPV6_DNS_ADDRESS"); %>");
        Ipv6Dns2.focus();
        return false;
      }
     }
    }
  }
  submit();
 }
}
//Handle Prefix v6 mode
function on_lanipv6prefixmodeform_submit(reboot)
{
 with ( document.lanipv6prefixmodeform )
 {
   if ( ipv6lanprefixmode.value==1 ){
    if(document.lanipv6prefixmodeform.lanIpv6prefix.value == "" )
    {
     document.lanipv6prefixmodeform.lanIpv6prefix.focus();
     alert("<% multilang("1998" "LANG_INVALID_6RD_PREFIX_ADDRESS"); %>");
     return false;
    }
    else if ( validateKeyV6Prefix(document.lanipv6prefixmodeform.lanIpv6prefix.value) == 0) { //check if is valid ipv6 address
     alert("<% multilang("1992" "LANG_INVALID_IPV6_PREFIX_LENGTH"); %>");
     document.lanipv6prefixmodeform.lanIpv6prefix.focus();
     return false;
    }
   }
   submit();
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form action=/boaform/formlanipv6 method=POST name="lanipv6addrform">
 <div class="column">
  <div class="column_title">
   <div class="column_title_left"></div>
    <p>LAN IPv6 <% multilang("2997" "LANG_ADDRESS"); %> <% multilang("224" "LANG_CONFIGURATION"); %></p>
   <div class="column_title_right"></div>
  </div>
  <div class="data_common">
   <table>
    <tr>
     <th width=40%>IPv6 <% multilang("2997" "LANG_ADDRESS"); %>:</th>
     <td><input type="text" name="lanIpv6addr" value=<% checkWrite("lanipv6addr"); %>></td>
    </tr>
   </table>
  </div>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="on_lanipv6addrform_submit(0);" value="<% multilang("827" "LANG_SAVE"); %>">&nbsp; &nbsp; &nbsp; &nbsp;
  <input type="hidden" value="/ipv6.asp" name="submit-url">
 </div>
 <br>
 </form>
 <form action=/boaform/formlanipv6dns method=POST name="lanipv6dnsform">
 <div class="column">
  <div class="column_title">
   <div class="column_title_left"></div>
    <p>LAN DNS Server&nbsp;<% multilang("224" "LANG_CONFIGURATION"); %></p>
   <div class="column_title_right"></div>
  </div>
  <div class="data_common">
   <table>
    <tr>
     <th width=40%>LAN DNS <% multilang("129" "LANG_MODE"); %></th>
      <td><select name="ipv6landnsmode" onChange="dnsModeChange()">
          <option value="0">HGWProxy</option>
        <option value="1">WANConnection</option>
          <option value="2">Static</option>
       </select>
      </td>
    </tr>
   </table>
  </div>
  <div class="data_common" id='v6dns_WANConnection' style="display:none;">
   <table>
    <tr>
     <th width=40%> <% multilang("68" "LANG_INTERFACE"); %>: </th>
     <td><select name="ext_if" > <% if_wan_list("rtv6"); %> </select></td>
    </tr>
   </table>
  </div>
  <div class="data_common" id='v6dns_Staic' style="display:none;">
   <table>
    <tr>
     <th width=40%><% multilang("301" "LANG_PRIMARY"); %> IPv6 DNS:</th>
     <td><input type="text" name="Ipv6Dns1" size="36" maxlength="39" value=<% getInfo("wan-dnsv61"); %> style="width:150px"></td>
    </tr>
    <tr>
     <th width=40%><% multilang("302" "LANG_SECONDARY"); %> IPv6 DNS:</th>
     <td><input type=text name="Ipv6Dns2" size="36" maxlength="39" value=<% getInfo("wan-dnsv62"); %> style="width:150px"></td>
    </tr>
   </table>
  </div>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="on_lanipv6dnsform_submit(0);" value="<% multilang("827" "LANG_SAVE"); %>">&nbsp; &nbsp; &nbsp; &nbsp;
  <input type="hidden" value="/ipv6.asp" name="submit-url">
 </div>
 <br>
 </form>
 <form action=/boaform/formlanipv6prefix method=POST name="lanipv6prefixmodeform">
 <div class="column">
  <div class="column_title">
   <div class="column_title_left"></div>
    <p><% multilang("104" "LANG_PREFIX"); %> <% multilang("370" "LANG_SOURCE"); %></p>
   <div class="column_title_right"></div>
  </div>
  <div class="data_common">
   <table>
    <tr>
     <th width=40%>LAN <% multilang("103" "LANG_PREFIX_DELEGATION"); %></th>
     <td><select name="ipv6lanprefixmode" onChange="prefixModeChange()">
         <option value="0">WANDelegated </option>
       <option value="1">Static</option>
      </select>
     </td>
    </tr>
   </table>
  </div>
  <div class="data_common" id='v6delegated_WANConnection' style="display:none;">
   <table>
    <tr>
     <th width=40%><% multilang("68" "LANG_INTERFACE"); %>:</th>
     <td><select name="ext_if" > <% if_wan_list("rtv6"); %> </select></td>
    </tr>
   </table>
  </div>
  <div class="data_common" id="staticipv6prefix" style="display:none;">
   <table>
    <tr>
     <th width=40%>IPv6 <% multilang("104" "LANG_PREFIX"); %> : (2001::/64)</th>
     <td><input type="text" name="lanIpv6prefix" value=<% checkWrite("lanipv6prefix"); %>></td>
    </tr>
   </table>
  </div>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="on_lanipv6prefixmodeform_submit(0);" value="<% multilang("827" "LANG_SAVE"); %>">&nbsp; &nbsp; &nbsp; &nbsp;
  <input type="hidden" value="/ipv6.asp" name="submit-url">
 </div>
 <br>
 </form>
</blockquote>
<script>
 ifIdx = <% getInfo("prefix-delegation-wan-conn"); %>;
 if (ifIdx != 65535)
  document.lanipv6prefixmodeform.ext_if.value = ifIdx;
 else
  document.lanipv6prefixmodeform.ext_if.selectedIndex = 0;
 document.lanipv6prefixmodeform.ipv6lanprefixmode.value = <% getInfo("prefix-mode"); %>;
  ifIdx = <% getInfo("dns-wan-conn"); %>;
 if (ifIdx != 65535)
  document.lanipv6dnsform.ext_if.value = ifIdx;
 else
  document.lanipv6dnsform.ext_if.selectedIndex = 0;
 document.lanipv6dnsform.ipv6landnsmode.value=<% getInfo("dns-mode"); %>;
 prefixModeChange();
 dnsModeChange();
</script>
</body>
</html>
