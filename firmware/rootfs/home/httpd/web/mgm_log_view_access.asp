<%SendWebHeadStr(); %>
<title><% multilang("3583" "LANG_SYSTEM_ACCESS_LOG"); %></title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script>
var rcs = new Array();
<% sysLogList(); %>
/*
cgi.mf = "ASB";
cgi.pc = "V1.0";
cgi.sn = "03100200000100100000007404010203";
cgi.ip = "192.168.2.1";
cgi.hv = "V1.0";
cgi.sv = "RG100A_V1.0";
*/
/*
rcs.push(new Array("1900-01-07 01:26:37", "Informational", "kernel: Freeing unused kernel memory: 144k freed"));
rcs.push(new Array("1900-01-07 01:26:37", "Warning", "kernel: EHCI: port status=0x00001000"));
*/
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 if (lstrc.rows) {
  while (lstrc.rows.length > 1)
   lstrc.deleteRow(1);
 }
 for (var i = 0; i < rcs.length; i++) {
  var row = lstrc.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  var cell = row.insertCell(0);
  cell.innerHTML = rcs[i][0];
  cell = row.insertCell(1);
  cell.innerHTML = rcs[i][1];
  cell = row.insertCell(2);
  cell.innerHTML = rcs[i][2];
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3583" "LANG_SYSTEM_ACCESS_LOG"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr><th>Manufacturer:</th><td id="mf"><% getInfo("manufacture"); %></td></tr>
   <tr><th>ProductClass:</th><td id="strModel"><% getInfo("devModel"); %></td></tr>
   <tr><th>SerialNumber:</th><td id="strId"><% getInfo("devId"); %></td></tr>
   <tr><th>IP:</th><td id="ip"><% getInfo("lan-ip"); %></td></tr>
   <tr><th>HWVer:</th><td id="strHdVer"><% getInfo("hdVer"); %></td></tr>
   <tr><th>SWVer:</th><td id="strStVer"><% getInfo("stVer"); %></td></tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
   <input type="button" class="link_bg" onClick="location.href=location.href;" value="<% multilang("414" "LANG_REFRESH"); %>">
   <input type="button" class="link_bg" onClick="window.close();" value="<% multilang("708" "LANG_CLOSE"); %>">
 </div>
 <br>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lstrc">
   <tr>
      <th><% multilang("3584" "LANG_DATE_TIME"); %></th>
      <th><% multilang("3585" "LANG_SEVERITY"); %></th>
      <th><% multilang("2969" "LANG_INFO"); %></th>
   </tr>
  </table>
 </div>
 </form>
</body>
<%addHttpNoCache();%>
</html>
