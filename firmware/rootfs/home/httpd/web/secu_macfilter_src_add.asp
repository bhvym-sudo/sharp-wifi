<%SendWebHeadStr(); %>
<TITLE>WAN</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
var rules = new Array();
with(rules){<% rteMacFilterList(); %>}
/********************************************************************
**          on document apply
********************************************************************/
function btnApply()
{
 /*
	if(form.devname.value == "")
	{
		alert("Device name is invalid!");
		return false;
	}
	*/
 if(form.mac.value == "")
 {
  alert("<% multilang("1695" "LANG_INVALID_MAC_ADDR_SHOULD_NOT_EMPTY"); %>");
  return false;
 }
 if(!sji_checkmac(form.mac.value))
 {
  alert("mac" + "<% multilang("2997" "LANG_ADDRESS"); %>" + "<% multilang("171" "LANG_ERROR"); %>");
  return false;
 }
 for(var i = 0; i < rules.length; i++)
 {
  if(/*rules[i].name == form.devname.value ||*/ rules[i].mac == form.mac.value)
  {
   alert( "<% multilang("3008" "LANG_RULE_EXIST"); %>");//alert("That rule already exists");
   return false;
  }
 }
 form.submit();
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
  <blockquote>
 <form id="form" action=/boaform/admin/formRteMacFilter method=POST name="form">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3059" "LANG_ADD_MAC_FILTER_RULE"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table border="0" cellpadding="0" cellspacing="0">
   <tr>
    <td width="180">MAC <% multilang("2997" "LANG_ADDRESS"); %>(xx-xx-xx-xx-xx-xx)&nbsp;</td>
    <td><input type="text" name="mac" size="18"></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
   <input type="button" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick="btnApply()">
   <input type="hidden" name="action" value="ad">
   <input type="hidden" name="submit-url" value="/secu_macfilter_src.asp">
 </div>
 </form>
  </blockquote>
</body>
<%addHttpNoCache();%>
</html>
