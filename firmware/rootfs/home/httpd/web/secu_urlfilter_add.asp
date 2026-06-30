<%SendWebHeadStr(); %>
<TITLE>WAN</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
var cgi = new Object();
var rules = new Array();
with(rules){<% initPageURL(); %>}
/********************************************************************
**          on document submit
********************************************************************/
function btnApply()
{
 with ( document.forms[0] ) {
  var surl = sji_killspace(url.value);
  if (surl.length == 0)
  {
   alert( "<% multilang("3006" "LANG_URL_NOT_BE_EMPTY"); %>");
   return;
  }
  //if (!sji_checklen(surl.length, 1, 100))
  if (surl.length>=100)
  {
   alert( "<% multilang("3007" "LANG_URL_LENGTH_LARGER_THAN_100"); %>");
   return;
  }
  for (var i=0; i < surl.length; i++)
  {
   if (surl.charAt(i) == " ") {
    alert("<% multilang("565" "LANG_URL"); %>"+"<% multilang("1962" "LANG_INVALID"); %>");
    return;
   }
  }
  if (surl == "www.") {
    alert("<% multilang("1962" "LANG_INVALID"); %>"+"<% multilang("565" "LANG_URL"); %>");
   return;
  }
  /*if(!sji_checkurl(surl))
		{
				alert("<% multilang(LANG_INVALID); %>"+"<% multilang(LANG_URL); %>");
			return;
		}*/
  for(var i = 0; i < rules.length; i++)
  {
   if(rules[i].url == surl)
   {
    alert( "<% multilang("3008" "LANG_RULE_EXIST"); %>");
    return;
   }
  }
  url.value = surl;
/*
		if (port.value == "")
		{
			port.value = 80; //Set the default port number to 80
		}
		else if (!sji_checkdigitrange(port.value, 1, 65535))
		{
			alert( "<% multilang(LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535); %>");
			return;
		}
*/
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
 <blockquote>
  <form id="form" action=/boaform/admin/formURL method=POST name="form">
   <div class="intro_main ">
    <p class="intro_title"><% multilang("3004" "LANG_URL_FILTER_ADD"); %></p>
   </div>
   <div class="intro_main ">
    <br><p><% multilang("3005" "LANG_URL_FILTER_NOTE"); %></p>
   </div>
   <div class="data_common data_common_notitle">
    <table>
     <tr>
      <th width=40%>URL <% multilang("2997" "LANG_ADDRESS"); %>:</th>
      <td><input type="text" name="url"></td>
     </tr>
      <!--<tr>
       <td><% multilang("199" "LANG_PORT"); %>:</td>
       <td><input type="text" name="port"> (If no port number is specified, the system will take 80 as the default port number.)</td>
      </tr>-->
    </table>
     <!--<br>-->
   </div>
   <div class="btn_ctl">
    <input type="button" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save" onClick="btnApply()">
    <input type="hidden" id="action" name="action" value="ad">
    <input type="hidden" name="submit-url" value="/secu_urlfilter_cfg.asp">
   </div>
  </form>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
