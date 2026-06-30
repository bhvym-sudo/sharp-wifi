<%SendWebHeadStr(); %>
<title>Restore factory settings</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script>
function on_click_button(reset)
{
 document.forms[0].reset.value = reset;
 return true;
}
function on_click_submit(value)
{
 with (document.resetbuttonform)
 {
  resetbutton.value = value;
  submit();
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form id="form" action="/boaform/admin/formReboot" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3241" "LANG_CONFIGURATION_RESTORE_FACTORY_DEFAULT"); %></p><br>
  <p class="intro_content"><% multilang("3242" "LANG_CONFIGURATION_RESET_PAGE"); %> </p><br>
 </div>
 <div class="data_common data_common_notitle">
 <table>
  <tr>
   <th width="40%"><% multilang("522" "LANG_RESET_SETTINGS_TO_DEFAULT"); %>:</th>
   <td width="60%">
    <% RestoreFactoryMode(); %>
   </td>
  </tr>
 </table>
 </div>
 <input type="hidden" value="/mgm_dev_reset.asp" name="submit-url">
 <input type="hidden" value="0" name="reset">
 </form>
 <form action=/boaform/admin/formResetbutton method="post" name="resetbuttonform">
  <div class="intro_main">
   <br></br>
  </div>
  <% RestoreButtonMode(); %>
  <input type="hidden" value="/mgm_dev_reset.asp" name="submit-url">
  <input type="hidden" value="0" name="resetbutton">
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
