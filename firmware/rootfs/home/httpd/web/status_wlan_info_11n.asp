<% SendWebHeadStr();%>
<meta http-equiv="refresh" content="5">
<title><% multilang("3551" "LANG_STD_DEVICE_TITLE"); %></title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<SCRIPT>
var rcs = new Array();
<% wlStatsList(); %>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 if (lsteth.rows) {
  while (lsteth.rows.length > 2)
   lsteth.deleteRow(2);
 }
 for (var i = 0; i < rcs.length; i++) {
  var row = lsteth.insertRow(i + 2);
  row.nowrap = true;
  row.style.verticalAlign = "top";
  row.style.textAlign = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = rcs[i].ifname;
  cell = row.insertCell(1);
  cell.innerHTML = rcs[i].rx_packets;
  cell = row.insertCell(2);
  cell.innerHTML = rcs[i].rx_bytes;
  cell = row.insertCell(3);
  cell.innerHTML = rcs[i].rx_errors;
  cell = row.insertCell(4);
  cell.innerHTML = rcs[i].rx_dropped;
  cell = row.insertCell(5);
  cell.innerHTML = rcs[i].tx_packets;
  cell = row.insertCell(6);
  cell.innerHTML = rcs[i].tx_bytes;
  cell = row.insertCell(7);
  cell.innerHTML = rcs[i].tx_errors;
  cell = row.insertCell(8);
  cell.innerHTML = rcs[i].tx_dropped;
 }
}
function get_rate(curRate, band, auto, rf_num)
{
 var rate, mask, i;
 var rate_mask =
     new Array(15, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 4,
        4, 4, 8, 8, 8, 8, 8, 8, 8, 8);
 var rate_name =
     new Array("Auto", "1M", "2M", "5.5M", "11M", "6M", "9M", "12M",
        "18M", "24M", "36M", "48M", "54M", "MCS0", "MCS1",
        "MCS2", "MCS3", "MCS4", "MCS5", "MCS6", "MCS7", "MCS8",
        "MCS9", "MCS10", "MCS11", "MCS12", "MCS13", "MCS14",
        "MCS15");
 var vht_rate_name =
     ["NSS1-MCS0", "NSS1-MCS1", "NSS1-MCS2", "NSS1-MCS3", "NSS1-MCS4",
      "NSS1-MCS5", "NSS1-MCS6", "NSS1-MCS7", "NSS1-MCS8", "NSS1-MCS9",
      "NSS2-MCS0", "NSS2-MCS1", "NSS2-MCS2", "NSS2-MCS3", "NSS2-MCS4",
      "NSS2-MCS5", "NSS2-MCS6", "NSS2-MCS7", "NSS2-MCS8", "NSS2-MCS9"];
 mask = 0;
 if (auto)
  curRate = 0;
 /* 802.11B */
 if (band & 1)
  mask |= 1;
 /* 802.11G or 802.11A */
 if ((band & 2) || (band & 4))
  mask |= 2;
 /* 802.11N */
 if (band & 8) {
  if (rf_num == 2)
   mask |= 12;
  else
   mask |= 4;
 }
 /* 802.11ac */
 if (band & 64) {
  mask |= 16;
 }
 for (i = 0; i < rate_mask.length; i++) {
  if (rate_mask[i] & mask) {
   rate = (i == 0) ? 0 : 1 << (i - 1);
   if (curRate == rate) {
    document.write(rate_name[i]);
   }
  }
 }
 for (i = 0; i < vht_rate_name.length; i++) {
  rate = (((1 << 31) >>> 0) + i);
  if (curRate == rate) {
   document.write(vht_rate_name[i]);
  }
 }
}
var wlan_num = <% checkWrite("wlan_num"); %>;
var auto=new Array();
var txrate=new Array();
var band=new Array();
var ssid_drv=new Array();
var channel_drv=new Array();
var bssid_drv=new Array();
var wlanDisabled=new Array();
var wlanSsidAttr=new Array();
var encryptState=new Array();
var wlDefChannel=new Array();
var rf_used=new Array();
var ssid_alias=new Array();
var mssid_num;
var mssid_alias=[[],[]];
var mssid_disable=[[],[]];
var mssid_bssid_drv=[[],[]];
var mssid_band=[[],[]];
var mssid_ssid_drv=[[],[]];
var mssid_wlanSsidAttr=[[],[]];
var mssid_encryptState=[[],[]];
var Band2G5GSupport=new Array();
var wlan_root_interface_up = new Array();
var wlan_module_enable = <% checkWrite("wlan_module_enable"); %>;
var wlan_rate_prior = new Array();
</script>
</head>
<body onLoad="on_init();">
<blockquote>
 <div class="intro_main ">
  <p class="intro_title">WLAN <% multilang("68" "LANG_INTERFACE"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
<script>
<% wlStatus_parm(); %>
<% wlan_interface_status(); %>
document.write('<tr><th width="40%"><% multilang("8" "LANG_WLAN"); %><% multilang("237" "LANG_STATE"); %></th><td>');
if(!wlan_module_enable)
 document.write('<% multilang(Disabled); %>');
else
 document.write('<% multilang("164" "LANG_ENABLED"); %>');
document.write( '</td></tr>');
if(wlan_module_enable){
for(i=0; i < wlan_num; i++){
 if(!wlanDisabled[i]){
 document.write('<tr><th width=40%>SSID-'+(i*(mssid_num+1)+1)+'<% multilang("667" "LANG_NAME"); %></th><td>'+ssid_drv[i]+'</td></tr>');
 }
 if(wlan_root_interface_up[i]){
 document.write('<tr><th width="40%"><% multilang("694" "LANG_CHANNEL"); %></td><td>'+wlDefChannel[i]+'</td></tr>');
 }
 if(!wlanDisabled[i]){
 document.write('<tr><th width=40%><% multilang("635" "LANG_RATE"); %></th><td>');
 get_rate(txrate[i], band[i], auto[i], rf_used[i]);
 document.write('<tr><th width="40%">SSID <% multilang("2974" "LANG_HIDE"); %></th><td>'+wlanSsidAttr[i]+'</td></tr>');
 /* band */
 document.write('<tr> <th width="40%"><% multilang("129" "LANG_MODE"); %></th> <td>');
 if(wlan_rate_prior[i]==1){
  if(Band2G5GSupport[i] == 1) //PHYBAND_2G
   document.write( "2.4 GHz (N)");
  else if(Band2G5GSupport[i] == 2) //PHYBAND_5G
   document.write( "5 GHz (AC)");
 }
 else{
 if (band[i] == 1)
     document.write( "2.4 GHz (B)");
 if (band[i] == 2)
  document.write( "2.4 GHz (G)");
 if (band[i] == 3)
  document.write( "2.4 GHz (B+G)");
 if (band[i] == 4)
  document.write( "5 GHz (A)");
 if (band[i] == 8) {
  if(Band2G5GSupport[i] == 1) //PHYBAND_2G
   document.write( "2.4 GHz (N)");
  else if(Band2G5GSupport[i] == 2) //PHYBAND_5G
   document.write( "5 GHz (N)");
 }
 if (band[i] == 10)
     document.write( "2.4 GHz (G+N)");
    if (band[i] == 11)
     document.write( "2.4 GHz (B+G+N)");
    if (band[i] == 12)
     document.write( "5 GHz (A+N)");
    if (band[i] == 64)
     document.write( "5 GHz (AC)");
    if (band[i] == 72)
     document.write( "5 GHz (N+AC)");
    if (band[i] == 76)
     document.write( "5 GHz (A+N+AC)");
 }
 document.write('</td></tr>');
 document.write('<tr><th width="40%">SSID-'+(i*(mssid_num+1)+1)+'<% multilang("187" "LANG_ENCRYPTION"); %><% multilang("106" "LANG_STATUS_1"); %></th><td>');
 document.write(encryptState[i]+'</td></tr>');
   document.write('<tr><th width="40%">BSSID</th><td>'+bssid_drv[i]+'</td></tr>');
 }
 //if (!wlanDisabled[i]) {
  for (idx=0; idx<mssid_num; idx++) {
   if (!mssid_disable[i][idx]) {
   //	document.write('<tr align="center"><td width="50%" colspan="2">SSID-'+(idx+2+(mssid_num+1)*i)+'</td></tr>');
    document.write('<tr><th width="40%">SSID-'+(idx+2+(mssid_num+1)*i)+'<% multilang("667" "LANG_NAME"); %></th><td>'+mssid_ssid_drv[i][idx]+'</td></tr>');
    document.write('<tr> <th width="40%"><% multilang("129" "LANG_MODE"); %></th> <td>');
    if(wlan_rate_prior[i]==1){
     if(Band2G5GSupport[i] == 1) //PHYBAND_2G
      document.write( "2.4 GHz (N)");
     else if(Band2G5GSupport[i] == 2) //PHYBAND_5G
      document.write( "5 GHz (AC)");
    }
    else{
    if (mssid_band[i][idx] == 1)
     document.write( "2.4 GHz (B)");
    if (mssid_band[i][idx] == 2)
     document.write( "2.4 GHz (G)");
    if (mssid_band[i][idx] == 3)
     document.write( "2.4 GHz (B+G)");
    if (mssid_band[i][idx] == 4)
     document.write( "5 GHz (A)");
    if (mssid_band[i][idx] == 8) {
     if(Band2G5GSupport[i] == 1) //PHYBAND_2G
      document.write( "2.4 GHz (N)");
     else if(Band2G5GSupport[i] == 2) //PHYBAND_5G
      document.write( "5 GHz (N)");
    }
    if (mssid_band[i][idx] == 10)
     document.write( "2.4 GHz (G+N)");
    if (mssid_band[i][idx] == 11)
     document.write( "2.4 GHz (B+G+N)");
    if (mssid_band[i][idx] == 12)
     document.write( "5 GHz (A+N)");
    if (mssid_band[i][idx] == 64)
     document.write( "5 GHz (AC)");
    if (mssid_band[i][idx] == 72)
     document.write( "5 GHz (N+AC)");
    if (mssid_band[i][idx] == 76)
     document.write( "5 GHz (A+N+AC)");
    }
    document.write('</td></tr>');
    document.write('<tr><th width="40%">SSID-'+(idx+2+(mssid_num+1)*i)+'<% multilang("187" "LANG_ENCRYPTION"); %><% multilang("106" "LANG_STATUS_1"); %></th> <td>'+mssid_encryptState[i][idx]+'</td></tr>');
    document.write('<tr><th width="40%">BSSID</th><td>'+mssid_bssid_drv[i][idx]+'</td></tr>');
   }
  }
 //}
 }
}
</script>
  </table>
 </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("136" "LANG_ASSOCIATED_CLIENTS"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table>
   <tr>
    <th width="25%"><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
    <th width="14%"><% multilang("869" "LANG_PACKETS_SENT"); %></th>
    <th width="14%"><% multilang("870" "LANG_PACKETS_RECEIVED"); %></th>
    <th width="12%"><% multilang("2975" "LANG_SEND_RATE"); %> (Mbps)</th>
    <th width="12%">RSSI (dBm)</th>
    <th width="11%"><% multilang("147" "LANG_POWER_SAVING"); %></th>
    <th width="12%"><% multilang("148" "LANG_EXPIRED_TIME_SEC"); %></th>
   </tr>
  <% wirelessClientList(); %>
  </table>
 </div>
 <br>
 <div class="intro_main ">
 <p class="intro_title"><% multilang("2976" "LANG_SEND_RECV"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table>
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
   <% wirelessSendRecvInfo(); %>
  </table>
 </div>
 <br>
</blockquote>
</body>
<!-- add end by liuxiao 2008-01-21 -->
<%addHttpNoCache();%>
</html>
