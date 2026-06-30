<% SendWebHeadStr();%>
<title>CATV INFO</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
</head>
<body>
 <blockquote>
  <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width="40%"><% multilang("3617" "LANG_CATV_SWITCH"); %></th>
     <td><% catvGetStatus("catvCtrl"); %></td>
    </tr>
    <tr>
     <th width="40%"><% multilang("3619" "LANG_CATV_RX_POWER"); %>(dBm)</th>
     <td><% catvGetStatus("rx-power"); %> </td>
    </tr>
    <tr>
     <th width="40%"><% multilang("3620" "LANG_CATV_VOLTAGE"); %>(dBuV)</th>
     <td><% catvGetStatus("Voltage"); %> </td>
    </tr>
   </table>
   </span>
  </div>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
