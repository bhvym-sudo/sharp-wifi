<% SendWebHeadStr();%>
<title><% multilang("3551" "LANG_STD_DEVICE_TITLE"); %></title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
</head>
<body>
 <blockquote>
  <div class="intro_main ">
   <p class="intro_title"><% multilang("2859" "LANG_DEVICE_INFO"); %></p><br>
  </div>
  <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width="40%"><% multilang("2786" "LANG_DEVICE_MODEL"); %></th>
    <td><% getInfo("devModel"); %></td>
   </tr>
   <tr>
    <th width="40%"><% multilang("2861" "LANG_DEVICE_SN"); %></th>
    <td><% getInfo("devId"); %></td>
   </tr>
   <tr>
    <th width="40%"><% multilang("2829" "LANG_HARDWARE_VERSION"); %></th>
    <td><% getInfo("hdVer"); %></td>
   </tr>
   <tr>
    <th width="40%"><% multilang("77" "LANG_FIRMWARE_VERSION"); %></th>
    <td><% getInfo("stVer"); %></td>
   </tr>
   <tr>
    <th width="40%"><% multilang("3643" "LANG_SERIAL_NO"); %></th>
    <td><% getInfo("gpon_sn"); %></td>
   </tr>
  </table>
  </div>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
