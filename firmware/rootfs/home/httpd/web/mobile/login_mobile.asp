<%SendWebHeadStr("mobile_normal_5"); %>
<title></title>
<STYLE type=text/css>
@import url(/mobile/css/font-awesome.min.css);
@import url(/mobile/css/util.css);
@import url(/mobile/css/main.css);
</STYLE>
<SCRIPT language="javascript" type="text/javascript">
var loginFlag = 0;
var checkCodeValue;/* Added by peichao for mission#0007440 */
if (window.top != window.self) {
// in a frame
 window.top.location.href = "/mobile/login_mobile.asp";
}
/* Added by peichao for mission#0007440 */
function CreateCode()
{
 <% Verification_code_get(); %>
 checkCodeValue = document.getElementById('check_code').value;
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
   }
  }
  else if(lang.substr(0, 2) == "en")
  {
   loginSelinit.value= "0" ;
   if(currentlanguage != "en")
   {
    mlhandle();
   }
  }
  else if(lang.substr(0, 2) == "pt")
  {
   loginSelinit.value= "2" ;
   if(currentlanguage != "pt")
   {
    mlhandle();
   }
  }
  else if(lang.substr(0, 2) == "es")
  {
   loginSelinit.value= "3" ;
   if(currentlanguage != "es")
   {
    mlhandle();
   }
  }
  else
  {
   loginSelinit.value= "0" ;
   if(currentlanguage != "en")
   {
    mlhandle();
   }
  }
 }
 else
 {
  if(currentlanguage == "cn")
  {
   loginSelinit.value = "1" ;
  }
  else if(currentlanguage == "en")
  {
   loginSelinit.value= "0" ;
  }
  else if(currentlanguage == "pt")
  {
   loginSelinit.value= "2" ;
  }
  else if(currentlanguage != "es")
  {
   loginSelinit.value= "3" ;
  }
  else
  {
   loginSelinit.value= "0" ;
  }
 }
 }
 <%checkWrite("verificationenable");%>;
 if (verificationenable != "0")
 {
  CreateCode();
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
  //var mobileAgent = new Array("iphone", "ipod", "ipad", "android", "mobile", "blackberry", "webos", "incognito", "webmate", "bada", "nokia", "lg", "ucweb", "skyfire");
  //var browser = navigator.userAgent.toLowerCase();
  //for (var i=0; i<mobileAgent.length; i++){ 
  //if (browser.indexOf(mobileAgent[i])!=-1){ ismobile.value = "1"; } }
  ismobile.value = "1";
  submit();
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
<body onload="on_init();">
 <form action=/boaform/admin/formLogin method=POST name="cmlogin">
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100 p-t-190 p-b-30">
                <form class="login100-form validate-form">
                    <div class="login100-form-avatar">
                        <img src="img/avatar-01.jpg" alt="AVATAR">
                    </div>
                    <span class="login100-form-title p-t-20 p-b-45"></span>
                    <div class="wrap-input100 validate-input m-b-10" data-validate="<% multilang("3698" "LANG_INPUT_USER_NAME")%>">
                        <input class="input100" type="text" name="username1" id="username1" autocomplete="off" placeholder=<% multilang("3698" "LANG_INPUT_USER_NAME")%>>
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <img src="img/icons/user1.png" width="15" height="15" alt="icon" class="m-icon"/>
                        </span>
                    </div>
                    <div class="wrap-input100 validate-input m-b-10" data-validate="<% multilang("3699" "LANG_INPUT_PASSWORD")%>">
                        <input class="input100" type="password" name="psd1" id="psd1" placeholder=<% multilang("3699" "LANG_INPUT_PASSWORD")%> >
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <img src="img/icons/security.png" width="15" height="15" alt="icon" class="m-icon"/>
                        </span>
                    </div>
     <% checkWrite("loginMoblieVercodeinit"); %>
     <div class="wrap-input100 validate-input m-b-10" >
                  <!-- <% checkWrite("loginSelinitMobile"); %> -->
                    </div>
                    <div class="container-login100-form-btn p-t-10">
                        <button class="login100-form-btn" onClick="on_submit();"><% multilang("779" "LANG_LOGIN"); %></button>
                    </div>
     <div class="text-center w-full p-t-25 p-b-230">
                        <a href="#" class="txt1"></a>
                    </div>
                    <div class="text-center w-full">
                        <a class="txt1" href="#">
                        </a>
                    </div>
<input type="hidden" name="username" id="username" value=''>
<input type="hidden" name="psd" id="psd" value=''>
<input type="hidden" name="sec_lang" id="sec_lang" value=''>
<input type="hidden" name="loginSelinit" id="loginSelinit" value=''>
<input type="hidden" name="ismobile" id="ismobile" value=''>
                </form>
            </div>
        </div>
    </div>
    <script src="vendor/jquery/jquery-1.12.4.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
