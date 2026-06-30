<%SendWebHeadStr("normal_2"); %>
<title></title>
<STYLE type=text/css>
@import url(/style/default.css);
.STYLE2 {color: #FFFFFF}
.STYLE3 {color: #33CC00}
.STYLE4 {color: #339900}
.STYLE5 {color: #666666}
</STYLE>
<script language="javascript" src="/common.js"></script>
<script language="javascript" type="text/javascript">
<% initPageWanUser(); %>
function form_load()
{
 with ( document.forms[0] )
 {
  PPPoeState.innerHTML = r_PPPoeState;
  pppServiceName.value = r_pppServiceName
  pppUsername.value = r_PppUsername;
  pppPassword.value = r_pppPassword;
  PPPoeVid.innerHTML = r_PPPoeVid;
 }
}
function btnApply()
{
 with ( document.forms[0] )
 {
   submit();
 }
}
function btnReset()
{
 with ( document.forms[0] )
 {
  PPPoeState.innerHTML = r_PPPoeState;
  pppServiceName.value = r_pppServiceName
  pppUsername.value = r_PppUsername;
  pppPassword.value = r_pppPassword;
  PPPoeVid.innerHTML = r_PPPoeVid;
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" bgcolor="E0E0E0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="form_load()">
 <div id="toptop" align="center" style="padding-left:5px; padding-top:5px">
  <form id="form" action="/boaform/formWanUser" method="post" onsubmit="return on_submit()">
    <div id="normaldisplay" width="100%" height="100%" align="center" valign="middle";>
     <div style="background-image:url(/image/pppoe_wan.gif); width:669px; height:371px; float:center">
      <div style="width:685px; height:85px; float:center; text-align:right">
      <a href="/admin/login.asp"><font size="2" color="black" style="font-family:SimSun"><b><% multilang("3670" "LANG_BACK_LOGIN"); %>:</b></font></a>
      </div>
      <div style="width:830px; float:center">
      <table style="width:830px;" align="center">
       <tr>
        <td colspan="2" align="center" height="35px"><font size="2" color="black" style="font-family:SimSun">Please input username and password</font></td>
       </tr>
       <tr nowrap>
       <td align="right" width="45%" height="20px"><font size="2" color="black" style="font-family:SimSun"></font></td>
       <td id="PPPoeVid"></td>
       </tr>
       <tr>
        <td align="right" width="45%" height="35px"><font size="2" color="black" style="font-family:SimSun"><% multilang("278" "LANG_SERVICE_NAME"); %>:</font></td>
        <td ><input type="text" name="pppServiceName" id="pppServiceName" style="width:150; height:25" disabled=true /><font size="2" color="#E36032">&nbsp;*</font></td>
       </tr>
       <tr>
        <td align="right" width="45%" height="35px"><font size="2" color="black" style="font-family:SimSun"><% multilang("1123" "LANG_USERNAME"); %>:</font></td>
        <td ><input type="text" name="pppUsername" id="pppUsername" style="width:150; height:25" /><font size="2" color="#E36032">&nbsp;*</font></td>
       </tr>
       <tr>
        <td align="right" width="45%" height="35px"><font size="2" color="black" style="font-family:SimSun"><% multilang("65" "LANG_PASSWORD"); %>:</font></td>
        <td ><input type="password" name="pppPassword" id="pppPassword" style="width:150; height:25" /></td>
       </tr>
       <tr nowrap>
       <td align="right" width="45%" height="35px"><font size="2" color="black" style="font-family:SimSun"><% multilang("237" "LANG_STATE"); %>:</font></td>
       <b><td id="PPPoeState"></td></b>
       </tr>
       <tr>
        <td colspan="2" align="center" height="35px">
        <input type="submit" style="width:70px;" value="<% multilang("315" "LANG_APPLY"); %>" onClick="btnApply();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" style="width:70px;" value="<% multilang("2862" "LANG_REWRITE"); %>" onClick="btnReset();" />
        </td>
       </tr>
      </table>
      </div>
     </div>
    </div>
   <br>
   <input type="hidden" name="Username" id="Username" value=''>
   <input type="hidden" name="Password" id="Password" value=''>
   <input type="hidden" name="submit-url" value="/pppoe_usereg.asp">
  </form>
 </DIV>
</body>
</html>
