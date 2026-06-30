<%SendWebHeadStr(); %>
<TITLE>ALG On-Off</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
function AlgTypeStatus()
{
 <%checkWrite("AlgTypeStatus");%>
 return true;
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form action=/boaform/formALGOnOff method=POST name=algof>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3266" "LANG_ALG_CONFIG"); %></p><br>
  <p class="intro_content"><% multilang("3267" "LANG_SELECT_ALG"); %></p><br>
 </div>
 <div <div class="data_common data_common_notitle">
  <table>
   <%checkWrite("GetAlgType")%>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type=submit class="link_bg" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>" name=apply>
   <input type="hidden" value="/algonoff.asp" name="submit-url">
  </div>
 </form>
 <script>
  AlgTypeStatus();
 </script>
</blockquote>
</body>
</html>
