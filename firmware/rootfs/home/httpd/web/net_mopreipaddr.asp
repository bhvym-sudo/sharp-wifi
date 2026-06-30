<%SendWebHeadStr(); %>
<TITLE>HGU-DHCP</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
var dmacips = new Array();
<% showMACBaseTable(); %>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document);
 for(var i = 0; i < dmacips.length; i++)
 {
  var row = lstmacip.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  row.align = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = dmacips[i].macAddr_Dhcp;
  cell = row.insertCell(1);
  cell.innerHTML = dmacips[i].ipAddr_Dhcp;
  cell = row.insertCell(2);
  cell.innerHTML = "<a href=\"javascript:removeClick('" + dmacips[i].macAddr_Dhcp + "', '" + dmacips[i].ipAddr_Dhcp + "');\"><img border=\"0\" src=\"image/delete.gif\" alt=\"Delete\"></a>";
 }
}
/********************************************************************
**          on document update
********************************************************************/
function removeClick(mac,ip)
{
 with(document.forms[0])
 {
  action.value = "rm";
  macAddr_Dhcp.value=mac;
  ipAddr_Dhcp.value=ip;
  submit();
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit(act)
{
 with ( document.forms[0] )
 {
  action.value = act;
  if(act == "add")
  {
   var loc = "net_addbindmac.asp";
   var code = "location.assign(\"" + loc + "\")";
   eval(code);
  }
 }
}
 </script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onload="on_init()">
 <form action=/boaform/formMacAddrBase method=POST>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3554" "LANG_RESERVE_IP_ADDRESS_LIST"); %>:</p><br>
  <p class="intro_content"><% multilang("3555" "LANG_RESERVE_IP_ADDRESS_LIST_PAGE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id = "lstmacip">
   <tr>
    <th><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
    <th><% multilang("87" "LANG_IP_ADDRESS"); %></th>
    <th><% multilang("289" "LANG_DELETE"); %></th>
   </tr>
  </table>
 </div>
 <br><br>
 <div class="btn_ctl">
  <table border="0" width="350px" cellpadding="0" cellspacing="0">
    <tr>
    <td align="right">
    <input type="button" class="link_bg" onClick="on_submit('add')" value="<% multilang("207" "LANG_ADD"); %>">
    <input type="hidden" name="submit-url" value="" >
    <input type="hidden" id="action" name="action" value="none">
    <input type="hidden" name="macAddr_Dhcp">
    <input type="hidden" name="ipAddr_Dhcp">
    <input type="button" class="link_bg" onClick="window.close()" value="<% multilang("708" "LANG_CLOSE"); %>"></td>
    </tr>
  </table>
 </div>
 </form>
</body>
<%addHttpNoCache();%>
</html>
