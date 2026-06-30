<%SendWebHeadStr(); %>
<TITLE>Wan Access Settings</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
var cgi = new Object();
/********************************************************************
**          on document load
********************************************************************/
function proxySelection()
{
 if(document.upnp.daemon[0].checked)
 {
  document.upnp.ext_if.disabled = true;
 }
 else
 {
  document.upnp.ext_if.disabled = false;
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="">
 <blockquote>
 <form id="form" action=/boaform/admin/formUpnp method=POST name="upnp">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3280" "LANG_UPNP_CONFIG"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table border="0" cellpadding="0" cellspacing="0">
   <tr>
      <th width=40%>UPnP:</th>
    <td width=60%>
     <input type="radio" value="0" name="daemon" <%checkWrite("upnp0"); %> onClick="proxySelection()" ><% multilang("233" "LANG_DISABLE") %>&nbsp;&nbsp;
     <input type="radio" value="1" name="daemon" <%checkWrite("upnp1"); %> onClick="proxySelection()" ><% multilang("234" "LANG_ENABLE") %>
    </td>
   </tr>
   <tr>
    <th width=30%>WAN <% multilang("68" "LANG_INTERFACE") %></th>
    <td> <select name="ext_if" <%checkWrite("upnp0d"); %>> <% if_wan_list("rt"); %> </select> </td>
   </tr>
  </table>
 </div>
  <br>
 <div class="btn_ctl">
  <input type="submit" class="link_bg" value="<% multilang("827" "LANG_SAVE"); %>" name="save">
  <input type="hidden" value="/app_upnp.asp" name="submit-url">
 </div>
 </form>
</blockquote>
<script>
 initUpnpDisable = document.upnp.daemon[0].checked;
 ifIdx = <% getInfo("upnp-ext-itf"); %>;
 if (ifIdx != 65535)
  document.upnp.ext_if.value = ifIdx;
 else
  document.upnp.ext_if.selectedIndex = 0;
 proxySelection();
</script>
</body>
<%addHttpNoCache();%>
</html>
