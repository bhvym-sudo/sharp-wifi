<%SendWebHeadStr(); %>
<TITLE>IGMP Setting</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
 var rules = new Array();
with(rules){<% igmproxyList(); %>}
/********************************************************************
**          on document load
********************************************************************/
function on_chkclick(index)
{
 if(index < 0 || index >= rules.length)
  return;
 rules[index].dirty = true;
}
function on_init()
{
 sji_docinit(document);
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
  row.align = "center";
  rules[i].dirty = false;
  var cell = row.insertCell(0);
  cell.innerHTML = rules[i].ifName;
  cell = row.insertCell(1);
  if(rules[i].enable)
   cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\" checked>";
  else
   cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with ( document.forms[0] )
 {
    for(var i = 0; i < rules.length; i++){
    var row=rulelst.rows[i+1];
    var cell = row.cells[1];
     if(cell.children[0].checked==true)
      rules[i].enable =1;
      else
     rules[i].enable =0;
       }
  form.bcdata.value = sji_encode(rules, "dirty");
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action=/boaform/admin/formIgmproxy method=POST>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("2916" "LANG_IGMP_CONFIG"); %></p><br>
  <p class="intro_content"><% multilang("3283" "LANG_IGMP_CONFIG_PAGE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="rulelst">
   <tr align="center">
    <th><% multilang("3285" "LANG_INTERNET_CONNECTION"); %></th>
    <th><% multilang("3284" "LANG_IGMP_ENABLED"); %></th>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="submit" class="link_bg" onClick="on_submit()" value="<% multilang("827" "LANG_SAVE"); %>">
  <input type="hidden" name="bcdata" value="le">
  <input type="hidden" name="submit-url" value="">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
