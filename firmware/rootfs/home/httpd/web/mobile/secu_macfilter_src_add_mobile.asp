<%SendWebHeadStr("mobile_normal_2"); %>
<title></title>
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

		alert("�������豸������Ϊ�գ�");

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
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form" action=/boaform/admin/formRteMacFilter method=POST name="form">
 <div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
         <div class="clear"></div>
 </div>
<div class="page">
 <div class="simplebox">
   <table class="tabletitle">
    <tr><td><% multilang("3059" "LANG_ADD_MAC_FILTER_RULE"); %></td></tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width=50%>MAC <% multilang("2997" "LANG_ADDRESS"); %>(xx-xx-xx-xx-xx-xx)&nbsp;</td>
     <td><input type="text" name="mac" size="18"></td>
    </tr>
              </table>
              <br><br>
              <input type="button" class="submit-button" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick="btnApply()">
   <input type="hidden" name="action" value="ad">
   <input type="hidden" name="submit-url" value="/mobile/secu_macfilter_src_mobile.asp">
  <br><br>
            <div class="topbutton"><a href="#"><span>Top</span></a></div>
            <div class="footer"><a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a></div>
      <div class="clear"></div>
      </div>
    </div>
<script type="text/javascript" src="js/frame.js"></script>
</body>
<%addHttpNoCache();%>
</html>
