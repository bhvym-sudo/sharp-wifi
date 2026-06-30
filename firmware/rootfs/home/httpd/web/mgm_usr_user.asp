<%SendWebHeadStr(); %>
<title>User Management</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script>
var cgi = new Object();
<% initPageMgmUser(); %>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
 document.getElementById("sutip").style.display = cgi.issu ? "block" : "none";
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with (document.forms[0]) {
  if (oldPasswd.value.length <= 0) {
   oldPasswd.focus();
   alert("<% multilang("2031" "LANG_PASSWORD_CANNOT_BE_EMPTY_PLEASE_TRY_IT_AGAIN"); %>");
   return;
  }
  if (sji_checkusername(oldPasswd.value, 1, 16) == false) {
   oldPasswd.focus();
   alert("<% multilang("3233" "LANG_PASSWORD_ERROR_INPUT_PASSWORD_AGAIN"); %>");
   return;
  }
  if (newPasswd.value.length <= 0) {
   newPasswd.focus();
   alert("<% multilang("3234" "LANG_NEW_PASSWORD_CAN_NOT_BE_EMPTY_INPUT_AGAIN"); %>");
   return;
  }
  if (sji_checkusername(newPasswd.value, 1, 16) == false) {
   newPasswd.focus();
   alert("<% multilang("3235" "LANG_NEW_PASSWORD_ERROR_INPUT_PASSWORD_AGAIN"); %>");
   return;
  }
  if (newPasswd.value.length < 6) {
   newPasswd.focus();
   alert("<% multilang("3692" "LANG_MGM_USER_PASSWORD_RULE1"); %>");
   return;
  }
  if (newPasswd.value.length > 16) {
   newPasswd.focus();
   alert("<% multilang("3693" "LANG_MGM_USER_PASSWORD_RULE2"); %>");
   return;
  }
  if (sji_checkLoginPsk(newPasswd.value, 1, 16) == false) {
   newPasswd.focus();
   alert("<% multilang("3694" "LANG_MGM_USER_PASSWORD_RULE3"); %>"+"<% multilang("3695" "LANG_MGM_USER_PASSWORD_RULE4"); %>");
   return;
  }
  if (affirmPasswd.value.length <= 0) {
   affirmPasswd.focus();
   alert("<% multilang("3236" "LANG_AFFIRM_PASSWORD_CAN_NOT_BE_EMPTY_INPUT_AGAIN"); %>");
   return;
  }
  if (sji_checkusername(affirmPasswd.value, 1, 16) == false) {
   affirmPasswd.focus();
   alert("<% multilang("3237" "LANG_AFFIRM_PASSWORD_ERROR_INPUT_PASSWORD_AGAIN"); %>");
   return;
  }
  if (newPasswd.value != affirmPasswd.value) {
   affirmPasswd.focus();
   alert("<% multilang("3238" "LANG_AFFIRM_PASSWORD_DO_NOT_MATCH_NEW_PASSWORD_INPUT_AGAIN"); %>");
   return;
  }
  submit();
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formPasswordSetup" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3228" "LANG_ACCESS_CONTROL_PASSWORD"); %></p><br>
  <p class="intro_content"><% multilang("3692" "LANG_MGM_USER_PASSWORD_RULE1"); %></p><br>
  <p class="intro_content"><% multilang("3693" "LANG_MGM_USER_PASSWORD_RULE2"); %></p><br>
  <p class="intro_content"><% multilang("3694" "LANG_MGM_USER_PASSWORD_RULE3"); %></p><br>
  <p class="intro_content"><% multilang("3695" "LANG_MGM_USER_PASSWORD_RULE4"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table id="lstin">
   <tr>
    <th width=40%><% multilang("3224" "LANG_USERNAME_TITLE"); %></th>
    <td><input name="oldUserName" type="text" size="20" maxlength="16" style="width:200px" disabled="true" value=<% checkWrite("UserName"); %>></td>
   </tr>
   <tr>
    <th width=40%><% multilang("3225" "LANG_OLD_PASSWORD_TITLE"); %></th>
    <td><input name="oldPasswd" type="password" size="20" maxlength="16" style="width:200px"></td>
   </tr>
   <tr>
    <th width=40%><% multilang("3226" "LANG_NEW_PASSWORD_TITLE"); %></th>
    <td><input name="newPasswd" type="password" size="20" maxlength="16" style="width:200px"></td>
   </tr>
   <tr>
    <th width=40%><% multilang("3227" "LANG_AFFIRM_PASSWORD_TITLE"); %></th>
    <td><input name="affirmPasswd" type="password" size="20" maxlength="16" style="width:200px"></td>
   </tr>
  </table>
 </div>
 <div class="btn_ctl">
  <input type="button" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onclick="on_submit();">
  <input type="hidden" name="submit-url" value="">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
