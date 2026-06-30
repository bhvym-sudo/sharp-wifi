<% SendWebHeadStr();%>
<title>Firmware Upgrade</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script>
function sendClicked()
{
 var BinaryFileName;
 var BinaryExtName;
 if (document.password.binary.value=="") {
  alert("<% multilang("2210" "LANG_SELECTED_FILE_CANNOT_BE_EMPTY"); %>");
  document.password.binary.focus();
  return false;
 }
/*Added by peichao.li 2018-03-22 For BUG#0000886*/
 BinaryFileName = document.password.binary.value.substring(document.password.binary.value.lastIndexOf('\\')+1);
 BinaryExtName = BinaryFileName.substring(BinaryFileName.lastIndexOf('.')+1);
 if(BinaryExtName != "tar"){
  alert('<% multilang("3718" "LANG_UPGRADE_FAIL_REASON_2")%>');
  return false;
 }
/*End of BUG#0000886*/
 if (!confirm('<% multilang("533" "LANG_PAGE_DESC_UPGRADE_CONFIRM")%>'))
  return false;
 else
  return true;
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form action=/boaform/admin/formUpload method=POST enctype="multipart/form-data" name="password">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("66" "LANG_FIRMWARE_UPGRADE"); %></p><br>
  <p class="intro_content"> <% multilang("528" "LANG_PAGE_DESC_UPGRADE_FIRMWARE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
 <table>
  <tr>
   <th><input class="inner_btn" type="file" value="<% multilang("514" "LANG_CHOOSE_FILE"); %>" name="binary" size=20></th>
  </tr>
 </table>
 </div>
 <br>
 <div class="btn_ctl">
      <input class="link_bg" type="submit" value="<% multilang("529" "LANG_UPGRADE"); %>" name="send" onclick="return sendClicked()">&nbsp;&nbsp;
  <input class="link_bg" type="reset" value="<% multilang("208" "LANG_RESET"); %>" name="reset">
  <input type="hidden" value="mgm_dev_upgrade.asp" name="submit-url">
 </div>
  </form>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
