<%SendWebHeadStr(); %>
<title>Syslog</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script>
var cgi = new Object();
<% initPageSysLog(); %>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
 if (cgi.issu == false) {
  form.newrec.style.display = "none";
  //form.clrrec.style.display = "none";
 }
}
function btnView()
{
 var options =
     "menubar=yes,resizable=yes,scrollbars=yes,titlebar=yes,toolbar=no,width=640,height=600";
 window.open("mgm_log_view_access.asp", "<% multilang("63" "LANG_SYSTEM_LOG"); %>", options);
}
function btnSecView()
{
 var options =
     "menubar=yes,resizable=yes,scrollbars=yes,titlebar=yes,toolbar=no,width=640,height=600";
 window.open("mgm_log_view_sec.asp", "<% multilang("63" "LANG_SYSTEM_LOG"); %>", options);
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit(act)
{
 with (document.forms[0]) {
  action.value = act;
  submit();
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formSysLog" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("415" "LANG_USER_LIST"); %></p><br>
  <p class="intro_content"><% multilang("3260" "LANG_SYSTEM_RECORD_PAGE_1"); %></p><br>
  <p class="intro_content"><% multilang("3261" "LANG_SYSTEM_RECORD_PAGE_2"); %></p><br>
  <p class="intro_content"><% multilang("3262" "LANG_SYSTEM_RECORD_PAGE_3"); %></p><br>
 </div>
 <div class="btn_ctl">
  <input type="button" class="link_bg" name="sysrec" onClick="btnView();" value="<% multilang("3263" "LANG_ACCESS_RECORDS"); %>">
  <input type="button" class="link_bg" name="clrrec" onClick="on_submit('clr');" value="<% multilang("3264" "LANG_CLEAR_RECORDS"); %>">
  <input type="button" class="link_bg" name="saverec" onClick="on_submit('saveLog');" value="<% multilang("3265" "LANG_DOWNLOAD_LOG"); %>">
  <input type="hidden" id="action" name="action" value="none">
  <input type="hidden" name="submit-url" value="">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
