<%SendWebHeadStr(); %>
<title><% multilang("142" "LANG_ACTIVE_WLAN_CLIENTS"); %></title>
<link rel="stylesheet" type="text/css" href="common_style.css" />
</head>
<body>
<blockquote>
<!-- <h2 class="page_title"><% multilang("142" "LANG_ACTIVE_WLAN_CLIENTS"); %></h2> -->
<div class="intro_main ">
 <p class="intro_title"><% multilang("142" "LANG_ACTIVE_WLAN_CLIENTS"); %></p><br>
 <p class="intro_page"><% multilang("143" "LANG_THIS_TABLE_SHOWS_THE_MAC_ADDRESS"); %></p><br>
</div>
<form action=/boaform/admin/formWirelessTbl method=POST name="formWirelessTbl">
<div class="data_common data_common_notitle data_vertical">
<table>
 <tr>
  <th><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
  <th><% multilang("144" "LANG_TX_PACKETS"); %></th>
  <th><% multilang("145" "LANG_RX_PACKETS"); %></th>
  <th><% multilang("146" "LANG_TX_RATE_MBPS"); %></th>
  <th>RSSI (dBm)</th>
  <th><% multilang("147" "LANG_POWER_SAVING"); %></th>
  <th><% multilang("148" "LANG_EXPIRED_TIME_SEC"); %></th>
 </tr>
 <% wirelessClientList(); %>
</table>
</div>
<br>
<input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
<input type="hidden" value="/admin/wlstatbl.asp" name="submit-url">
  <p><input class="link_bg" type="submit" value="<% multilang("414" "LANG_REFRESH"); %>" name="refresh">&nbsp;&nbsp;
  <input class="link_bg" type="button" value=" <% multilang("708" "LANG_CLOSE"); %> " name="close" onClick="javascript: window.close();"></p>
</form>
</blockquote>
</body>
</html>
