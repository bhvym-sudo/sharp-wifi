<%SendWebHeadStr(); %>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<SCRIPT>
var count;
var nbTableHtmlString = "";
var staTableHtmlString = "";
function loadInfo() {
    // var urlParams = new URLSearchParams(window.location.search);
    // count = urlParams.get('count');
    var results = new RegExp('[\?&]' + 'count' + '=([^&#]*)').exec(window.location.href);
    count = decodeURI(results[1]) || 0;
 var string_json = '<% checkWrite("topology_json_string"); %>';
 var object_json = JSON.parse(string_json);
    var curr_device = get_device_json(object_json);
    nbTableHtmlString += '<tr bgcolor=#7f7f7f><th width="80">MAC Address</th><th width="100">Name</th><th width="60">RSSI</th><th width="55">Connected Band</th></tr>';
    staTableHtmlString += '<tr bgcolor=#7f7f7f><th width="80">MAC Address</th><th width="30">RSSI</th><th width="55">Connected Band</th><th width="60">Downlink</th><th width="60">Uplink</th></tr>';
    if (0 != curr_device["neighbor_devices"].length) {
        for (nb in curr_device["neighbor_devices"]) {
            nbTableHtmlString += '<tr class="tbl_body"><td><font size=2>';
            nbTableHtmlString += curr_device["neighbor_devices"][nb].neighbor_mac;
            nbTableHtmlString += '</font></td><td><font size=2>';
            nbTableHtmlString += curr_device["neighbor_devices"][nb].neighbor_name;
            nbTableHtmlString += '</font></td><td><font size=2>';
            nbTableHtmlString += curr_device["neighbor_devices"][nb].neighbor_rssi;
            nbTableHtmlString += '</font></td><td><font size=2>';
            nbTableHtmlString += curr_device["neighbor_devices"][nb].neighbor_band;
            nbTableHtmlString += '</font></td></tr>';
        }
    }
    if (0 != curr_device["station_info"].length) {
        for (nb in curr_device["station_info"]) {
            staTableHtmlString += '<tr class="tbl_body"><td><font size=2>';
            staTableHtmlString += curr_device["station_info"][nb].station_mac;
            staTableHtmlString += '</font></td><td><font size=2>';
            staTableHtmlString += curr_device["station_info"][nb].station_rssi;
            staTableHtmlString += '</font></td><td><font size=2>';
            staTableHtmlString += curr_device["station_info"][nb].station_connected_band;
            staTableHtmlString += '</font></td><td><font size=2>';
            staTableHtmlString += curr_device["station_info"][nb].station_downlink;
            staTableHtmlString += '</font></td><td><font size=2>';
            staTableHtmlString += curr_device["station_info"][nb].station_uplink;
            staTableHtmlString += '</font></td></tr>';
        }
    }
    document.getElementById("nbTableContainer").innerHTML = nbTableHtmlString;
 document.getElementById("staTableContainer").innerHTML = staTableHtmlString;
}
var device_counter = 0;
function get_device_json(object_json) {
    device_counter++;
    if (device_counter == count) {
        return object_json;
    }
 // htmlString += '<li>';
 // htmlString += object_json.device_name + ' | ' + object_json.mac_address + ' | <input type="button" value="Show Details" onClick="showDetailOnClick(' + device_counter.toString() + ')">';
 if (0 != object_json["child_devices"].length) {
  for (child_device in object_json["child_devices"]) {
            var return_object = get_device_json(object_json["child_devices"][child_device]);
            if (0 == return_object) {
                continue;
            } else {
                return return_object;
            }
  }
    }
    return 0;
}
</SCRIPT>
</head>
<body onload="loadInfo();">
<blockquote>
<h2 class="page_title"><% multilang("259" "LANG_WLAN_EASY_MESH_DEVICE_DETAILS"); %></h2>
<table>
  <tr><td><font size=2>
 <% multilang("260" "LANG_WLAN_EASY_MESH_DEVICE_DETAILS_DESC"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table>
  <tr>
  <td width="100%" colspan=2><font size=2><b><% multilang("261" "LANG_WLAN_EASY_MESH_NEIGHBOR_RSSI"); %>:</b></td>
  </tr>
</table>
<form action=/boafrm/formWirelessTbl method=POST name="formWirelessTbl">
<table id='nbTableContainer'>
<!-- <tr class="tbl_body"><td><font size=2>f0:25:b7:ce:57:36</td><td><font size=2>Agent1</td><td><font size=2>120</td></tr>
<tr class="tbl_body"><td><font size=2>f0:25:b7:ce:57:36</td><td><font size=2>EasyMesh_Agent</td><td><font size=2>120</td></tr> -->
<!-- <td width="60"><font size=2><b>Rx Packet</b></td>
<td width="60"><font size=2><b>Tx Rate (Mbps)</b></td>
<td width="60"><font size=2><b>Power Saving</b></td>
<td width="60"><font size=2><b>Expired Time (s)</b></td></tr> -->
</table>
<table>
  <tr>
  <td width="100%" colspan=2><font size=2><b><% multilang("262" "LANG_WLAN_EASY_MESH_STA_INFO"); %>:</b></td>
  </tr>
</table>
<table id='staTableContainer'>
<!--
<td width="250"><font size=2><b>SSID</b></td>
-->
<!-- <td width="60"><font size=2><b>Mode</b></td> -->
<!-- <tr class="tbl_body"><td><font size=2>f0:25:b7:ce:57:36</td><td><font size=2>120</td><td><font size=2>5G</td><td><font size=2>100</td><td><font size=2>50</td></tr>
<tr class="tbl_body"><td><font size=2>f0:25:b7:ce:57:36</td><td><font size=2>120</td><td><font size=2>5G</td><td><font size=2>100</td><td><font size=2>50</td></tr>
<tr class="tbl_body"><td><font size=2>f0:25:b7:ce:57:36</td><td><font size=2>120</td><td><font size=2>5G</td><td><font size=2>100</td><td><font size=2>50</td></tr> -->
<!-- <td width="60"><font size=2><b>Expired Time (s)</b></td></tr> -->
</table>
<table>
  <tr><td>
  <input type="hidden" value="/wlstatbl.htm" name="submit-url">
  <input type="button" value="<% multilang("414" "LANG_REFRESH"); %>" class="link_bg" onclick="location.reload(true);">&nbsp;&nbsp;
  <input type="button" value="<% multilang("708" "LANG_CLOSE"); %>" class="link_bg" name="close" onClick="javascript: window.close();">
  </tr></td>
</table>
</form>
</blockquote>
</body>
</html>
