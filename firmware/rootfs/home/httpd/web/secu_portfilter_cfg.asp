<%SendWebHeadStr(); %>
<TITLE>Port Filter</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--System Common Script-->
<SCRIPT>
var cgi = new Object();
<%ipPortFilterConfig();%>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
 if(cgi.ipfilterEnable == false)
 {
  form.ipfilterEnable[0].checked == true;
  form.ipFilterMode[0].disabled = true;
  form.ipFilterMode[1].disabled = true;
  policy_frame.location.href = "about:blank";
 }
 else
 {
  form.ipfilterEnable[1].checked == true;
  form.ipFilterMode[0].disabled = false;
  form.ipFilterMode[1].disabled = false;
  if(cgi.whtflag == false)
  {
   form.ipFilterMode[0].checked = true;
  }else{
   form.ipFilterMode[1].checked = true;
  }
  on_mode();
 }
}
function initIpFilterMode()
{
 if(form.ipfilterEnable[0].checked == true)
 {
  form.ipFilterMode[0].disabled = true;
  form.ipFilterMode[1].disabled = true;
  policy_frame.location.href = "about:blank";
 }
 else
 {
  form.ipFilterMode[0].disabled = false;
  form.ipFilterMode[1].disabled = false;
  on_mode();
 }
}
function on_action()
{
 with(form)
 {
  submit();
 }
}
function on_mode()
{
 var surl = ( (form.ipFilterMode[0].checked == true)? "secu_portfilter_blk.asp" : "secu_portfilter_wht.asp");
 if(policy_frame.location)
  policy_frame.location.href = surl;
 else policy_frame.src = surl;
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Codes-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action=/boaform/admin/formPortFilter method=POST name="form">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("1207" "LANG_IP_PORT_FILTERING"); %></p>
  <!--
  <p class="intro_content"><% multilang("3058" "LANG_MAX_16_RULES"); %></p>
  -->
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=30%>IP <% multilang("2997" "LANG_ADDRESS"); %> <% multilang("360" "LANG_FILTERING"); %>:</th>
    <td width=35%><input type="radio" name="ipfilterEnable" value="off" onClick="initIpFilterMode()">&nbsp;&nbsp;<% multilang("233" "LANG_DISABLE"); %></td>
    <td><input type="radio" name="ipfilterEnable" value="on" onClick="initIpFilterMode()">&nbsp;&nbsp;<% multilang("234" "LANG_ENABLE"); %></td>
   </tr>
   <tr>
    <td width=30%><% multilang("360" "LANG_FILTERING"); %> <% multilang("129" "LANG_MODE"); %>:</td>
    <td width=35%><input type="radio" name="ipFilterMode" onClick="on_mode();" checked>&nbsp;&nbsp;<% multilang("2697" "LANG_BLACK_LIST"); %></td>
    <td><input type="radio" name="ipFilterMode" onClick="on_mode();">&nbsp;&nbsp;<% multilang("2696" "LANG_WHITE_LIST"); %></td>
   </tr>
  </table>
 </div>
 <br>
 <font color="red"><b><% multilang("3686" "LANG_IP_FILTER_FUNCTION_DESCRIPTION"); %></b></font>
 <br>
 <br>
 <input type="button" value="<% multilang("797" "LANG_SUBMIT"); %>" onClick="on_action()" style="height:30px;width:50px">
 <br>
 <br><br><br><br>
 <input type="hidden" id="action" name="action" value="sw">
 <input type="hidden" name="submit-url" value="" >
 </form>
</blockquote>
<iframe src="about:blank" id="policy_frame" width="100%" frameborder="0" style="border-style:none; height:100%"></iframe>
</body>
<%addHttpNoCache();%>
</html>
