<%SendWebHeadStr(); %>
<TITLE>Route List</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
</HEAD>
<body>
<blockquote>
<div class="intro_main ">
 <p class="intro_title"><% multilang("849" "LANG_IP_ROUTE_TABLE"); %></p><br>
</div>
<form action=/boaform/formRefleshRouteTbl method=POST name="formRouteTbl">
<div class="data_common data_common_notitle data_vertical">
 <table>
   <% routeList(); %>
 </table>
</div>
<br>
<div class="btn_ctl">
 <input type="hidden" value="/routetbl.asp" name="submit-url">
 <input class="link_bg" type="submit" value="<% multilang("414" "LANG_REFRESH"); %>" name="refresh">&nbsp;&nbsp;
 <input class="link_bg" type="button" value="<% multilang("708" "LANG_CLOSE"); %>" name="close" onClick="javascript: window.close();">
</div>
</form>
</blockquote>
</body>
</html>
