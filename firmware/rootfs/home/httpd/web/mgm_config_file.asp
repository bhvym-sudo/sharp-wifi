<% SendWebHeadStr();%>
<title>Profile management</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script>
var cgi = new Object();
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
function on_submit1()
{
 var BinaryFileName;
 var BinaryExtName;
 with (document.uploadconfigfile)
 {
  if (binary.value != "")
  {
/*Added by peichao.li 2018-03-22 For BUG#0000886*/
   BinaryFileName = binary.value.substring(binary.value.lastIndexOf('\\')+1);
   BinaryExtName = BinaryFileName.substring(BinaryFileName.lastIndexOf('.')+1);
   if (binary.value != "")
   {
    if(BinaryExtName == "xml")
     submit();
    else
     alert("<% multilang("3718" "LANG_UPGRADE_FAIL_REASON_2")%>");
   }
/*End of BUG#0000886*/
  }
  else
  {
   alert("<% multilang("2469" "LANG_FILE_NAME_CAN_NOT_BE_EMPTY"); %>");
  }
 }
}
function on_submit2()
{
 var BinaryFileName2;
 var BinaryExtName2;
 with (document.uploadconfigfile2)
 {
  if (binary2.value != "")
  {
/*Added by peichao.li 2018-03-22 For BUG#0000886*/
   BinaryFileName2 = binary2.value.substring(binary2.value.lastIndexOf('\\')+1);
   BinaryExtName2 = BinaryFileName2.substring(BinaryFileName2.lastIndexOf('.')+1);
   if (binary2.value != "")
   {
    if(BinaryExtName2 == "xml")
     submit();
    else
     alert("<% multilang("3718" "LANG_UPGRADE_FAIL_REASON_2")%>");
   }
/*End of BUG#0000886*/
  }
  else
  {
   alert("<% multilang("2469" "LANG_FILE_NAME_CAN_NOT_BE_EMPTY"); %>");
  }
 }
}
/* Added by peichao for bug#0003670 */
function on_submit3()
{
 with (document.CurrToDfConfig)
 {
  if(confirm('<% multilang("3610" "LANG_CONFIG_CURRENT_AS_DEFAULT"); %> ?'))
  {
   submit();
  }
 }
}
function on_submit4()
{
 with (document.CancleDfConfig)
 {
  if(confirm('<% multilang("3611" "LANG_CANCLE_SETTING_DEFAULT"); %> ?'))
  {
   submit();
  }
 }
}
/* End of bug#0003670 */
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" >
 <blockquote>
  <div align="left" style="padding-left:20px; padding-top:5px">
   <form id="form" action="/boaform/admin/formMgmConfig" method="post">
   <div class="intro_main">
    <p class="intro_title"><% multilang("3604" "LANG_DEVICE_CURRENT_CONFIG_MANAGEMENT"); %></p><br>
    <p class="intro_content"><% multilang("3600" "LANG_DEVICE_CONFIG_MANAGEMENT_PAGE_0"); %></p>
   </div>
   <div class="data_common data_common_notitle">
    <table>
     <tr>
      <th><input type="button" class="inner_btn" name="saverec" onClick="on_submit('saveconfigfile');" value="<% multilang("3606" "LANG_CONFIG_DOWNLOAD"); %>"></th>
     </tr>
    </table>
   </div>
    <input type="hidden" id="action" name="action" value="none">
    <input type="hidden" name="submit-url" value="">
   </form>
   <form action=/boaform/admin/formMgmCurrToDfConfig method="post" name="CurrToDfConfig">
    <div class="intro_main">
     <br></br>
     <td><p class="intro_content"><% multilang("3610" "LANG_CONFIG_CURRENT_AS_DEFAULT"); %></p></td>
     <p class="intro_content"><% multilang("3603" "LANG_DEVICE_CONFIG_MANAGEMENT_PAGE_3"); %></p>
    </div>
    <div class="data_common data_common_notitle">
     <table>
      <tr>
       <th><input class="inner_btn" type="button" name="curtodef" onClick="on_submit3();" value="<% multilang("3610" "LANG_CONFIG_CURRENT_AS_DEFAULT"); %>"></th>
      </tr>
     </table>
    </div>
   </form>
   <form action=/boaform/admin/formMgmCancleDfConfig method="post" name="CancleDfConfig">
    <div class="intro_main">
     <br></br>
     <td><p class="intro_content"><% multilang("3611" "LANG_CANCLE_SETTING_DEFAULT"); %></p></td>
     <p class="intro_content"><% multilang("3612" "LANG_DEVICE_CONFIG_MANAGEMENT_PAGE_5"); %></p>
    </div>
    <div class="data_common data_common_notitle">
     <table>
      <tr>
       <th><input class="inner_btn" type="button" name="curtodef" onClick="on_submit4();" value="<% multilang("3611" "LANG_CANCLE_SETTING_DEFAULT"); %>"></th>
      </tr>
     </table>
    </div>
   </form>
   <form action=/boaform/admin/formMgmConfigUpload method="post" enctype="multipart/form-data" name="uploadconfigfile">
    <div class="intro_main ">
     <br></br>
     <p class="intro_title"><% multilang("3605" "LANG_DEVICE_UPLOAD_CONFIG_MANAGEMENT"); %></p><br>
     <p class="intro_content"><% multilang("3601" "LANG_DEVICE_CONFIG_MANAGEMENT_PAGE_1"); %></p>
     <p class="intro_content"><% multilang("3602" "LANG_DEVICE_CONFIG_MANAGEMENT_PAGE_2"); %></p>
     <p class="intro_content"><% multilang("3603" "LANG_DEVICE_CONFIG_MANAGEMENT_PAGE_3"); %></p>
    </div>
    <div class="data_common data_common_notitle">
     <table>
      <tr>
       <th width="40%"><input type="file" name="binary" size="20">&nbsp;</th>
       <td width="60%"><input class="inner_btn" type="button" onClick="on_submit1();" value="<% multilang("3607" "LANG_CONFIG_UPLOAD"); %>"></td>
      </tr>
     </table>
    </div>
   </form>
   <form action=/boaform/admin/formMgmDfConfigUpload method="post" enctype="multipart/form-data" name="uploadconfigfile2">
    <div class="data_common data_common_notitle">
     <table>
      <tr>
       <th width="40%"><input type="file" name="binary2" size="20">&nbsp;</th>
       <td width="60%"><input class="inner_btn" type="button" onClick="on_submit2();" value="<% multilang("3608" "LANG_CONFIG_UPLOAD_AS_DEFAULT"); %>"></td>
      </tr>
     </table>
    </div>
   </form>
  </div>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
