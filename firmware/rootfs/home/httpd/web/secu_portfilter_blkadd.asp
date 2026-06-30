<%SendWebHeadStr(); %>
<TITLE>Management</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document);
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
  protocolChange();
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
   document.getElementById('ip4protoType').style.display = 'block';
   document.getElementById('ip6protoType').style.display = 'none';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'block';
    document.all.ip6tbl.style.display = 'none';
    document.all.ip4protoType.style.display = 'block';
    document.all.ip6protoType.style.display = 'none';
   }
  }
 }
 // If protocol is IPv6 only.
 else if(document.forms[0].IpProtocolType.value == 2){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ip4tbl').style.display = 'none';
   document.getElementById('ip6tbl').style.display = 'block';
   document.getElementById('ip4protoType').style.display = 'none';
   document.getElementById('ip6protoType').style.display = 'block';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'none';
    document.all.ip6tbl.style.display = 'block';
    document.all.ip4protoType.style.display = 'none';
    document.all.ip6protoType.style.display = 'block';
   }
  }
 }
}
// Mason Yu:20110524 ipv6 setting. START
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with ( document.forms[0] )
 {
  if(filterName.value.length <= 0)
  {
   filterName.focus();
   alert("<% multilang("360" "LANG_FILTERING"); %> <% multilang("667" "LANG_NAME"); %> <% multilang("3081" "LANG_SHOULD_NOT_BE_EMPTY"); %>");
   return;
  }
  if(sji_checkstrnor(filterName.value, 1, 22) == false)
  {
   filterName.focus();
   alert("<% multilang("3400" "LANG_FILTER_NAME_ERROR");%>£¬<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  //////////
  if((protoType.value ==0 || protoType.value ==4) && (protoTypeV6.value ==0 || protoTypeV6.value ==4 ) && (sportStart.value || sportEnd.value || dportStart.value || dportEnd.value))
  {
    sportStart.focus();
    alert("<% multilang("3401" "LANG_FILTER_ADD_ERROR_1"); %>");//The port number must be selected with TCP or UDP
   return;
  }
        if(sipStart.value.length==0 && sipEnd.value.length)
  {
   sipStart.focus();
   alert("<% multilang("3402" "LANG_FILTER_ADD_ERROR_2"); %>£¡");//The source IP end address must be matched with the source IP start address
   return;
  }
  if(dipStart.value.length==0 && dipEnd.value.length)
  {
   dipStart.focus();
   alert("<% multilang("3403" "LANG_FILTER_ADD_ERROR_3"); %>£¡");//The destination IP end address must be matched with the destination IP start address
   return;
  }
  if(smask.value.length && sipStart.value.length==0)
  {
  sipStart.focus();
  alert("<% multilang("3404" "LANG_FILTER_ADD_ERROR_4"); %>£¡")//Source subnet mask must match the source IP address
  return;
  }
  if(dmask.value.length && dipStart.value.length==0)
  {
  dipStart.focus();
  alert("<% multilang("3405" "LANG_FILTER_ADD_ERROR_5"); %>£¡");//The destination subnet mask must be matched with the destination IP address
  return;
  }
  if(sportStart.value.length==0 && sportEnd.value.length)
  {
  sportStart.focus();
  alert("<% multilang("3406" "LANG_FILTER_ADD_ERROR_6"); %>£¡");//The end source port must be matched with the starting source port
  return;
  }
  if(sportStart.value.length==0 && sportEnd.value.length)
  {
  sportStart.focus();
  alert("<% multilang("3407" "LANG_FILTER_ADD_ERROR_7"); %>£¡");//The end  destination port must be matched with the starting destination port
  return;
  }
  if(sipStart.value.length != 0 && sji_checkvip(sipStart.value) == false)
  {
   sipStart.focus();
   alert("<% multilang("3416" "LANG_SOURCE_IP_START_ADDRESS"); %>\"" + sipStart.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(sipEnd.value.length != 0 && sji_checkvip(sipEnd.value) == false)
  {
   sipEnd.focus();
   alert("<% multilang("3417" "LANG_SOURCE_IP_END_ADDRESS"); %>\"" + sipEnd.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(sipStart.value.length != 0 && sipEnd.value.length != 0 && sji_ipcmp(sipStart.value, sipEnd.value) > 0)
  {
   sipEnd.focus();
   alert("<% multilang("3408" "LANG_FILTER_ADD_ERROR_8"); %>£¬<% multilang("3080" "LANG_TRY_AGAIN")%>£¡");//The source IP start address cannot be greater than the end address
   return;
  }
  if(sipStart.value.length != 0 && sipEnd.value.length == 0 && sji_checkmask(smask.value) == false)
  {
   smask.focus();
   alert("<% multialng("3420" "LANG_SOURCE_SUBNET_MASK"); %>\"" + smask.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(sipStart.value.length != 0 && sipEnd.value.length != 0 && smask.value.length != 0)
  {
   smask.focus();
   alert("<% multilang("3409" "LANG_FILTER_ADD_ERROR_9"); %>!");//Cannot insert the source subnet mask when setting the source IP range
   return;
  }
  if(sportStart.value.length != 0 && sji_checkdigitrange(sportStart.value, 1, 65535) == false)
  {
   sportStart.focus();
   alert("<% multilang("3421" "LANG_SOURCE_START_PORT"); %>\"" + sportStart.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(sportEnd.value.length != 0 && sji_checkdigitrange(sportEnd.value, 1, 65535) == false)
  {
   sportEnd.focus();
   alert("<% multilang("3422" "LANG_SOURCE_END_PORT"); %>\"" + sportEnd.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(sportStart.value.length != 0 && sportEnd.value.length != 0 && (parseInt(sportStart.value) > parseInt(sportEnd.value)))
  {
   sportEnd.focus();
   alert("<% multilang("3410" "LANG_FILTER_ADD_ERROR_10"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");//The source start port cannot be greater than the end port
   return;
  }
  ///////////////
  if(dipStart.value.length != 0 && sji_checkvip(dipStart.value) == false)
  {
   dipStart.focus();
   alert("<% multilang("3418" "LANG_DESTINATION_IP_START_ADDRESS"); %>\"" + sipStart.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(dipEnd.value.length != 0 && sji_checkvip(dipEnd.value) == false)
  {
   dipEnd.focus();
   alert("<% multilang("3419" "LANG_DESTINATION_IP_END_ADDRESS"); %>\"" + dipEnd.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(dipStart.value.length != 0 && dipEnd.value.length != 0 && sji_ipcmp(dipStart.value, dipEnd.value) > 0)
  {
   dipEnd.focus();
   alert("<% multilang("3411" "LANG_FILTER_ADD_ERROR_11"); %>,<% multilang(TRY_AGAIN); %>!");//The destination IP start address cannot be greater than the end address
   return;
  }
  if(dipStart.value.length != 0 && dipEnd.value.length == 0 && sji_checkmask(dmask.value) == false)
  {
   dmask.focus();
   alert("<% multilang("3423" "LANG_DESTINATION_SUBNET_MASK"); %>\"" + dmask.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(dipStart.value.length != 0 && dipEnd.value.length != 0 && dmask.value.length != 0)
  {
   smask.focus();
   alert("<% multilang("3412" "LANG_FILTER_ADD_ERROR_12"); %>!");//The destination subnet mask cannot be entered when setting the range of the destination IP
   return;
  }
  if(dportStart.value.length != 0 && sji_checkdigitrange(dportStart.value, 1, 65535) == false)
  {
   dportStart.focus();
   alert("<% multilang("3424" "LANG_DESTINATION_START_PORT"); %>\"" + dportStart.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(dportEnd.value.length != 0 && sji_checkdigitrange(dportEnd.value, 1, 65535) == false)
  {
   dportEnd.focus();
   alert("<% multilang("3425" "LANG_DESTINATION_END_PORT"); %>\"" + dportStart.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
   return;
  }
  if(dportStart.value.length != 0 && dportEnd.value.length != 0 && (parseInt(dportStart.value) > parseInt(dportEnd.value)))
  {
   dportEnd.focus();
   alert("<% multilang("3413" "LANG_FILTER_ADD_ERROR_13"); %>,<% multilang(TRY_AGAIN); %>!");//The destination start port cannot be greater than the end port
   return;
  }
  /*ql:20080717 START: must assign at least one term.*/
  if ((protoType.selectedIndex==0 && sipStart.value.length==0 && dipStart.value.length==0 &&
   sportStart.value.length==0 && dportEnd.value.length==0)&&
   (protoTypeV6.selectedIndex==0 && sip6Start.value.length==0 && dip6Start.value.length==0 &&
   sportStart.value.length==0 && dportEnd.value.length==0))
  {
   alert("<% multilang("3414" "LANG_FILTER_ADD_ERROR_14"); %>!");//Please set filtering rules
   return;
  }
  /*ql:20080717 END*/
  if ( <%checkWrite("IPv6Show");%> ) {
   if(document.forms[0].IpProtocolType.value == 0) {
    alert("<% multilang("3415" "LANG_FILTER_ADD_ERROR_15"); %>!");//Please specify IP protocol version
    return;
   }
   //If this is IPv6 rule.
   if(document.forms[0].IpProtocolType.value == 2){
    if(sip6Start.value != ""){
     if (! isGlobalIpv6Address(sip6Start.value) ){
      alert("<% multilang("2174" "LANG_INVALID_SOURCE_IPV6_START_ADDRESS"); %>!"); // Invalid Source IPv6 Start address!
      return;
     }
     if ( sip6PrefixLen.value != "" ) {
      var prefixlen= getDigit(sip6PrefixLen.value, 1);
      if (prefixlen > 128 || prefixlen <= 0) {
       alert("<% multilang("2274" "LANG_INVALID_SOURCE_IPV6_PREFIX_LENGTH"); %>"); //Invalid Source IPv6 prefix length!
       return;
      }
     }
    }
    if(sip6End.value != ""){
     if (! isGlobalIpv6Address(sip6End.value) ){
      alert("<% multilang("2177" "LANG_INVALID_SOURCE_IPV6_END_ADDRESS"); %>"); //Invalid Source IPv6 End address!
      return;
     }
    }
    if(dip6Start.value != ""){
     if (! isGlobalIpv6Address(dip6Start.value) ){
      alert("<% multilang("2178" "LANG_INVALID_DESTINATION_IPV6_START_ADDRESS"); %>"); //Invalid Destination IPv6 Start address!
      return;
     }
     if ( dip6PrefixLen.value != "" ) {
      var prefixlen= getDigit(dip6PrefixLen.value, 1);
      if (prefixlen > 128 || prefixlen <= 0) {
       alert("<% multilang("2276" "LANG_INVALID_DESTINATION_IPV6_PREFIX_LENGTH"); %>"); //Invalid destination IPv6 prefix length!
       return;
      }
     }
    }
    if(dip6End.value != ""){
     if (! isGlobalIpv6Address(dip6End.value) ){
      alert("<% multilang("2181" "LANG_INVALID_DESTINATION_IPV6_END_ADDRESS"); %>"); //Invalid Destination IPv6 End address!
      return;
     }
    }
   }
  }
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form" action="/boaform/admin/formPortFilterBlack" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3394" "LANG_ADD_IP_FILTER_OUT"); %></p>
  <p class="intro_content"><% multilang("3398" "LANG_IP_FILTER_BLKADD_1"); %></p>
  <p class="intro_content"><% multilang("3396" "LANG_IP_FILTER_WHTADD_2"); %></p>
  <p class="intro_content"><% multilang("3397" "LANG_IP_FILTER_WHTADD_3"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=30%><% multilang("3399" "LANG_FILTER_NAME"); %>:</td>
    <td><input type="text" size="22" name="filterName" style="width:150px"></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ipprotbl'>
  <table>
   <tr>
    <th width=30%>IP <% multilang("670" "LANG_VERSION"); %>:</th>
    <td>
     <select id="IpProtocolType" size="1" style="width:150px" onChange="protocolChange()" name="IpProtocolType">
      <option value="1">IPv4</option>
      <option value="2">IPv6</option>
     </select>
    </td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip4protoType'>
  <table>
   <tr>
    <th width=30%><% multilang("93" "LANG_PROTOCOL"); %>:</th>
    <td><select name="protoType" size="1" style="width:150px">
     <option value="5" selected>&nbsp;</option>
     <option value="1">TCP/UDP</option>
     <option value="2">TCP</option>
     <option value="3">UDP</option>
     <option value="4">ICMP</option>
     <option value="0">ANY</option>
     </select>
    </td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip6protoType'>
  <table>
   <tr>
    <th width=30%><% multilang("93" "LANG_PROTOCOL"); %>:</th>
    <td><select name="protoTypeV6" size="1" style="width:150px">
     <option value="5" selected>&nbsp;</option>
     <option value="1">TCP/UDP</option>
     <option value="2">TCP</option>
     <option value="3">UDP</option>
     <option value="4">ICMPV6</option>
     <option value="0">ANY</option>
     </select>
    </td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip4tbl'>
  <table>
       <tr>
       <th width=30%><% multilang("370" "LANG_SOURCE"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>
       <td><input type="text" size="16" name="sipStart" style="width:150px"> - <input type="text" size="16" name="sipEnd" style="width:150px"></td>
       </tr>
       <tr>
       <th width=30%><% multilang("370" "LANG_SOURCE"); %> <% multilang("88" "LANG_SUBNET_MASK"); %>:</th>
       <td><input type="text" size="16" name="smask" style="width:150px"></td>
       </tr>
       <tr>
       <th width=30%><% multilang("371" "LANG_DESTINATION"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>
       <td><input type="text" size="16" name="dipStart" style="width:150px"> - <input type="text" size="16" name="dipEnd" style="width:150px"></td>
       </tr>
       <tr>
       <th width=30%><% multilang("371" "LANG_DESTINATION"); %><% multilang("88" "LANG_SUBNET_MASK"); %>:</th>
       <td><input type="text" size="16" name="dmask" style="width:150px"></td>
       </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip6tbl'>
  <table>
       <tr>
       <th width=30%><% multilang("370" "LANG_SOURCE"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>
       <td><input type="text" size="16" name="sip6Start" style="width:150px"> - <input type="text" size="16" name="sip6End" style="width:150px"></td>
       </tr>
       <tr>
       <th width=30%><% multilang("370" "LANG_SOURCE"); %> <% multilang("445" "LANG_PREFIX_LENGTH"); %>:</th>
       <td><input type="text" size="16" name="sip6PrefixLen" style="width:150px"></td>
       </tr>
       <tr>
       <th width=30%><% multilang("371" "LANG_DESTINATION"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>
       <td><input type="text" size="16" name="dip6Start" style="width:150px"> - <input type="text" size="16" name="dip6End" style="width:150px"></td>
       </tr>
       <tr>
       <th width=30%><% multilang("371" "LANG_DESTINATION"); %> <% multilang("445" "LANG_PREFIX_LENGTH"); %>:</th>
       <td><input type="text" size="16" name="dip6PrefixLen" style="width:150px"></td>
       </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle">
  <table>
       <tr>
       <th width=30%><% multilang("370" "LANG_SOURCE"); %> <% multilang("199" "LANG_PORT"); %>:</th>
       <td><input type="text" size="6" name="sportStart" style="width:150px"> - <input type="text" size="6" name="sportEnd" style="width:150px"></td>
       </tr>
       <tr>
       <th width=30%><% multilang("371" "LANG_DESTINATION"); %> <% multilang("199" "LANG_PORT"); %>:</th>
       <td><input type="text" size="6" name="dportStart" style="width:150px"> - <input type="text" size="6" name="dportEnd" style="width:150px"></td>
       </tr>
  </table>
 </div>
 <div class="btn_ctl">
  <INPUT type="button" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick="on_submit();">
  <input type="hidden" id="action" name="action" value="ad">
  <input type="hidden" name="submit-url" value="/secu_portfilter_blk.asp">
 </div>
 </form>
</body>
<%addHttpNoCache();%>
</html>
