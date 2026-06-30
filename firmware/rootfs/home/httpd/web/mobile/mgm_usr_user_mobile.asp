<%SendWebHeadStr("mobile_normal_2"); %>
<title></title>
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
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form" action="/boaform/admin/formPasswordSetup" method="post">
 <div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
         <div class="clear"></div>
 </div>
<!-- end header -->
<div class="page">
 <div class="simplebox">
   <table class="tabletitle">
    <tr>
     <td><% multilang("3228" "LANG_ACCESS_CONTROL_PASSWORD"); %></td>
    </tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width=40%><% multilang("3224" "LANG_USERNAME_TITLE"); %></td>
     <td><input name="oldUserName" type="text" size="20" maxlength="16" style="width:200px" disabled="true" value=<% checkWrite("UserName"); %>></td>
    </tr>
    <tr>
     <td width=40%><% multilang("3225" "LANG_OLD_PASSWORD_TITLE"); %></td>
     <td><input name="oldPasswd" type="password" size="20" maxlength="16" style="width:200px"></td>
    </tr>
    <tr>
     <td width=40%><% multilang("3226" "LANG_NEW_PASSWORD_TITLE"); %></td>
     <td><input name="newPasswd" type="password" size="20" maxlength="16" style="width:200px"></td>
    </tr>
    <tr>
     <td width=40%><% multilang("3227" "LANG_AFFIRM_PASSWORD_TITLE"); %></td>
     <td><input name="affirmPasswd" type="password" size="20" maxlength="16" style="width:200px"></td>
    </tr>
              </table>
              <br><br>
   <input type="button" class="submit-button" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onclick="on_submit();">
   <input type="hidden" name="submit-url" value="">
   <br><br>
            <div class="topbutton"><a href="#"><span>Top</span></a></div>
            <div class="footer"><a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a></div>
      <div class="clear"></div>
      </div>
    </div>
    <!-- end page -->
<script type="text/javascript" src="js/frame.js"></script>
</body>
<%addHttpNoCache();%>
</html>
