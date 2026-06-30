<%SendWebHeadStr(); %>
<TITLE><% multilang("3244" "LANG_MAINTAIN"); %></TITLE>
<STYLE type=text/css>
@import url(style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT>
var cgi = new Object();
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
}
function on_submit(act)
{
 with (document.forms[0])
 {
  action.value = act;
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formFinishMaintenance" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3245" "LANG_UPLOAD_WHEN_END_MAINTAIN"); %></p><br>
  <p class="intro_content"><% multilang("3246" "LANG_MAINTAIN_PAGE"); %></p><br>
 </div>
 <div zlass="btn_ctl">
  <input type="button" class="link_bg" onclick="on_submit('fn');" value="<% multilang("3247" "LANG_END_MAINTAIN"); %>">
  <input type="hidden" name="action" value="rs">
  <input type="hidden" name="submit-url" value="">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
