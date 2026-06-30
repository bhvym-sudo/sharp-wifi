<%SendWebHeadStr(); %>
<TITLE>Wan access settings</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
/********************************************************************
**          on document load
********************************************************************/
var cgi = new Object();
<%initPageDos();%>
function on_init()
{
 sji_docinit(document, cgi);
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <blockquote>
  <form id="form" action=/boaform/admin/formDos method=POST name="form">
  <div class="intro_main ">
   <p class="intro_title"><% multilang("173" "LANG_PROTECTION"); %></p>
  </div>
  <div class="data_common data_common_notitle">
   <table width="341" border="0" cellspacing="1" cellpadding="3">
    <tr>
     <td width=50%>
      <input type="radio" name="dosEnble" value="off"><% multilang("233" "LANG_DISABLE"); %>
     </td>
     <td>
      <input type="radio" name="dosEnble" value="on"><% multilang("234" "LANG_ENABLE"); %>
     </td>
    </tr>
   </table>
  </div>
  <div class="btn_ctl">
   <input type="submit" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="apply">
   <input type="hidden" name="submit-url" value="">
  </div>
  </form>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
