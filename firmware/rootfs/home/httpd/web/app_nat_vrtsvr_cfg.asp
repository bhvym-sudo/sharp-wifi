<%SendWebHeadStr(); %>
<TITLE>Virtual Server Settings</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT>
var protos = new Array( "TCP/UDP", "TCP", "UDP");
var rcs = new Array();
with(rcs){<% virtualSvrList(); %>}
function on_chkclick(index)
{
 if(index < 0 || index >= rcs.length)
  return;
 rcs[index].select = !rcs[index].select;
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document);
 if(lstrc.rows){while(lstrc.rows.length > 1) lstrc.deleteRow(1);}
 for(var i = 0; i < rcs.length; i++)
 {
  var row = lstrc.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  row.align = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = rcs[i].svrName;
  cell = row.insertCell(1);
  if(rcs[i].enable == "1")
   cell.innerHTML = "enable";
  else
   cell.innerHTML = "disable";
  cell = row.insertCell(2);
  if(rcs[i].remotehost[0] == '0')
   cell.innerHTML = "";
  else
   cell.innerHTML = rcs[i].remotehost;
  cell = row.insertCell(3);
  cell.innerHTML = rcs[i].wanStartPort;
  cell = row.insertCell(4);
  cell.innerHTML = rcs[i].wanEndPort;
  cell = row.insertCell(5);
  cell.innerHTML = protos[rcs[i].protoType];
  cell = row.insertCell(6);
  cell.innerHTML = rcs[i].serverIp;
  cell = row.insertCell(7);
  cell.innerHTML = rcs[i].lanPort;
  cell = row.insertCell(8);
  cell.align = "center";
  cell.innerHTML = "<input type=\"checkbox\" name=\"rml"
    + i + "\" value=\"ON\" onClick=\"on_chkclick(" + i + ");\">";
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with ( document.forms[0] )
 {
  form.bcdata.value = sji_encode(rcs, "select");
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formVrtsrv" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3274" "LANG_NAT_VIRTUAL_SERVER_CONFIGURATION"); %></p><br>
  <p class="intro_content"><% multilang("3275" "LANG_NAT_VIRTUAL_SERVER_CONFIGURATION_PAGE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lstrc">
   <tr align="center" nowrap>
    <th><% multilang("3276" "LANG_SERVER_NAME"); %></th>
    <th><% multilang("234" "LANG_ENABLE"); %></th>
    <th><% multilang("3277" "LANG_EXTERNAL_IP_ADDRESS"); %></th>
    <th><% multilang("3278" "LANG_EXTERNAL_START_PORT"); %></th>
    <th><% multilang("3279" "LANG_EXTERNAL_END_PORT"); %></th>
    <th><% multilang("93" "LANG_PROTOCOL"); %></th>
    <th><% multilang("824" "LANG_SERVER_IP_ADDR"); %></th>
    <th><% multilang("373" "LANG_SOURCE_PORT"); %></th>
    <th><% multilang("289" "LANG_DELETE"); %></th>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="location.href='app_nat_vrtsvr_add.asp';" value="<% multilang("207" "LANG_ADD"); %>">
  <input type="button" class="link_bg" onClick="on_submit();" value="<% multilang("289" "LANG_DELETE"); %>">
  <input type="hidden" id="action" name="action" value="delete">
  <input type="hidden" name="bcdata" value="le">
  <input type="hidden" name="submit-url" value="">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
