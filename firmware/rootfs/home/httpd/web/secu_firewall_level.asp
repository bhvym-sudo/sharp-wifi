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
<%initPageFirewall();%>
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
  <form action=/boaform/admin/formFirewall method=POST name="form">
  <div class="intro_main ">
   <p class="intro_title"><% multilang("3055" "LANG_SELECT_FIREWALL_LEVEL"); %></p>
  </div>
  <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width=50%><% multilang("3055" "LANG_SELECT_FIREWALL_LEVEL"); %>:</th>
     <td>
      <select name="filterLevel">
       <option value="0"><% multilang("3056" "LANG_LOW"); %></option>
        <!--<option value="1">жа</option>-->
       <option value="2"><% multilang("3057" "LANG_HIGH"); %></option>
      </select>
     </td>
    </tr>
   </table>
  </div>
  <br>
  <div class="btn_ctl">
    <input type="submit" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="apply">
    <input type="hidden" name="submit-url" value="">
  </div>
  </form>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
