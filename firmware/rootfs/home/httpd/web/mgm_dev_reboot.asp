<%SendWebHeadStr(); %>
<title>Save / Restart</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script>
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form id="form" action="/boaform/admin/formReboot" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("511" "LANG_COMMIT_AND_REBOOT"); %></p><br>
  <p class="intro_content"><% multilang("512" "LANG_THIS_PAGE_IS_USED_TO_COMMIT_CHANGES_TO_SYSTEM_MEMORY_AND_REBOOT_YOUR_SYSTEM"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
 <table>
  <tr>
   <th width="40%"><% multilang("511" "LANG_COMMIT_AND_REBOOT"); %>:</th>
   <td><input class="inner_btn" type="submit" value="<% multilang("511" "LANG_COMMIT_AND_REBOOT"); %>"></td>
  </tr>
 </table>
 </div>
 <input type="hidden" value="/mgm_dev_reboot.asp" name="submit-url">
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
