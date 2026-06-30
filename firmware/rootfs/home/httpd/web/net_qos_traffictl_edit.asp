<%SendWebHeadStr(); %>
<title>QoS Add Flow Control</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<style>
SELECT {width:200px;}
</style>
<script language="javascript" src="common.js"></script>
<script language="javascript" type="text/javascript">
var oifkeys = new it_nr("outifkey");
<% initOutif(); %>
function on_init_page() {
 with(document.forms[0]) {
 for(var i in oifkeys){
  if(i == "name"||i=="undefined" ||(typeof oifkeys[i] != "string" && typeof oifkeys[i] != "number")) continue;
  inflist.options.add(new Option(oifkeys[i],i));
 }
 }
 if ( <%checkWrite("IPv6Show");%> )
 {
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ipprotbl').style.display = 'block';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ipprotbl.style.display = 'block';
   }
  }
 }
}
// Mason Yu:20110524 ipv6 setting. START
function on_apply() {
 with(document.forms[0]) {
  if (inflist.value == " ")
  {
   inflist.focus();
   alert("<% multilang("2300" "LANG_WAN_INTERFACE_NOT_ASSIGNED"); %>");
   return;
  }
  if(srcip.value != "" && sji_checkip(srcip.value) == false)
  {
   srcip.focus();
   alert("<% multilang("2301" "LANG_SOURCE_IP_INVALID"); %>");
   return;
  }
  if(dstip.value != "" && sji_checkip(dstip.value) == false)
  {
   dstip.focus();
   alert("<% multilang("2302" "LANG_DESTINATION_IP_INVALID"); %>");
   return;
  }
  if(srcnetmask.value != "" && sji_checkip(srcnetmask.value) == false)
  {
   srcnetmask.focus();
   alert("<% multilang("2303" "LANG_SOURCE_IP_MASK_INVALID"); %>");
   return;
  }
  if(dstnetmask.value != "" && sji_checkip(dstnetmask.value) == false)
  {
   dstnetmask.focus();
   alert("<% multilang("2304" "LANG_DESTINATION_IP_MASK_INVALID"); %>");
   return;
  }
  if(sport.value <0 || sport.value > 65536)
  {
   sport.focus();
   alert("<% multilang("2305" "LANG_SOURCE_PORT_INVALID"); %>");
   return;
  }
  if (sport.value > 0 && sport.value < 65535)
  {
   if (protolist.value == 3) { //ICMP should not specify src port
    sport.focus();
    alert("<% multilang("2306" "LANG_PLEASE_ASSIGN_TCP_UDP"); %>");
    return;
   }
  }
  if(dport.value <0 || dport.value > 65536)
  {
   dport.focus();
   alert("<% multilang("2307" "LANG_DESTINATION_PORT_INVALID"); %>");
   return;
  }
  if (dport.value > 0 && dport.value<65535)
  {
   if (protolist.value ==3) { //ICMP should not specify dst port
    dport.focus();
    alert("<% multilang("2306" "LANG_PLEASE_ASSIGN_TCP_UDP"); %>");
    return;
   }
  }
  if(rate.value<=0)
  {
   rate.focus();
   alert("<% multilang("2308" "LANG_UPLINK_RATE_INVALID"); %>");
   return;
  }
  if((rate.value%512)!=0)
  {
   rate.focus();
   alert("<% multilang("2308" "LANG_UPLINK_RATE_INVALID"); %>");
   return;
  }
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv6
   if(document.forms[0].IpProtocolType.value == 2) {
    if(sip6.value != ""){
     if (! isGlobalIpv6Address(sip6.value) ){
      alert("<% multilang("2273" "LANG_INVALID_SOURCE_IPV6_ADDRESS"); %>");
      return;
     }
     if ( sip6PrefixLen.value != "" ) {
      var prefixlen= getDigit(sip6PrefixLen.value, 1);
      if (prefixlen > 128 || prefixlen <= 0) {
       alert("<% multilang("2274" "LANG_INVALID_SOURCE_IPV6_PREFIX_LENGTH"); %>");
       return;
      }
     }
    }
    if(dip6.value != ""){
     if (! isGlobalIpv6Address(dip6.value) ){
      alert("<% multilang("2275" "LANG_INVALID_DESTINATION_IPV6_ADDRESS"); %>");
      return;
     }
     if ( dip6PrefixLen.value != "" ) {
      var prefixlen= getDigit(dip6PrefixLen.value, 1);
      if (prefixlen > 128 || prefixlen <= 0) {
       alert("<% multilang("2276" "LANG_INVALID_DESTINATION_IPV6_PREFIX_LENGTH"); %>");
       return;
      }
     }
    }
   }
  }
  // For IPv4 and IPv6
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if(document.forms[0].IpProtocolType.value == 1){
    lst.value = "inf="+inflist.value+"&proto="+protolist.value+"&IPversion="+IpProtocolType.value+"&srcip="+srcip.value+"&srcnetmask="+srcnetmask.value+
     "&dstip="+dstip.value+"&dstnetmask="+dstnetmask.value+"&sport="+sport.value+"&dport="+dport.value+"&rate="+rate.value+"&direction="+direction.value;
   }
   // For IPv6
   else if (document.forms[0].IpProtocolType.value == 2) {
    lst.value = "inf="+inflist.value+"&proto="+protolist.value+"&IPversion="+IpProtocolType.value+"&sip6="+sip6.value+"&sip6PrefixLen="+sip6PrefixLen.value+
     "&dip6="+dip6.value+"&dip6PrefixLen="+dip6PrefixLen.value+"&sport="+sport.value+"&dport="+dport.value+"&rate="+rate.value+"&direction="+direction.value;
   }
  }
  // For IPv4 only
  else
  {
    lst.value = "inf="+inflist.value+"&proto="+protolist.value+"&srcip="+srcip.value+"&srcnetmask="+srcnetmask.value+
     "&dstip="+dstip.value+"&dstnetmask="+dstnetmask.value+"&sport="+sport.value+"&dport="+dport.value+"&rate="+rate.value+"&direction="+direction.value;
  }
  submit();
 }
}
function protocolChange()
{
 // If protocol is IPv4 only.
 if(document.forms[0].IpProtocolType.value == 1){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ip4tbl').style.display = 'block';
   document.getElementById('ip6tbl').style.display = 'none';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'block';
    document.all.ip6tbl.style.display = 'none';
   }
  }
 }
 // If protocol is IPv6 only.
 else if(document.forms[0].IpProtocolType.value == 2){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ip4tbl').style.display = 'none';
   document.getElementById('ip6tbl').style.display = 'block';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'none';
    document.all.ip6tbl.style.display = 'block';
   }
  }
 }
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init_page();">
<blockquote>
 <form id="form" action="/boaform/admin/formQosTraffictlEdit" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3046" "LANG_ADD_IP_QOS_TRAFFIC"); %></p><br>
 </div>
 <div class="data_common data_common_notitle" id='ipprotbl' style="display:none">
  <table>
   <tr>
    <th width=40%>IP <% multilang("670" "LANG_VERSION"); %>:</th>
    <td><select id="IpProtocolType" onChange="protocolChange()" name="IpProtocolType">
      <option value="1" > Ipv4</option>
      <option value="2" > Ipv6</option>
     </select>
    </td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip4tbl' style="display:none;">
  <table>
   <tr>
    <th width=40%><% multilang("68" "LANG_INTERFACE");%>:</th>
    <td><select id="inflist"></select></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("366" "LANG_DIRECTION");%>:</th>
    <td><select name="direction">
      <option value="0"><% multilang("489" "LANG_UPSTREAM");%></option>
      <option value="1"><% multilang("488" "LANG_DOWNSTREAM");%> </option>
           </select>
    </td>
   </tr>
   <tr>
    <th width=40%><% multilang("93" "LANG_PROTOCOL"); %>:</th>
    <td><select name="protolist">
      <option value="0">NONE</option>
      <option value="1">TCP</option>
      <option value="2">UDP </option>
      <option value="3">ICMP </option>
           </select>
    </td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip4tbl' style="display:block;">
  <table>
   <tr>
    <th width=40%><% multilang("370" "LANG_SOURCE"); %>IP:</th>
    <td><input type="text" name="srcip" size="15" maxlength="15" style="width:150px"></td>
   </tr>
   <tr>
      <th width=40%><% multilang("628" "LANG_SOURCE_MASK"); %>:</th>
    <td><input type="text" name="srcnetmask" size="15" maxlength="15" style="width:150px"></td>
   </tr>
   <tr>
    <th width=40%><% multilang("371" "LANG_DESTINATION"); %>IP:</th>
    <td><input type="text" name="dstip" size="15" maxlength="15" style="width:150px"></td>
   </tr>
   <tr>
      <th width=40%><% multilang("629" "LANG_DESTINATION_MASK"); %>:</th>
    <td><input type="text" name="dstnetmask" size="15" maxlength="15" style="width:150px"></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip6tbl' style="display:none;">
  <table>
   <tr>
    <th width=40%><% multilang("370" "LANG_SOURCE"); %>:</th>
    <td><input type="text" name="sip6" size="26" maxlength="39" style="width:150px"></td>
   </tr>
   <tr>
      <th width=40%><% multilang("768" "LANG_SOURCE_PREFIX_LENGTH"); %>:</th>
    <td><input type="text" name="sip6PrefixLen" size="15" maxlength="15" style="width:150px"></td>
   </tr>
   <tr>
     <th width=40%><% multilang("371" "LANG_DESTINATION"); %>:</th>
    <td><input type="text" name="dip6" size="26" maxlength="39" style="width:150px"></td>
   </tr>
   <tr>
      <th width=40%><% multilang("769" "LANG_DESTINATION_PREFIX_LENGTH"); %>:</th>
    <td><input type="text" name="dip6PrefixLen" size="15" maxlength="15" style="width:150px"></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("373" "LANG_SOURCE_PORT"); %>:</th>
    <td><input type="text" name="sport" size="6" style="width:80px"></td>
   </tr>
   <tr>
      <th width=40%><% multilang("374" "LANG_DESTINATION_PORT"); %>:</th>
    <td><input type="text" name="dport" size="6" style="width:80px"></td>
   </tr>
   <tr>
     <th width=40%><% multilang("758" "LANG_RATE_LIMIT"); %>:</th>
    <td><input type="text" name="rate" size="6" style="width:80px">kb/s </td>
   </tr>
  </table>
 </div>
 <br><br>
 <div class="btn_ctl">
     <input type="button" class="link_bg" name="return" value="<% multilang("708" "LANG_CLOSE"); %>" onClick="location.href='/net_qos_traffictl.asp';" style="width:80px">&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" class="link_bg" name="apply" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick="on_apply();" style="width:100px">
  <input type="hidden" name="lst" id="lst" value="">
  <input type="hidden" name="submit-url" value="/net_qos_traffictl.asp">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
