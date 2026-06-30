<%SendWebHeadStr(); %>
<title>PASSWORD</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<style>
tr {height: 16px;}
</style>
<script language="javascript" src="/common.js"></script>
<script language="javascript" type="text/javascript">
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
}
function reset_para()
{
 document.getElementById("newPasswd").value = gponsn;
 //document.getElementById("oldPasswd").value = snpassword;
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
  /*if (sji_checkusername(oldPasswd.value, 1, 16) == false) {
			oldPasswd.focus();
			alert("<% multilang(LANG_PASSWORD_ERROR_INPUT_PASSWORD_AGAIN); %>");
			return;
		}*/
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
   alert("<% multilang("3238" "LANG_AFFIRM_PASSWORD_DO_NOT_MATCH_NEW_PASSWORD_INPUT_AGAIN"); %>");
   return;
  }
  submit();
 }
}
function on_submit_cancle()
{
 window.top.location.href = "/index.html";
 return false;
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formLogPassCheck" method="post">
  <div style="float:center">
   <table align="center">
    <tr>
     <td colspan="2" align="center" height="45px"><font color=red><b><% multilang("3691" "LANG_MGM_USER_PASSWORD_RULE0"); %></b></font></td>
    </tr>
    <tr>
     <td colspan="2" align="left" height="30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1: <% multilang("3692" "LANG_MGM_USER_PASSWORD_RULE1"); %></td>
    </tr>
    <tr>
     <td colspan="2" align="left" height="30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2: <% multilang("3693" "LANG_MGM_USER_PASSWORD_RULE2"); %></td>
    </tr>
    <tr>
     <td colspan="2" align="left" height="30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3: <% multilang("3694" "LANG_MGM_USER_PASSWORD_RULE3"); %></td>
    </tr>
    <tr>
     <td colspan="2" align="left" height="30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4: <% multilang("3695" "LANG_MGM_USER_PASSWORD_RULE4"); %></td>
    </tr>
    <tr>
     <td align="right" width="45%" height="35px"><font size="2" color="black" ><% multilang("3225" "LANG_OLD_PASSWORD_TITLE"); %></font></td>
     <td ><input type="password" name="oldPasswd" id="oldPasswd" style="width:150; height:25" /></td>
    </tr>
    <tr>
     <td align="right" width="45%" height="35px"><font size="2" color="black" ><% multilang("3226" "LANG_NEW_PASSWORD_TITLE"); %></font></td>
     <td ><input type="password" name="newPasswd" id="newPasswd" style="width:150; height:25" /></td>
    </tr>
    <tr>
     <td align="right" width="45%" height="35px"><font size="2" color="black" ><% multilang("3227" "LANG_AFFIRM_PASSWORD_TITLE"); %>:</font></td>
     <td ><input type="password" name="affirmPasswd" id="affirmPasswd" style="width:150; height:25" /></td>
    </tr>
    <tr>
     <td colspan="2" align="center" height="35px">
     <input type="button" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onclick="on_submit();">
     <input type="button" class="link_bg" value="<% multilang("651" "LANG_CANCEL"); %>" onclick="on_submit_cancle();">
     <input type="hidden" name="submit-url" value="">
     </td>
    </tr>
   </table>
  </div>
 </form>
</blockquote>
</body>
</html>
