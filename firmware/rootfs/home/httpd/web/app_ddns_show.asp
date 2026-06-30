<%SendWebHeadStr(); %>
<title>DDNS</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<SCRIPT>
var cgi = new Object();
var rules = new Array();
with(rules){<% showDNSTable(); %>}
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
 if(rulelst.rows)
 {
  while(rulelst.rows.length > 1){rulelst.deleteRow(1);}
 }
 for(var i = 0; i < rules.length; i++)
 {
  var row = rulelst.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "top";
  var cell = row.insertCell(0);
  cell.innerHTML = rules[i].hostname;
  cell = row.insertCell(1);
  cell.innerHTML = rules[i].username;
  cell = row.insertCell(2);
  cell.innerHTML = rules[i].provider;
  cell = row.insertCell(3);
  cell.innerHTML = rules[i].ifname;
  cell = row.insertCell(4);
  cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
 }
 if(rules.length == 0)
 {
  form.remove.disabled = true;
 }
 if(cgi.ddnsEnable == false)
 {
  document.getElementById("ddnsConfig").style.display = "none";
  return true;
 }
}
function on_action(act)
{
 form.action.value = act;
 if (act == "sw" && !form.ddnsEnable.checked) {
  if (!confirm("<% multilang("3481" "LANG_ARE_YOU_SURE_TO_DISABLE_DDNS_SEVICE"); %>")) {
   form.ddnsEnable.checked = true;
   return;
  }
 }
 if (act == "rm" && rules.length > 0) {
  form.bcdata.value = sji_encode(rules, "select");
 }
 with(form) {
  submit();
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Main code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action=/boaform/admin/formDDNS method=POST name="form">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3484" "LANG_DYNAMIC_DNS_2"); %></p><br>
  <p class="intro_content"><% multilang("3482" "LANG_DDNS_PAGE_1"); %>.</p><br>
  <p class="intro_content"><% multilang("3483" "LANG_DDNS_PAGE_2"); %>.</p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <td width=40% align="center"><% multilang("3480" "LANG_ENABLE_DDNS_SERVICE"); %></td>
    <td width=60% align="center"><input type="checkbox" name="ddnsEnable" onClick="on_action('sw')"></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="data_common data_common_notitle data_vertical">
  <table id="rulelst">
   <tr class="hd" align="center">
    <th width=20%><% multilang("355" "LANG_HOSTNAME"); %></th>
    <th width=20%><% multilang("1123" "LANG_USERNAME"); %></th>
    <th width=20%><% multilang("359" "LANG_SERVICE"); %></th>
    <th width=20%><% multilang("68" "LANG_INTERFACE"); %></th>
    <th width=20%><% multilang("289" "LANG_DELETE"); %></th>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" name="add" onClick="window.location.assign('app_ddns_add.asp');" value="<% multilang("207" "LANG_ADD"); %>">
  <input type="button" class="link_bg" name="remove" onClick="on_action('rm')" value="<% multilang("289" "LANG_DELETE"); %>">
  <input type="hidden" id="action" name="action" value="none">
  <input type="hidden" name="bcdata" value="le">
  <input type="hidden" name="submit-url" value="">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
