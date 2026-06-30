<%SendWebHeadStr(); %>
<TITLE>IGMP Snooping Setting</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
/*
var cgi = new Object();
<%initPageIgmpSnooping();%>
*/
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form id="form" action=/boaform/formIgmpSnooping method=POST name="igmpsnoop">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3281" "LANG_IGMP_SNOOPING_CONFIG"); %></p><br>
  <p class="intro_content"><% multilang("3282" "LANG_IGMP_SNOOPING_CONFIG_PAGE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr><th width=40%>IGMP Snooping:</th>
    <td>
     <input type="radio" name=snoop value=0><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;
     <input type="radio" name=snoop value=1><% multilang("234" "LANG_ENABLE"); %>
    </td>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
    <input type="submit" class="link_bg" name="apply" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>">
    <input type="hidden" name="submit-url" value="/app_igmp_snooping.asp">
 </div>
 <script>
  <% initPage("igmpsnooping"); %>
 </script>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
