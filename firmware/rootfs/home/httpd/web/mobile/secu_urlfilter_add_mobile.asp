<%SendWebHeadStr("mobile_normal_2"); %>
<title></title>
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
    alert("<% multilang("1962" "LANG_INVALID"); %>"+"<% multilang("565" "LANG_URL"); %>");
    return;
   }
  }
  if (surl == "www.") {
    alert("<% multilang("1962" "LANG_INVALID"); %>"+"<% multilang("565" "LANG_URL"); %>");
   return;
  }
  /*if(!sji_checkurl(surl))
		{
			alert("��Ч��URL��ַ");
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
			port.value = 80; //����Ĭ�϶˿ں�Ϊ80
		}
		else if (!sji_checkdigitrange(port.value, 1, 65535))
		{
			alert( "�˿ںű����ǷǸ�����,��ȷ����Χ��1��65535֮��");
			return;
		}
*/
  submit();
 }
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form" action=/boaform/admin/formURL method=POST name="form">
 <div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
         <div class="clear"></div>
 </div>
<div class="page">
 <div class="simplebox">
   <table class="tabletitle">
    <tr><td><% multilang("3004" "LANG_URL_FILTER_ADD"); %></td></tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width=40%>URL <% multilang("2997" "LANG_ADDRESS"); %>:</td>
     <td><input type="text" name="url"></td>
    </tr>
              </table>
              <br><br>
              <input type="button" class="submit-button" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save" onClick="btnApply()">
    <input type="hidden" id="action" name="action" value="ad">
    <input type="hidden" name="submit-url" value="/mobile/secu_urlfilter_cfg_mobile.asp">
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
