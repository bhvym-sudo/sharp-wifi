<%SendWebHeadStr(normal_2); %>
<meta http-equiv="refresh" content="5">
<title>HGU</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<SCRIPT language="javascript" type="text/javascript">
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
  <div align="left" style="padding-left:20px;"><br>
   <div align="left"><b>WAN <% multilang("3" "LANG_STATUS"); %></b></div>
   <table class="flat" id="lstrc" border="1" cellpadding="1" cellspacing="1" width="90%">
    <tr class="hdb" align="center" nowrap>
     <!-- Modified by Slim for bug#0003395-->
     <td><% multilang("2968" "LANG_SRV_INTF"); %></td>
     <td>VLAN ID</td>
     <!-- td>Service Type</td>
     <td>Encapsulation</td -->
     <td><% multilang("93" "LANG_PROTOCOL"); %></td>
     <td>IGMP</td>
     <td><% multilang("237" "LANG_STATE"); %></td>
     <td><% multilang("87" "LANG_IP_ADDRESS"); %></td>
     <td><% multilang("88" "LANG_SUBNET_MASK"); %></td>
    </tr>
   </table>
   <br><br>
   <b><% multilang("1275" "LANG_NETWORK"); %> <% multilang("2969" "LANG_INFO"); %></b>
   <br>
   <table class="flat" id="net_info" border="1" cellpadding="1" cellspacing="1" width="90%">
    <tr class="hdb" align="center" nowrap>
     <td><% multilang("2968" "LANG_SRV_INTF"); %></td>
     <td><% multilang("83" "LANG_DEFAULT_GATEWAY"); %></td>
     <td><% multilang("301" "LANG_PRIMARY"); %> <% multilang("1244" "LANG_DNS"); %></td>
     <td><% multilang("302" "LANG_SECONDARY"); %> <% multilang("1244" "LANG_DNS"); %></td>
     <!-- End of bug#0003395-->
    </tr>
   </table>
  </div>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
