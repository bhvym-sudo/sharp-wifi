<%SendWebHeadStr(); %>
<TITLE>Wan Access Settings</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT>
var cgi = new Object();
/********************************************************************
**          on document load
********************************************************************/
function proxySelection()
{
 if(document.mldproxy.daemon[0].checked)
 {
  document.mldproxy.ext_if.disabled = true;
 }
 else
 {
  document.mldproxy.ext_if.disabled = false;
 }
}
function on_init()
{
 //sji_docinit(document, cgi);
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <blockquote>
 <form id="form" action=/boaform/admin/formMLDProxy method=POST name="mldproxy">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3288" "LANG_MLD_PROXY_CONFIG"); %></p><br>
  <p class="intro_content"><% multilang("3289" "LANG_MLD_PROXY_CONFIG_PAGE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table border="0" cellpadding="0" cellspacing="0">
   <tr>
    <th width=40%>MLD Proxy:</th>
          <td>
           <input type="radio" value="0" name="daemon" <%checkWrite("mldproxy0"); %> onClick="proxySelection()" ><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;
           <input type="radio" value="1" name="daemon" <%checkWrite("mldproxy1"); %> onClick="proxySelection()" ><% multilang("234" "LANG_ENABLE"); %>
          </td>
         </tr>
   <tr>
    <th width=40%><% multilang("68" "LANG_INTERFACE"); %>:&nbsp;</th>
          <td>
           <select name="ext_if" ><%checkWrite("mldproxy0d"); %><% if_wan_list("rtv6"); %> </select>
          </td>
         </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="submit" class="button" value="<% multilang("827" "LANG_SAVE"); %>" name="save">
  <input type="hidden" value="/app_mldProxy.asp" name="submit-url">
 </div>
 </form>
 </blockquote>
<script>
 initUpnpDisable = document.mldproxy.daemon[0].checked;
 ifIdx = <% getInfo("mldproxy-ext-itf"); %>;
 if (ifIdx != 65535)
  document.mldproxy.ext_if.value = ifIdx;
 else
  document.mldproxy.ext_if.selectedIndex = 0;
 proxySelection();
</script>
</body>
<%addHttpNoCache();%>
</html>
