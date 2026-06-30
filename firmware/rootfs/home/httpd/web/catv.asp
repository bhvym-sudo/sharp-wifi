<%SendWebHeadStr("normal_2"); %>
<title><% multilang("3615" "LANG_CATV"); %><% multilang("224" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function saveChanges()
{
//  if (document.formDMZ.dmzcap[0].checked)
 //	return true;      
//  if (!checkHostIP(document.formDMZ.ip, 1))
//	return false;
  return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#525859"><% multilang("3615" "LANG_CATV"); %><% multilang("224" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formCatv method=POST name="catv">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("3616" "LANG_THIS_PAGE_ALLOWS_YOU_ENABLED_OR_DISABLE_CATV_FUNCTION"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
      <td width="30%"><font size=2><b><% multilang("3615" "LANG_CATV"); %>:</b></td>
      <td width="35%">
 <input type="radio" value="0" name="catv" <% checkWrite("catv-0"); %>><% multilang("165" "LANG_DISABLED"); %>&nbsp;&nbsp;
      <input type="radio" value="1" name="catv" <% checkWrite("catv-1"); %>><% multilang("164" "LANG_ENABLED"); %>
      </td>
  </tr>
</table>
  <br>
      <input type="submit" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;
      <input type="hidden" value="/catv.asp" name="submit-url">
 </form>
</blockquote>
</body>
</html>
