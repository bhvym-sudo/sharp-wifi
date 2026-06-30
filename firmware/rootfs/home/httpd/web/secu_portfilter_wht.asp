<%SendWebHeadStr(); %>
<TITLE>IP filter settings</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
var protos = new Array("", "TCP/UDP", "TCP", "UDP", "ICMP");
var ipv6_protos = new Array("", "TCP/UDP", "TCP", "UDP", "ICMPV6");
var rcs = new Array();
with(rcs){<% ipPortFilterWhitelist(); %>}
function on_chkclick(index)
{
 if(index < 0 || index >= rcs.length)
  return;
 rcs[index].select = !rcs[index].select;
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document);
 if(lstrc.rows){while(lstrc.rows.length > 1) lstrc.deleteRow(1);}
 for(var i = 0; i < rcs.length; i++)
 {
  var row = lstrc.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  row.align = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = rcs[i].filterName;
  cell = row.insertCell(1);
  // For IPv4 and IPv6
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if ( rcs[i].IpProtocolType == "1" ) {
    cell.innerHTML = protos[rcs[i].protoType];
   }
   // For IPv6
   else if ( rcs[i].IpProtocolType == "2" ) {
    cell.innerHTML = ipv6_protos[rcs[i].protoType];
   }
  }
  // For IPv4 only
  else {
   cell.innerHTML = protos[rcs[i].protoType];
  }
  cell = row.insertCell(2);
  // For IPv4 and IPv6
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if ( rcs[i].IpProtocolType == "1" ) {
    if(rcs[i].sipStart != "0.0.0.0")cell.innerHTML = rcs[i].sipStart + ((rcs[i].sipEnd == "0.0.0.0") ? "" : ("-" + rcs[i].sipEnd));
   }
   // For IPv6
   else if ( rcs[i].IpProtocolType == "2" ) {
    if(rcs[i].sip6Start != "::")cell.innerHTML = rcs[i].sip6Start + ((rcs[i].sip6End == "::") ? "" : ("-" + rcs[i].sip6End));
   }
  }
  // For IPv4 only
  else {
   if(rcs[i].sipStart != "0.0.0.0")cell.innerHTML = rcs[i].sipStart + ((rcs[i].sipEnd == "0.0.0.0") ? "" : ("-" + rcs[i].sipEnd));
  }
  cell = row.insertCell(3);
  // For IPv4 and IPv6
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if ( rcs[i].IpProtocolType == "1" ) {
    if(rcs[i].smask != "0.0.0.0")cell.innerHTML = rcs[i].smask;
   }
   // For IPv6
   else if ( rcs[i].IpProtocolType == "2" ) {
    if(rcs[i].sip6PrefixLen != "")cell.innerHTML = rcs[i].sip6PrefixLen;
   }
  }
  // For IPv4 only
  else {
   if(rcs[i].smask != "0.0.0.0")cell.innerHTML = rcs[i].smask;
  }
  cell = row.insertCell(4);
  if(rcs[i].sportStart != 0) cell.innerHTML = rcs[i].sportStart + ((rcs[i].sportEnd == rcs[i].sportStart) ? "" : ("-" + rcs[i].sportEnd));
  cell = row.insertCell(5);
  // For IPv4 and IPv6
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if ( rcs[i].IpProtocolType == "1" ) {
    if(rcs[i].dipStart != "0.0.0.0")cell.innerHTML = rcs[i].dipStart + ((rcs[i].dipEnd == "0.0.0.0") ? "" : ("-" + rcs[i].dipEnd));
   }
   // For IPv6
   else if ( rcs[i].IpProtocolType == "2" ) {
    if(rcs[i].dip6Start != "::")cell.innerHTML = rcs[i].dip6Start + ((rcs[i].dip6End == "::") ? "" : ("-" + rcs[i].dip6End));
   }
  }
  // For IPv4 only
  else {
   if(rcs[i].dipStart != "0.0.0.0")cell.innerHTML = rcs[i].dipStart + ((rcs[i].dipEnd == "0.0.0.0") ? "" : ("-" + rcs[i].dipEnd));
  }
  cell = row.insertCell(6);
  // For IPv4 and IPv6
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if ( rcs[i].IpProtocolType == "1" ) {
    if(rcs[i].dmask != "0.0.0.0")cell.innerHTML = rcs[i].dmask;
   }
   // For IPv6
   else if ( rcs[i].IpProtocolType == "2" ) {
    if(rcs[i].dip6PrefixLen != "")cell.innerHTML = rcs[i].dip6PrefixLen;
   }
  }
  // For IPv4 only
  else {
   if(rcs[i].dmask != "0.0.0.0")cell.innerHTML = rcs[i].dmask;
  }
  cell = row.insertCell(7);
  if(rcs[i].dportStart != 0) cell.innerHTML = rcs[i].dportStart + ((rcs[i].dportEnd == rcs[i].dportStart) ? "" : ("-" + rcs[i].dportEnd));
  cell = row.insertCell(8);
  cell.align = "center";
  cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
  cell = row.insertCell(9);
  if ( <%checkWrite("IPv6Show");%> ) {
   if (rcs[i].IpProtocolType == "1")
    cell.innerHTML = "IPv4";
   else if (rcs[i].IpProtocolType == "2")
    cell.innerHTML = "IPv6";
  }
  else {
   cell.innerHTML = "IPv4";
  }
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with ( document.forms[0] )
 {
  //form.bcdata.value = sji_encode(rcs, "select");
  form.bcdata.value = sji_varencode(rcs, "select", "filterName");
  if(!(form.bcdata.value == null || form.bcdata.value.length==2))
   submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form" action="/boaform/admin/formPortFilterWhite" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("2696" "LANG_WHITE_LIST"); %> <% multilang("224" "LANG_CONFIGURATION"); %></p>
  <p class="intro_content"><% multilang("3688" "LANG_WHITE_LIST_NOTE2"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lstrc">
   <tr align="center" nowrap>
    <th><% multilang(LANG_FILTER); %> <% multilang("667" "LANG_NAME"); %></th>
    <th><% multilang("93" "LANG_PROTOCOL"); %></th>
    <th><% multilang("370" "LANG_SOURCE"); %> IP <% multilang("2997" "LANG_ADDRESS"); %></th>
    <th><% multilang("370" "LANG_SOURCE"); %> <% multilang("88" "LANG_SUBNET_MASK"); %></th>
    <th><% multilang("370" "LANG_SOURCE"); %> <% multilang("199" "LANG_PORT"); %></th>
    <th><% multilang("371" "LANG_DESTINATION"); %> IP <% multilang("2997" "LANG_ADDRESS"); %></th>
    <th><% multilang("371" "LANG_DESTINATION"); %> <% multilang("88" "LANG_SUBNET_MASK"); %></th>
    <th><% multilang("371" "LANG_DESTINATION"); %> <% multilang("199" "LANG_PORT"); %></th>
    <th><% multilang("289" "LANG_DELETE"); %></th>
    <th>IP <% multilang("670" "LANG_VERSION"); %></th>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
   <input type="button" class="link_bg" onClick="location.href='secu_portfilter_whtadd.asp';" value="<% multilang("207" "LANG_ADD"); %>">
   <input type="button" class="link_bg" onClick="on_submit();" value="<% multilang("289" "LANG_DELETE"); %>">
   <input type="hidden" id="action" name="action" value="rm">
   <input type="hidden" name="bcdata" value="le">
   <input type="hidden" name="submit-url" value="">
 </div>
 </form>
</body>
<%addHttpNoCache();%>
</html>
