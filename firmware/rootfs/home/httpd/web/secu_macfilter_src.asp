<%SendWebHeadStr(); %>
<TITLE>WAN</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
var cgi = new Object();
var rules = new Array();
with(rules){<% rteMacFilterList(); %>}
function on_chkclick(index)
{
 if(index < 0 || index >= rules.length)
  return;
 rules[index].select = !rules[index].select;
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
 if(cgi.macFilterEnble == false)
 {
  /*Modefied by jzh in 2019-09-27 for bug#0003805*/
  form.macFilterMode[0].disabled = true;
  form.macFilterMode[1].disabled = true;
  form.apply.disabled = true;
  /*end of bug#0003805*/
  form.add.disabled = true;
  form.remove.disabled = true;
  document.getElementById("macfilter_list").style.display="none";
 }
 if(rulelst.rows)
 {
  while(rulelst.rows.length > 1)
   rulelst.deleteRow(1);
 }
 for(var i = 0; i < rules.length; i++)
 {
  var row = rulelst.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  var cell; // = row.insertCell(0);
  //cell.innerHTML = rules[i].devname;
  cell = row.insertCell(0);
  cell.innerHTML = rules[i].mac;
  cell = row.insertCell(1);
  cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
 }
 if(rules.length == 0)
 {
  form.remove.disabled = true;
 }
}
function addClick()
{
   var loc = "secu_macfilter_src_add.asp";
   var code = "window.location.href=\"" + loc + "\"";
   eval(code);
}
function removeClick()
{
 with ( document.forms[0] )
 {
  form.bcdata.value = sji_encode(rules, "select");
  submit();
 }
}
function on_action(act)
{
 form.action.value = act;
 with(form)
 {
  submit();
 }
}
/**-Modefied by jzh in 2019-09-27 for bug#0003805-**/
function choseMode(act)
{
 form.action.value = act;
 with(form)
 {
  submit();
 }
}
function btnApply()
{
 on_action('mode');
 form.submit();
}
/**-end of bug#0003805-**/
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <blockquote>
  <form id="form" action=/boaform/admin/formRteMacFilter method=POST name="form">
  <div class="intro_main ">
   <p class="intro_title"><% multilang("18" "LANG_MAC_FILTERING"); %></p>
   <!--
   <p class="intro_content"><% multilang("3058" "LANG_MAX_16_RULES"); %></p>
   -->
   <!---Modefied by jzh in 2019-09-27 for bug#0003805--->
   <p class="intro_content"><% multilang("3063" "LANG_WHITE_LIST_COMMENT"); %></p>
   <!--end of bug#0003805-->
  </div>
  <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width=30%><% multilang("18" "LANG_MAC_FILTERING"); %>:</th>
     <td width=35%><input type="radio" name="macFilterEnble" value="off" onClick="on_action('sw')">&nbsp;&nbsp;<% multilang("233" "LANG_DISABLE"); %></td>
     <td><input type="radio" name="macFilterEnble" value="on" onClick="on_action('sw')">&nbsp;&nbsp;<% multilang("234" "LANG_ENABLE"); %></td>
    </tr>
    <!---Modefied by jzh in 2019-09-27 for bug#0003805--->
    <tr>
     <th width=30%><% multilang("360" "LANG_FILTERING"); %><% multilang("129" "LANG_MODE"); %>:</th>
     <td width=35%><input type="radio" name="macFilterMode" value="off" onClick="choseMode('getMode')">&nbsp;&nbsp;<% multilang("2697" "LANG_BLACK_LIST"); %></td>
     <td><input type="radio" name="macFilterMode" value="on" onClick="choseMode('getMode')">&nbsp;&nbsp;<% multilang("2696" "LANG_WHITE_LIST"); %></td>
    </tr>
    <!--end of bug#0003805-->
   </table>
  </div>
  <div class="data_common data_common_notitle data_vertical">
   <table id="rulelst">
     <tr align="center">
       <!--<td><% multilang("3479" "LANG_LAN_DEVICE_NAME"); %></td>-->
     <th width=50%><% multilang("370" "LANG_SOURCE"); %> MAC</th>
     <th><% multilang("289" "LANG_DELETE"); %></th>
     </tr>
   </table>
  </div>
  <br>
  <div class="btn_ctl">
   <input type="button" name="add" class="link_bg" onClick="addClick()" value="<% multilang("207" "LANG_ADD"); %>">
   <input type="button" name="remove" class="link_bg" onClick="removeClick()" value="<% multilang("289" "LANG_DELETE"); %>">
   <!---Modefied by jzh in 2019-09-27 for bug#0003805----->
   <input type="button" name="apply" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick="btnApply()">
   <!---end of bug#0003805---->
   <input type="hidden" name="action" value="rm">
   <input type="hidden" name="bcdata" value="le">
   <input type="hidden" name="submit-url" value="">
  </div>
  </form>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
