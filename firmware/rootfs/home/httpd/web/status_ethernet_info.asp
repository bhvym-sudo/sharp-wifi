<%SendWebHeadStr(); %>
<title><% multilang("3551" "LANG_STD_DEVICE_TITLE"); %></title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<SCRIPT>
var ethers = new Array();
var clts = new Array();
<% E8BPktStatsList(); %>
<% E8BDhcpClientList(); %>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 if (lsteth.rows) {
  while (lsteth.rows.length > 2)
   lsteth.deleteRow(2);
 }
 for (var i = 0; i < ethers.length; i++) {
  var row = lsteth.insertRow(i + 2);
  row.nowrap = true;
  row.style.verticalAlign = "top";
  row.style.textAlign = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = ethers[i].ifname;
  cell = row.insertCell(1);
  cell.innerHTML = ethers[i].rx_packets;
  cell = row.insertCell(2);
  cell.innerHTML = ethers[i].rx_bytes;
  cell = row.insertCell(3);
  cell.innerHTML = ethers[i].rx_errors;
  cell = row.insertCell(4);
  cell.innerHTML = ethers[i].rx_dropped;
  cell = row.insertCell(5);
  cell.innerHTML = ethers[i].tx_packets;
  cell = row.insertCell(6);
  cell.innerHTML = ethers[i].tx_bytes;
  cell = row.insertCell(7);
  cell.innerHTML = ethers[i].tx_errors;
  cell = row.insertCell(8);
  cell.innerHTML = ethers[i].tx_dropped;
 }
 if (lstdev.rows) {
  while (lstdev.rows.length > 1)
   lstdev.deleteRow(1);
 }
 for (var i = 0; i < clts.length; i++) {
  var row = lstdev.insertRow(i + 1);
  row.nowrap = true;
  row.style.verticalAlign = "top";
  row.style.textAlign = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = clts[i].devname;
  cell = row.insertCell(1);
  cell.innerHTML = clts[i].macAddr;
  cell = row.insertCell(2);
  cell.innerHTML = clts[i].ipAddr;
  cell = row.insertCell(3);
  cell.innerHTML = clts[i].liveTime;
 }
}
</SCRIPT>
</head>
<body onLoad="on_init();">
<blockquote>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("2859" "LANG_DEVICE_INFO"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width="40%"><% multilang("87" "LANG_IP_ADDRESS"); %></th>
    <td><% getInfo("lan-ip"); %></td>
   </tr>
   <tr>
    <th width="40%"><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
    <td><% getInfo("elan-Mac"); %></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("2976" "LANG_SEND_RECV"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lsteth">
   <tr>
    <th><% multilang("68" "LANG_INTERFACE"); %></th>
    <th colspan="4"><% multilang("2977" "LANG_RECV"); %></th>
    <th colspan="4"><% multilang("2978" "LANG_SEND"); %></th>
   </tr>
   <tr>
    <th>&nbsp;</th>
    <th>Packets</th>
    <th>Bytes</th>
    <th>Errors</th>
    <th>Dropped</th>
    <th>Packets</th>
    <th>Bytes</th>
    <th>Errors</th>
    <th>Dropped</th>
    </tr>
  </table>
 </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("802" "LANG_ACTIVE_DHCP_CLIENTS"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lstdev">
   <tr>
    <th><% multilang("4" "LANG_DEVICE"); %><% multilang("274" "LANG_TYPE"); %></th>
    <th><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
    <th><% multilang("87" "LANG_IP_ADDRESS"); %></th>
    <th><% multilang("467" "LANG_LEASE_TIME"); %></th>
   </tr>
  </table>
 </div>
</blockquote>
</body>
<!-- add end by liuxiao 2008-01-21 -->
<%addHttpNoCache();%>
</html>
