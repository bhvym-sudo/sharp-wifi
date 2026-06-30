<%SendWebHeadStr("normal_2"); %>
<meta http-equiv=refresh content="2">
<title>PING result</title>
<!--System common css-->
<style type=text/css>
@import url(/style/default.css);
</style>
<!--System common script-->
<script language="javascript" src="common.js"></script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
 <blockquote>
 <form>
 <div align="left" style="padding-left:20px;"><br>
<% dumpPingInfo(); %>
 <input type=button value="back" onClick=window.location.replace("/diag_ping_admin.asp")>
 </div>
 </form>
 </blockquote>
</body>
</html>
