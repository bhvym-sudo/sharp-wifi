<%SendWebHeadStr(); %>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT >
var cgi = new Object();
var rules = new Array();
with(rules){<% initPageURL(); %>}
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
 if(cgi.urlfilterEnble == false)
 {
  form.urlFilterMode[0].disabled = true;
  form.urlFilterMode[1].disabled = true;
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
  row.align = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = rules[i].url;
  cell.align = "left";
  cell = row.insertCell(1);
  //cell.innerHTML = rules[i].port;
  //cell = row.insertCell(2);
  cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
 }
}
function addClick()
{
   var loc = "secu_urlfilter_add.asp";
   var code = "window.location.href=\"" + loc + "\"";
   eval(code);
}
function on_action(act)
{
 form.action.value = act;
 if(act == "rm" && rules.length > 0)
 {
  //form.bcdata.value = sji_encode(rules, "select");
  form.bcdata.value = sji_idxencode(rules, "select", "idx");
 }
 with(form)
 {
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <blockquote>
   <form id="form" action=/boaform/admin/formURL method=POST name="form">
    <div class="intro_main ">
     <p class="intro_title"><% multilang("3003" "LANG_URL_FILTER_DESCRIBE"); %></p>
    </div>
    <div class="data_common data_common_notitle">
     <table>
      <tr>
       <th width=30%><% multilang("1209" "LANG_URL_BLOCKING"); %>:</th>
       <td width=35%><input type="radio" name="urlfilterEnble" value="off" onClick="on_action('sw')">&nbsp;&nbsp;<% multilang("233" "LANG_DISABLE"); %></td>
       <td><input type="radio" name="urlfilterEnble" value="on" onClick="on_action('sw')">&nbsp;&nbsp;<% multilang("234" "LANG_ENABLE"); %></td>
      </tr>
      <tr>
       <th width=30%><% multilang("360" "LANG_FILTERING"); %><% multilang("129" "LANG_MODE"); %>:</th>
       <td width=35%><input type="radio" name="urlFilterMode" value="off" onClick="on_action('md')">&nbsp;&nbsp;<% multilang("2697" "LANG_BLACK_LIST"); %></td>
       <td><input type="radio" name="urlFilterMode" value="on" onClick="on_action('md')">&nbsp;&nbsp;<% multilang("2696" "LANG_WHITE_LIST"); %></td>
      </tr>
     </table>
    </div>
    <br>
    <div class="data_common data_common_notitle data_vertical">
     <table id="rulelst">
      <tr align="center" class="hd">
       <th width=50%>URL <% multilang("2997" "LANG_ADDRESS"); %></th>
       <!--<td><% multilang("199" "LANG_PORT"); %></td>-->
       <th><% multilang("289" "LANG_DELETE"); %></th>
      </tr>
     </table>
    </div>
    <br>
    <div class="btn_ctl">
     <input type="button" class="link_bg" name="add" onClick="addClick()" value="<% multilang("207" "LANG_ADD"); %>">
     <input type="button" class="link_bg" name="remove" onClick="on_action('rm')" value="<% multilang("289" "LANG_DELETE"); %>">
     <input type="hidden" id="action" name="action" value="none">
     <input type="hidden" name="bcdata" value="le">
     <input type="hidden" name="submit-url" value="" >
    </div>
   </form>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
