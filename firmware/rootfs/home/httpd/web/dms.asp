<%SendWebHeadStr("normal_2"); %>
<TITLE>DMS Settings</TITLE>
<!--System common css-->
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--System common script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<SCRIPT language="javascript" type="text/javascript">
function dmsSelection()
{
 return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<DIV align="left" style="padding-left:20px; padding-top:5px">
<form action=/boaform/formDMSConf method=POST name="formDMSconf">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <b><% multilang("3502" "LANG_DMS_CONFIGURATION"); %></b><br><br>
  <tr>
    <% multilang("3503" "LANG_DMS_PAGE"); %>
  </tr>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
      <td width="30%"><% multilang("739" "LANG_DIGITAL_MEDIA_SERVER"); %>:</td>
      <td width="70%">
       <input type="radio" name="enableDMS" value=0 <% fmDMS_checkWrite("fmDMS-enable-dis"); %> onClick="dmsSelection()" ><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;
       <input type="radio" name="enableDMS" value=1 <% fmDMS_checkWrite("fmDMS-enable-en"); %> onClick="dmsSelection()" ><% multilang("234" "LANG_ENABLE"); %>
      </td>
  </tr>
</table>
<br>
      <input type="submit" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>" name="apply">&nbsp;&nbsp;
      <!--<input type="reset" value="Undo" name="reset" onClick="window.location.reload()">-->
      <input type="hidden" value="/dms.asp" name="submit-url">
</form>
</DIV>
</blockquote>
</body>
</html>
