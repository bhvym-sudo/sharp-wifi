<%SendWebHeadStr("normal_1"); %>
<TITLE>tenebris login</TITLE>
<!--System share css-->
<STYLE type=text/css>
@import url(/style/default.css);
.STYLE2 {color: #FFFFFF}
.STYLE3 {color: #33CC00}
.STYLE4 {color: #339900}
.STYLE5 {color: #666666}
</STYLE>
<!--System share scripts-->
<SCRIPT language="javascript" type="text/javascript">
var loginFlag = 0;
if (window.top != window.self) {
// in a frame
 window.top.location.href = "/admin/login.asp";
}
/* Added by peichao for mission#0007440 */
function CreateCode()
{
 <% Verification_code_get(); %>
}
function refresh()
{
 window.location.reload();
}
/* End of mission#0007440 */
function myKeyDown(e)
{
 var code;
 if (!e) {
  e = window.event;
 }
 if (e.keyCode) {
  code = e.keyCode;
 } else if (e.which) {
  code = e.which;
 }
 if (code == 13) {
  on_submit();
 }
 return true;
}
document.onkeydown = myKeyDown;
if (document.captureEvents) document.captureEvents(Event.KEYDOWN);
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 document.forms[0].username1.focus();
 var mobileAgent = new Array("iphone", "ipod", "ipad", "android", "mobile", "blackberry", "webos", "incognito", "webmate", "bada", "nokia", "lg", "ucweb", "skyfire");
 var browser = navigator.userAgent.toLowerCase();
 for (var i=0; i<mobileAgent.length; i++){
 if (browser.indexOf(mobileAgent[i])!=-1){ ismobile.value = "1";location.href = '/mobile/login_mobile.asp';break; } }
 <%checkWrite("verificationenable");%>;
 if (verificationenable != "0")
 {
  CreateCode();/* Added by peichao for mission#0007440 */
 }
 if (ismobile.value != "1")
 {
  auto_lang();
  //alert("finish auto lang");
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 if (loginFlag)
  return 1;
 with ( document.forms[0] ) {
  username.value = username1.value;
  psd.value = psd1.value;
  sec_lang.value="0";
  if(username.value.length <= 0) {
   alert("<% multilang("3335" "LANG_USERNAME_EMPTY"); %>");
   return;
  }
  if(psd.value.length <= 0) {
   alert("<% multilang("3336" "LANG_PASSWORD_EMPTY"); %>");
   return;
  }
  loginFlag = 1;
  submit();
 }
}
function auto_lang()
{
 with ( document.forms[0] ) {
 <%checkWrite("currentlanguage");%>;
 <%checkWrite("languagesetmode");%>;
 var lang = navigator.language || navigator.userLanguage;
 if(languagesetmode == "2")
 {
  if(lang.substr(0, 2) == "zh")
  {
   loginSelinit.value = "1" ;
   if(currentlanguage != "cn")
   {
    mlhandle();
    //alert("set to cn");
   }
  }
  else if(lang.substr(0, 2) == "en")
  {
   loginSelinit.value= "0" ;
   if(currentlanguage != "en")
   {
    mlhandle();
    //alert("set to en 1");
   }
  }
  else if(lang.substr(0, 2) == "pt")
  {
   loginSelinit.value= "2" ;
   if(currentlanguage != "pt")
   {
    mlhandle();
    //alert("set to pt");
   }
  }
  else if(lang.substr(0, 2) == "es")
  {
   loginSelinit.value= "3" ;
   if(currentlanguage != "es")
   {
    mlhandle();
    //alert("set to es");
   }
  }
  else
  {
   loginSelinit.value= "0" ;
   if(currentlanguage != "en")
   {
    mlhandle();
    //alert("set to en 2");
   }
  }
 }
 }
}
function mlhandle()
{
 with ( document.forms[0] ) {
  sec_lang.value="1";
  submit();
 }
}
</SCRIPT>
</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFFF" onLoad="on_init();">
<span class="STYLE2"></span><span class="STYLE5"></span><span class="STYLE4"></span><span class="STYLE3"></span><span class="STYLE2"></span><span class="STYLE2"></span>
<form action=/boaform/admin/formLogin method=POST name="cmlogin">
<table width="100%" height="100%" align="center" valign="middle" style="background-color: #1a1a1a;" >
<tr>
 <td width="25%" height="25%"></td>
 <td width="50%" ></td>
 <td width="25%"></td>
</tr>
<tr align="left" valign="top">
 <td height="50%"></td>
 <td>
  <table vertical-align="middle" width="100%" height="100%">
  <tr>
   <td width="280" style="padding-left:50px;background-repeat:no-repeat;background-position-x:100px;background-position-y:130px;background-size:150px 100px"></td>
   <td>
   <table cellspacing="1" height="100%" style="font-size:10pt;" align="left">
    <!--<% checkWrite("loginTopWeightinit"); %>
    <tr height="40px" width="240px">
     <td width="80px" valign="baseline"><font color="white" size="3"><b><% multilang("1123" "LANG_USERNAME"); %>:</b></font></td>
     <td align="left" valign="baseline"><input type="text" name="username1" id="username1" style="width:150px;border:none;background: url(/image/input_normal.png) no-repeat center right;width:150px;height:20px;cursor:pointer"/></td>
    </tr>
    <tr height="40px">
     <td width="80px" valign="baseline"><font color="white" size="3"><b><% multilang("65" "LANG_PASSWORD"); %>:</b></font></td>
                    <td align="left" valign="baseline"><input type="password" name="psd1" id="psd1" style="width:150px;border:none;background: url(/image/input_normal.png) no-repeat center right;width:150px;height:20px;cursor:pointer"/></td>
                </tr>
    <% checkWrite("loginVercodeinit"); %>
    <% checkWrite("loginSelinit"); %>
    <tr height="40px">
                    <td align="middle" valign="baseline">
     <input name="button" type="button" class="button" onClick="on_submit();" style=" color:white; border:none;background: url(/image/button_normal.png) no-repeat center right;width:77px;height: 40px;cursor:pointer;" value=" <% multilang("779" "LANG_LOGIN"); %>"/>
     </td>
     <td align="middle" valign="baseline">
     <input type="reset" style="color:white; border:none;background: url(/image/button_normal.png) no-repeat center right;width:77px;height:40px;cursor:pointer" value=" <% multilang("2862" "LANG_REWRITE"); %>" />
     </td>
    </tr>
    <tr height="155px">-->
    <% checkWrite("loginMenuinit"); %>
    </tr>
   </table>
   </td>
  </tr>
  </table>
 </td>
 <td></td>
</tr>
<tr>
 <td height="25%"></td>
 <td></td>
 <td></td>
</tr>
</table>
<input type="hidden" name="username" id="username" value=''>
<input type="hidden" name="psd" id="psd" value=''>
<input type="hidden" name="sec_lang" id="sec_lang" value=''>
<input type="hidden" name="loginSelinit" id="loginSelinit" value=''>
<input type="hidden" name="ismobile" id="ismobile" value=''>
</form>
</BODY>
<%addHttpNoCache();%>
</html>
