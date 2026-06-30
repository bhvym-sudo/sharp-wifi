<%SendWebHeadStr("mobile_normal_2"); %>
<title></title>
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
  cell.align = "center";
  cell = row.insertCell(1);
  //cell.innerHTML = rules[i].port;
  //cell = row.insertCell(2);
  cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
 }
}
function addClick()
{
   var loc = "secu_urlfilter_add_mobile.asp";
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
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form" action=/boaform/admin/formURL method=POST name="form">
 <div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
         <div class="clear"></div>
 </div>
<div class="page">
 <div class="simplebox">
   <table class="tabletitle">
    <tr><td><% multilang("3003" "LANG_URL_FILTER_DESCRIBE"); %></td></tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width=30%><% multilang("1209" "LANG_URL_BLOCKING"); %>:</td>
     <td width=35%><input type="radio" name="urlfilterEnble" value="off" onClick="on_action('sw')">&nbsp;&nbsp;<% multilang("233" "LANG_DISABLE"); %></td>
     <td><input type="radio" name="urlfilterEnble" value="on" onClick="on_action('sw')">&nbsp;&nbsp;<% multilang("234" "LANG_ENABLE"); %></td>
    </tr>
    <tr>
     <td width=30%><% multilang("360" "LANG_FILTERING"); %><% multilang("129" "LANG_MODE"); %>:</td>
     <td width=35%><input type="radio" name="urlFilterMode" value="off" onClick="on_action('md')">&nbsp;&nbsp;<% multilang("2697" "LANG_BLACK_LIST"); %></td>
     <td><input type="radio" name="urlFilterMode" value="on" onClick="on_action('md')">&nbsp;&nbsp;<% multilang("2696" "LANG_WHITE_LIST"); %></td>
    </tr>
              </table>
       <br><br>
              <table class="tabledata" id="rulelst">
    <tr align="center" class="hd">
     <td width=50%>URL <% multilang("2997" "LANG_ADDRESS"); %></td>
     <td><% multilang("289" "LANG_DELETE"); %></td>
    </tr>
              </table>
              <br><br>
              <input type="button" class="submit-button" name="add" onClick="addClick()" value="<% multilang("207" "LANG_ADD"); %>">
   <input type="button" class="submit-button" name="remove" onClick="on_action('rm')" value="<% multilang("289" "LANG_DELETE"); %>">
   <input type="hidden" id="action" name="action" value="none">
   <input type="hidden" name="bcdata" value="le">
   <input type="hidden" name="submit-url" value="" >
  <br><br>
            <div class="topbutton"><a href="#"><span>Top</span></a></div>
            <div class="footer"><a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a></div>
      <div class="clear"></div>
      </div>
    </div>
<script type="text/javascript" src="js/frame.js"></script>
</body>
<%addHttpNoCache();%>
</html>
