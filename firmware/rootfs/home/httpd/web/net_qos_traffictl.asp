<%SendWebHeadStr(); %>
<TITLE>QoS Bandwith Settings</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
.STYLE1 {color: #FF0000}
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
<!--var protos = new Array("", "TCP", "UDP", "ICMP", "TCP/UDP", "RTP");-->
var protos = new Array("", "TCP", "UDP", "ICMP");
var traffictlRules = new Array();
var totalBandwidth = 1000;
var totalBandWidthEn = 0;
<% initTraffictlPage(); %>
function on_chkdel(index) {
 if(index<0 || index>=traffictlRules.length)
  return;
 traffictlRules[index].select = !traffictlRules[index].select;
}
/********************************************************************
**          on document load
********************************************************************/
function on_init_page(){
 if (totalBandWidthEn == 0) {//to apply
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('apply').style.display = 'block';
   document.getElementById('cancel').style.display = 'none';
  } else {
   document.all.apply.style.display = 'block';
   document.all.cancel.style.display = 'none';
  }
 } else {//to cancel
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('apply').style.display = 'none';
   document.getElementById('cancel').style.display = 'block';
  } else {
   document.all.apply.style.display = 'none';
   document.all.cancel.style.display = 'block';
  }
 }
 with(document.forms[0]) {
  totalbandwidth.value = totalBandwidth;
  if(traffictl_tbl.rows){
   while(traffictl_tbl.rows.length > 1)
    traffictl_tbl.deleteRow(1);
  }
  for(var i = 0; i < traffictlRules.length; i++)
  {
   var row = traffictl_tbl.insertRow(i + 1);
   row.nowrap = true;
   row.vAlign = "center";
   row.align = "left";
   var cell_index=0;
   var cell = row.insertCell(cell_index++);
   cell.innerHTML = traffictlRules[i].id;
   /*cell = row.insertCell(1);
			cell.innerHTML = traffictlRules[i].inf;
			*/
   cell = row.insertCell(cell_index++);
   cell.innerHTML = protos[traffictlRules[i].proto];
   cell = row.insertCell(cell_index++);
   if (traffictlRules[i].sport == "0")
    cell.innerHTML = "";
   else
    cell.innerHTML = traffictlRules[i].sport;
   cell = row.insertCell(cell_index++);
   if (traffictlRules[i].dport == "0")
    cell.innerHTML = "";
   else
    cell.innerHTML = traffictlRules[i].dport;
   cell = row.insertCell(cell_index++);
   // For IPv4 and IPv6 
   if ( <%checkWrite("IPv6Show");%> ) {
    // For IPv4
    if ( traffictlRules[i].IpProtocolType == "1 ") {
     if (traffictlRules[i].srcip == "0.0.0.0")
      cell.innerHTML = "";
     else
      cell.innerHTML = traffictlRules[i].srcip;
    }
    // For IPv6
    else if ( traffictlRules[i].IpProtocolType == "2" ) {
     if (traffictlRules[i].sip6 == "::")
      cell.innerHTML = "";
     else {
      cell.innerHTML = traffictlRules[i].sip6;
     }
    }
   }
   // For IPv4
   else {
    if (traffictlRules[i].srcip == "0.0.0.0")
     cell.innerHTML = "";
    else
     cell.innerHTML = traffictlRules[i].srcip;
   }
   cell = row.insertCell(cell_index++);
   // For IPv4 and IPv6 
   if ( <%checkWrite("IPv6Show");%> ) {
    // For IPv4
    if ( traffictlRules[i].IpProtocolType == "1") {
     if (traffictlRules[i].dstip == "0.0.0.0")
      cell.innerHTML = "";
     else
      cell.innerHTML = traffictlRules[i].dstip;
    }
    // For IPv6
    else if ( traffictlRules[i].IpProtocolType == "2" ) {
     if (traffictlRules[i].dip6 == "::")
      cell.innerHTML = "";
     else {
      cell.innerHTML = traffictlRules[i].dip6;
     }
    }
   }
   // For IPv4
   else {
    if (traffictlRules[i].dstip == "0.0.0.0")
     cell.innerHTML = "";
    else
     cell.innerHTML = traffictlRules[i].dstip;
   }
   cell = row.insertCell(cell_index++);
   cell.innerHTML = traffictlRules[i].rate;
   cell = row.insertCell(cell_index++);
   cell.align = "center";
   cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkdel(" + i + ");\">";
   cell = row.insertCell(cell_index++);
   if ( <%checkWrite("IPv6Show");%> ) {
    if (traffictlRules[i].IpProtocolType == "1")
     cell.innerHTML = "IPv4";
    else if (traffictlRules[i].IpProtocolType == "2")
     cell.innerHTML = "IPv6";
   }
   else {
    cell.innerHTML = "IPv4";
   }
   //·½Ïò
   cell = row.insertCell(cell_index++);
   if (traffictlRules[i].direction =="0")
    cell.innerHTML = "<% multilang("1718" "LANG_TUPSTREAM"); %>";
   else
    cell.innerHTML = "<% multilang("1717" "LANG_TDOWNSTREAM"); %>";
  }
 }
}
//Apply bandwith
function on_apply_bandwidth(){
 with(document.forms[0]) {
  var sbmtstr = "";
  var bandwidth = -1;
  bandwidth = parseInt(totalbandwidth.value);
  if(bandwidth<0 || bandwidth >Number.MAX_VALUE)
   return;
  sbmtstr = "applybandwidth&bandwidth="+bandwidth;
  lst.value = sbmtstr;
  submit();
 }
}
//Canel bandwith limited
function on_cancel_bandwidth(){
 with(document.forms[0]) {
  var sbmtstr = "";
  sbmtstr = "cancelbandwidth";
  lst.value = sbmtstr;
  submit();
 }
}
//Control rules
function on_submit(){
 var sbmtstr = "applysetting#id=";
 var firstFound = true;
 for(var i=0; i<traffictlRules.length; i++)
 {
  if(traffictlRules[i].select)
  {
   if(!firstFound)
    sbmtstr += "|";
   else
    firstFound = false;
   sbmtstr += traffictlRules[i].id;
  }
 }
 document.forms[0].lst.value = sbmtstr;
 document.forms[0].submit();
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init_page();">
<blockquote>
 <form id="form" action="/boaform/admin/formQosTraffictl" method="post">
 <div class="intro_main ">
  <p class="intro_title">IP QoS <% multilang("41" "LANG_TRAFFIC_SHAPING"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr><th width=40%><% multilang("660" "LANG_TOTAL_BANDWIDTH_LIMIT"); %>:</th><td><input type="text" id="totalbandwidth" value="1005">Kb</td></tr>
  </table>
 </div>
 <div class="data_common data_common_notitle data_vertical" >
  <table id="traffictl_tbl">
   <tr align="center" nowrap>
    <th>ID</th>
    <th><% multilang("93" "LANG_PROTOCOL"); %></th>
    <th><% multilang("373" "LANG_SOURCE_PORT"); %></th>
    <th><% multilang("374" "LANG_DESTINATION_PORT"); %></th>
    <th><% multilang("370" "LANG_SOURCE"); %> IP</th>
    <th><% multilang("371" "LANG_DESTINATION"); %> IP</th>
    <th><% multilang("635" "LANG_RATE"); %>(kb/s)</th>
    <th><% multilang("289" "LANG_DELETE"); %></th>
    <th>IP <% multilang("670" "LANG_VERSION"); %></th>
    <th><% multilang("366" "LANG_DIRECTION"); %></th>
   </tr>
  </table>
 </div>
 <br><br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="location.href='net_qos_traffictl_edit.asp';" value="<% multilang("207" "LANG_ADD"); %>">&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="button" class="link_bg" onClick="on_submit();" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>">&nbsp;&nbsp;&nbsp;&nbsp;
 </div>
 <br>
 <div class="btn_ctl" id="apply" style="display:none">
  <input type="button" class="link_bg" onClick="on_apply_bandwidth();" value="<% multilang("636" "LANG_APPLY_TOTAL_BANDWIDTH_LIMIT"); %>">
 </div>
 <div class="btn_ctl" id="cancel" style="display:none">
  <input type="button" class="link_bg" onClick="on_cancel_bandwidth();" value="<% multilang("674" "LANG_CANCEL_TOTAL_BANDWIDTH_LIMIT"); %>">
 </div>
   <input type="hidden" id="lst" name="lst" value="">
   <input type="hidden" name="submit-url" value="/net_qos_traffictl.asp">
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
