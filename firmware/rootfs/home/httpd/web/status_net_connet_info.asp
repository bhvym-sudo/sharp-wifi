<% SendWebHeadStr();%>
<title><% multilang("3551" "LANG_STD_DEVICE_TITLE"); %></title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<SCRIPT>
var links = new Array();
<% listWanConfig(); %>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 if(lstrc.rows){while(lstrc.rows.length > 1) lstrc.deleteRow(1);}
 for(var i = 0; i < links.length; i++)
 {
  var row = lstrc.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  row.align = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = links[i].servName;
  cell = row.insertCell(1);
  cell.innerHTML = links[i].vlanId;
  cell = row.insertCell(2);
//		cell.innerHTML = links[i].servType;
//		cell = row.insertCell(3);
//		cell.innerHTML = links[i].encaps;
//		cell = row.insertCell(4);
  cell.innerHTML = links[i].protocol;
  cell = row.insertCell(3);
  cell.innerHTML = links[i].igmpEnbl ? "<% multilang("164" "LANG_ENABLED"); %>" : "<% multilang("233" "LANG_DISABLE"); %>";
  cell = row.insertCell(4);
  cell.innerHTML = links[i].strStatus;
  cell = row.insertCell(5);
  cell.innerHTML = links[i].ipAddr;
  cell = row.insertCell(6);
  cell.innerHTML = links[i].netmask;
  cell = row.insertCell(7);
  cell.innerHTML = links[i].MacAddr;
 }
 if(net_info.rows){while(net_info.rows.length > 1) net_info.deleteRow(1);}
 for(var i = 0; i < links.length; i++)
 {
  var row = net_info.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  row.align = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = links[i].servName;
  cell = row.insertCell(1);
  cell.innerHTML = links[i].gateway;
  cell = row.insertCell(2);
  cell.innerHTML = links[i].dns1;
  cell = row.insertCell(3);
  cell.innerHTML = links[i].dns2;
 }
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <div class="intro_main">
  <p class="intro_title">WAN <% multilang("3" "LANG_STATUS"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lstrc">
   <tr>
    <th><% multilang("2968" "LANG_SRV_INTF"); %></th>
    <th>VLAN ID</th>
    <th><% multilang("93" "LANG_PROTOCOL"); %></th>
    <th>IGMP</th>
    <th><% multilang("237" "LANG_STATE"); %></th>
    <th><% multilang("87" "LANG_IP_ADDRESS"); %></th>
    <th><% multilang("88" "LANG_SUBNET_MASK"); %></th>
    <th><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
   </tr>
  </table>
 </div>
 <br>
 <div class="intro_main">
  <p class="intro_title"><% multilang("1275" "LANG_NETWORK"); %> <% multilang("2969" "LANG_INFO"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="net_info">
   <tr>
    <th><% multilang("2968" "LANG_SRV_INTF"); %></th>
    <th><% multilang("83" "LANG_DEFAULT_GATEWAY"); %></th>
    <th><% multilang("301" "LANG_PRIMARY"); %><% multilang("1244" "LANG_DNS"); %></th>
    <th><% multilang("302" "LANG_SECONDARY"); %><% multilang("1244" "LANG_DNS"); %></th>
   </tr>
  </table>
 </div>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
