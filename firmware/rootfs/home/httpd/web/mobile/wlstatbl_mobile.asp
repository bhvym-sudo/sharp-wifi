<%SendWebHeadStr("mobile_normal_4"); %>
<title></title>
</head>
<body>
<form action=/boaform/admin/formWirelessTbl method=POST name="formWirelessTbl">
<div id="header">
         <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
        <div class="clear"></div>
</div>
<div class="page">
 <div class="simplebox">
  <table class="tabletitle">
   <tr>
    <td><% multilang("142" "LANG_ACTIVE_WLAN_CLIENTS"); %></td>
   </tr>
  </table>
<table class="tabledata">
 <thead>
  <tr align="center">
   <th><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
   <th><% multilang("144" "LANG_TX_PACKETS"); %></th>
   <th><% multilang("145" "LANG_RX_PACKETS"); %></th>
   <th><% multilang("146" "LANG_TX_RATE_MBPS"); %></th>
   <th><% multilang("147" "LANG_POWER_SAVING"); %></th>
   <th><% multilang("148" "LANG_EXPIRED_TIME_SEC"); %></th>
  </tr>
 </thead>
 <tbody>
 <% wirelessClientList(); %>
 </tbody>
</table>
<br><br>
 <input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
 <input type="hidden" value="/mobile/wlstatbl_mobile.asp" name="submit-url">
 <input class="submit-button" type="submit" value="<% multilang("414" "LANG_REFRESH"); %>" name="refresh">&nbsp;&nbsp;
 <input class="submit-button" type="button" value=" <% multilang("708" "LANG_CLOSE"); %> " name="close" onClick="javascript: window.close();">
<br><br>
            <div class="topbutton"><a href="#"><span>Top</span></a></div>
            <div class="footer"><a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a></div>
      <div class="clear"></div>
      </div>
</div>
</form>
</body>
</html>
