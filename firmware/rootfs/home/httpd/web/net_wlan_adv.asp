<%SendWebHeadStr("normal_2"); %>
<TITLE>HGU-WLAN</TITLE>
<!--System common css-->
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--System common script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<SCRIPT language="javascript" type="text/javascript">
var ssidIdx = <% checkWrite("wlan_idx"); %>;//SSID index
var wpa="tkip+aes";//It is used to judge whether the back table column is echoed
var mode = "open";//Network authentication mode
var bcntpsubcriber = "1";//Network authentication mode switch: 0 indicates that it cannot be edited, and 1 means it can be edited
var wlssidlist="China_kkk";//List display
var wep = "enabled";//sep encryption is as follows: enabled£¬disabled
var wlCorerev = "3";//WPA encryption: When it is greater than or equal to 3, WPA encryption list values are "TKIP", "AES", "TKIP + AES"; otherwise, WPA encryption list values are "TKIP"
var bit = "0";//Key length: WEP128=0;WEP64=1
var wpapskValue = "00005544";//WPA pre shared key
var wepkValue = "11111";//WEP pre shared key
var wpapskUpInter = "55";//WPA update session key interval
var keyIdx = "1";//Network key index numbers correspond to: 1,2,3,4
var keys = new Array( "key1", "key2","key3", "key4" ); //List of network key values
var defPskLen, defPskFormat;
var wps20;
var oldMethod;
var wlanMode;
var encrypt_value;
var cipher_value;
var wpa2cipher_value;
var _wlan_mode=new Array();
var _encrypt=new Array();
var _enable1X=new Array();
var _wpaAuth=new Array();
var _wpaPSKFormat=new Array();
var _wpaPSK=new Array();
var _rsPort=new Array();
var _rsIpAddr=new Array();
var _rsPassword=new Array();
var _uCipher=new Array();
var _wpa2uCipher=new Array();
var _wepAuth=new Array();
var _wepLen=new Array();
var _wepKeyFormat=new Array();
var _wlan_isNmode=new Array();
function pin_window(pin)
{
 with (document.forms[0]) {
  var w = window.open("", "", "toolbar=no,width=500,height=100");
  w.document.write('<font size=5><b><center>' + pin + '</center></b></font>');
  w.document.close();
 }
}
function help_window()
{
 with(document.forms[0]) {
  var w = window.open("", "", "toolbar=no,width=500,height=100");
  w.document.write('If left blank, a new PIN will be generated when you click Configure.<br>');
  w.document.write('Use the link next to PIN textbox to show the generated PIN.');
  w.document.close();
 }
}
function wpapsk_window()
{
 var psk_window = window.open("", "", "toolbar=no,width=500,height=100");
 psk_window.document.write(" WPA <% multilang("190" "LANG_SHARED_KEY"); %> " + wpapskValue);
 psk_window.document.close();
}
//cathy
function isHexaDigit(val)
{
 if(val>='a' && 'f'>=val)
  return true;
 else if(val>='A' && 'F'>=val)
  return true;
 else if(val>='0' && '9'>=val)
  return true;
 else
  return false;
}
function isValidwpapskValue(val)
{
 var ret = false;
 var len = val.length;
 var maxSize = 64;
 var minSize = 8;
 if (len >= minSize && len < maxSize)
  ret = true;
 else if (len == maxSize) {
  for (i = 0; i < maxSize; i++)
   if (isHexaDigit(val.charAt(i)) == false)
    break;
  if (i == maxSize)
   ret = true;
 }
 else
  ret = false;
 return ret;
}
function isValidIpAddress(address)
{
 var i = 0;
 if (address == '0.0.0.0' ||address == '255.255.255.255')
  return false;
 addrParts = address.split('.');
 if (addrParts.length != 4)
  return false;
 for (i = 0; i < 4; i++) {
  if (isNaN(addrParts[i]) || addrParts[i] =="")
   return false;
  num = parseInt(addrParts[i]);
  if (num < 0 || num > 255)
   return false;
 }
 return true;
}
//cathy
function isAllZero(val)
{
 var len = val.length;
 for (i=0; i<len; i++)
  if (i != '0')
   break;
 if (i == len)
  return true;
 else
  return false;
}
function isValidKey(val, size)
{
 var ret = false;
 var len = val.length;
 var dbSize = size * 2;
 if (isAllZero(val)) //cathy
  return false;
 if (len == size)
  ret = true;
 else if (len == dbSize) {
  for (i = 0; i < dbSize; i++)
   if (isHexaDigit(val.charAt(i)) == false)
    break;
  if (i == dbSize)
   ret = true;
 }
 else
  ret = false;
 return ret;
}
function get_by_id(id)
{
 with(document) {
  return getElementById(id);
 }
}
function show_wpa_settings()
{
 get_by_id("show_wpa_psk2").style.display = "";
}
function show_authentication()
{
 var security = get_by_id("security_method");
 var form1 = document.formEncrypt;
 if (wlanMode==1 && security.value == 6) { /* client and WIFI_SEC_WPA2_MIXED */
  alert("Not allowed for the Client mode.");
  security.value = oldMethod;
  return false;
 }
 oldMethod = security.value;
 get_by_id("show_wep_auth").style.display = "none";
 get_by_id("setting_wep").style.display = "none";
 get_by_id("setting_wpa").style.display = "none";
 get_by_id("show_wpa_cipher").style.display = "none";
 get_by_id("show_wpa2_cipher").style.display = "none";
 if (security.value == 1) { /* WIFI_SEC_WEP */
  get_by_id("show_wep_auth").style.display = "";
  if (wlanMode == 1)
   get_by_id("setting_wep").style.display = "";
  else {
   get_by_id("setting_wep").style.display = "";
  }
 }else if (security.value == 2 || security.value == 4 || security.value == 6){ /* WIFI_SEC_WPA/WIFI_SEC_WPA2/WIFI_SEC_WPA2_MIXED */
  form1.ciphersuite_t.checked = false;
  form1.ciphersuite_a.checked = false;
  form1.wpa2ciphersuite_t.checked = false;
  form1.wpa2ciphersuite_a.checked = false;
  get_by_id("setting_wpa").style.display = "";
  if (security.value == 2) { /* WIFI_SEC_WPA */
   get_by_id("show_wpa_cipher").style.display = "";
   if(encrypt_value != security.value){
    form1.ciphersuite_t.checked = true;
   }
   else{
    if(cipher_value & 1)
     form1.ciphersuite_t.checked = true;
    if(cipher_value & 2)
     form1.ciphersuite_a.checked = true;
   }
  }
  if(security.value == 4) { /* WIFI_SEC_WPA2 */
   get_by_id("show_wpa2_cipher").style.display = "";
   if(encrypt_value != security.value){
    form1.wpa2ciphersuite_t.checked = false;
    form1.wpa2ciphersuite_a.checked = true;
   }
   else{
    if(wpa2cipher_value & 1)
     form1.wpa2ciphersuite_t.checked = true;
    if(wpa2cipher_value & 2)
     form1.wpa2ciphersuite_a.checked = true;
   }
  }
  if(security.value == 6){ /* WIFI_SEC_WPA2_MIXED */
   get_by_id("show_wpa_cipher").style.display = "";
   get_by_id("show_wpa2_cipher").style.display = "";
   if(encrypt_value != security.value){
    form1.ciphersuite_t.checked = true;
    form1.ciphersuite_a.checked = false;
    form1.wpa2ciphersuite_t.checked = false;
    form1.wpa2ciphersuite_a.checked = true;
   }
   else{
    if(cipher_value & 1)
     form1.ciphersuite_t.checked = true;
    if(cipher_value & 2)
     form1.ciphersuite_a.checked = true;
    if(wpa2cipher_value & 1)
     form1.wpa2ciphersuite_t.checked = true;
    if(wpa2cipher_value & 2)
     form1.wpa2ciphersuite_a.checked = true;
   }
  }
  show_wpa_settings();
 }
}
function setDefaultKeyValue(form, wlan_id)
{
 if (form.elements["length"+wlan_id].selectedIndex == 0) {
  if (form.elements["format"+wlan_id].selectedIndex == 0) {
   form.elements["key"+wlan_id].maxLength = 5;
   form.elements["key"+wlan_id].value = "*****";
/*		

			form.elements["key1"+wlan_id].maxLength = 5;

			form.elements["key2"+wlan_id].maxLength = 5;

			form.elements["key3"+wlan_id].maxLength = 5;

			form.elements["key4"+wlan_id].maxLength = 5;

			form.elements["key1"+wlan_id].value = "*****";

			form.elements["key2"+wlan_id].value = "*****";

			form.elements["key3"+wlan_id].value = "*****";

			form.elements["key4"+wlan_id].value = "*****";

*/
  }
  else {
   form.elements["key"+wlan_id].maxLength = 10;
   form.elements["key"+wlan_id].value = "**********";
/*		

			form.elements["key1"+wlan_id].maxLength = 10;

			form.elements["key2"+wlan_id].maxLength = 10;

			form.elements["key3"+wlan_id].maxLength = 10;

			form.elements["key4"+wlan_id].maxLength = 10;

			form.elements["key1"+wlan_id].value = "**********";

			form.elements["key2"+wlan_id].value = "**********";

			form.elements["key3"+wlan_id].value = "**********";

			form.elements["key4"+wlan_id].value = "**********";

*/
  }
 }
 else {
  if (form.elements["format"+wlan_id].selectedIndex == 0) {
   form.elements["key"+wlan_id].maxLength = 13;
   form.elements["key"+wlan_id].value = "*************";
/*		

			form.elements["key1"+wlan_id].maxLength = 13;

			form.elements["key2"+wlan_id].maxLength = 13;

			form.elements["key3"+wlan_id].maxLength = 13;

			form.elements["key4"+wlan_id].maxLength = 13;

			form.elements["key1"+wlan_id].value = "*************";

			form.elements["key2"+wlan_id].value = "*************";

			form.elements["key3"+wlan_id].value = "*************";

			form.elements["key4"+wlan_id].value = "*************";

*/
  }
  else {
   form.elements["key"+wlan_id].maxLength = 26;
   form.elements["key"+wlan_id].value ="**************************";
/*		

			form.elements["key1"+wlan_id].maxLength = 26;

			form.elements["key2"+wlan_id].maxLength = 26;

			form.elements["key3"+wlan_id].maxLength = 26;

			form.elements["key4"+wlan_id].maxLength = 26;

			form.elements["key1"+wlan_id].value ="**************************";

			form.elements["key2"+wlan_id].value ="**************************";

			form.elements["key3"+wlan_id].value ="**************************";

			form.elements["key4"+wlan_id].value ="**************************";

*/
  }
 }
 //form.elements["key"+wlan_id].value = wepkValue;
}
function updateWepFormat(form, wlan_id)
{
 if (form.elements["length" + wlan_id].selectedIndex == 0) {
  form.elements["format" + wlan_id].options[0].text = 'ASCII (5 characters)';
  form.elements["format" + wlan_id].options[1].text = 'Hex (10 characters)';
 }
 else {
  form.elements["format" + wlan_id].options[0].text = 'ASCII (13 characters)';
  form.elements["format" + wlan_id].options[1].text = 'Hex (26 characters)';
 }
 setDefaultKeyValue(form, wlan_id);
}
function check_wepkey()
{
 form = document.formEncrypt;
 var keyLen;
 if (form.length0.selectedIndex == 0) {
    if (form.format0.selectedIndex == 0)
   keyLen = 5;
  else
   keyLen = 10;
 }
 else {
  if (form.format0.selectedIndex == 0)
   keyLen = 13;
  else
   keyLen = 26;
 }
 if (form.key0.value.length != keyLen) {
  alert('<% multilang("191" "LANG_KEY_LENGTH"); %> <multilang("2654" "LANG_SHOULD_BE"); > ' + keyLen + '<% multilang("3065" "LANG_CHAR"); %>');
  form.key0.focus();
  return 0;
 }
 if (form.key0.value == "*****" ||
  form.key0.value == "**********" ||
  form.key0.value == "*************" ||
  form.key0.value == "**************************" )
  return 1;
 if (form.format0.selectedIndex==0)
  return 1;
 for (var i=0; i<form.key0.value.length; i++) {
  if ( (form.key0.value.charAt(i) >= '0' && form.key0.value.charAt(i) <= '9') ||
   (form.key0.value.charAt(i) >= 'a' && form.key0.value.charAt(i) <= 'f') ||
   (form.key0.value.charAt(i) >= 'A' && form.key0.value.charAt(i) <= 'F') )
   continue;
  alert("<% multilang("2479" "LANG_INVALID_KEY_VALUE_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F"); %>");
  form.key0.focus();
  return 0;
 }
 return 1;
}
function on_submit()
{
 form = document.formEncrypt;
 if (form.security_method.value == 0) { /* WIFI_SEC_NONE */
  alert("<% multilang("2488" "LANG_WARNING_SECURITY_IS_NOT_SETTHIS_MAY_BE_DANGEROUS"); %>"); //Warning : security is not set!this may be dangerous!
 }
 if (form.security_method.value == 1) { /* WIFI_SEC_WEP */
  if (check_wepkey() == false)
   return false;
  alert("<% multilang("2489" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_WEP"); %>"); //Info : WPS will be disabled when using WEP!
 }
  else if (form.security_method.value == 2 || form.security_method.value == 4 || form.security_method.value == 6) { /* WPA or WPA2 or WPA2 mixed */
  if (form.security_method.value == 2) { /* WIFI_SEC_WPA */
   if (form.ciphersuite_t.checked == false && form.ciphersuite_a.checked == false) {
    alert("<% multilang("2490" "LANG_WPA_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>"); //WPA Cipher Suite Can't be empty.
    return false;
   }
   if (form.ciphersuite_t.checked == true && form.ciphersuite_a.checked == true) {
    alert("<% multilang("2491" "LANG_CAN_NOT_SELECT_TKIP_AND_AES_IN_THE_SAME_TIME"); %>"); //Can't select TKIP and AES in the same time.
    return false;
   }
   alert("<% multilang("2492" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_WPA_ONLY"); %>"); //Info : WPS will be disabled when using WPA only!
  }
    if (form.security_method.value == 4) { /* WIFI_SEC_WPA2 */
   if (form.wpa2ciphersuite_t.checked == false && form.wpa2ciphersuite_a.checked == false) {
    alert("<% multilang("2493" "LANG_WPA2_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>"); //WPA2 Cipher Suite Can't be empty.
    return false;
   }
   if (form.wpa2ciphersuite_t.checked == true && form.wpa2ciphersuite_a.checked == true) {
    alert("<% multilang("2491" "LANG_CAN_NOT_SELECT_TKIP_AND_AES_IN_THE_SAME_TIME"); %>"); //Can't select TKIP and AES in the same time.
    return false;
   }
   if (form.wpa2ciphersuite_t.checked == true) {
    if (wps20)
     alert("<% multilang("2494" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_TKIP_ONLY"); %>"); //Info : WPS will be disabled when using TKIP only!
   }
    }
 if (form.security_method.value == 6) { /* WIFI_SEC_WPA2_MIXED */
   if (wlanMode == 1 && ((form.ciphersuite_t.checked == true && form.ciphersuite_a.checked == true)
    || (form.wpa2ciphersuite_t.checked == true && form.wpa2ciphersuite_a.checked == true))) {
    alert("<% multilang("2495" "LANG_IN_THE_CLIENT_MODE_YOU_CAN_T_SELECT_TKIP_AND_AES_IN_THE_SAME_TIME"); %>"); //In the Client mode, you can't select TKIP and AES in the same time.
    return false;
   }
   if (form.ciphersuite_t.checked == false && form.ciphersuite_a.checked == false) {
    alert("<% multilang("2490" "LANG_WPA_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>"); //WPA Cipher Suite Can't be empty.
    return false;
   }
   if (form.wpa2ciphersuite_t.checked == false && form.wpa2ciphersuite_a.checked == false) {
    alert("<% multilang("2493" "LANG_WPA2_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>"); //WPA2 Cipher Suite Can't be empty.
    return false;
   }
   if (wps20 && form.ciphersuite_t.checked == true && form.wpa2ciphersuite_t.checked == true
    && form.ciphersuite_a.checked == false && form.wpa2ciphersuite_a.checked == false)
    alert("<% multilang("2494" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_TKIP_ONLY"); %>"); //Info : WPS will be disabled when using TKIP only!
  }
  var str = form.pskValue.value;
  if (form.security_method.value > 1) {
   if(str.length == 64){
    for (var i=0; i<str.length; i++) {
     if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
       (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
       (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
       continue;
     alert("<% multilang("2481" "LANG_INVALID_PRE_SHARED_KEY_VALUE_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F"); %>");
     form.pskValue.focus();
     return false;
    }
    form.pskFormat.value = 1;
   }
   else{
    if (str.length < 8) {
     alert('<% multilang("2482" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_SET_AT_LEAST_8_CHARACTERS"); %>'); //Pre-Shared Key value should be set at least 8 characters.
     form.pskValue.focus();
     return false;
    }
    if (str.length > 63) {
     alert('<% multilang("2480" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_64_CHARACTERS"); %>'); //Pre-Shared Key value should be less than 64 characters.
     form.pskValue.focus();
     return false;
    }
    if (checkString(form.pskValue.value) == 0) {
     alert('<% multilang("2478" "LANG_INVALID_KEY_VALUE"); %>'); //Invalid Pre-Shared Key !
     form.pskValue.focus();
     return false;
    }
    form.pskFormat.value = 0;
   }
  }
 }
 with (document.forms[0]) {
  submit();
 }
}
function postSecurity(encrypt, enable1X, wpaAuth, wpaPSKFormat, wpaPSK, rsPort, rsIpAddr, rsPassword, uCipher, wpa2uCipher, wepAuth, wepLen, wepKeyFormat)
{
 document.formEncrypt.security_method.value = encrypt;
 encrypt_value = encrypt;
 cipher_value = uCipher;
 wpa2cipher_value = wpa2uCipher;
//	if (encrypt == 2 || encrypt == 3)	/* ENCRYPT_WPA_TKIP or ENCRYPT_WPA_AES */
//		document.formEncrypt.security_method.value = 2;	/* WIFI_SEC_WPA */
//	else if (encrypt == 4 || encrypt == 5)	/* ENCRYPT_WPA2_TKIP or ENCRYPT_WPA2_AES */
//		document.formEncrypt.security_method.value = 3;	/* WIFI_SEC_WPA2 */
//	else if (encrypt == 6)	/* ENCRYPT_WPA2_MIXED */
//		document.formEncrypt.security_method.value = 4;	/* WIFI_SEC_WPA2_MIXED */
//	else if (encrypt == 7)	/* ENCRYPT_WAPI */
//		document.formEncrypt.security_method.value = 5;	/* WIFI_SEC_WAPI */
//	else	/* ENCRYPT_DISABLED or ENCRYPT_WEP */
//		document.formEncrypt.security_method.value = encrypt;	/* WIFI_SEC_NONE or WIFI_SEC_WEP */
 document.formEncrypt.pskFormat.value = wpaPSKFormat;
 document.formEncrypt.pskValue.value = wpaPSK;
 document.formEncrypt.ciphersuite_t.checked = false;
 document.formEncrypt.ciphersuite_a.checked = false;
 if ( uCipher == 1 )
  document.formEncrypt.ciphersuite_t.checked = true;
 if ( uCipher == 2 )
  document.formEncrypt.ciphersuite_a.checked = true;
 if ( uCipher == 3 ) {
  document.formEncrypt.ciphersuite_t.checked = true;
  document.formEncrypt.ciphersuite_a.checked = true;
 }
 document.formEncrypt.wpa2ciphersuite_t.checked = false;
 document.formEncrypt.wpa2ciphersuite_a.checked = false;
 if ( wpa2uCipher == 1 )
  document.formEncrypt.wpa2ciphersuite_t.checked = true;
 if ( wpa2uCipher == 2 )
  document.formEncrypt.wpa2ciphersuite_a.checked = true;
 if ( wpa2uCipher == 3 ) {
  document.formEncrypt.wpa2ciphersuite_t.checked = true;
  document.formEncrypt.wpa2ciphersuite_a.checked = true;
 }
 document.formEncrypt.auth_type[wepAuth].checked = true;
 if ( wepLen == 0 )
  document.formEncrypt.length0.value = 1;
 else
  document.formEncrypt.length0.value = wepLen;
 document.formEncrypt.format0.value = wepKeyFormat+1;
 show_authentication();
 defPskLen = document.formEncrypt.pskValue.value.length;
 updateWepFormat(document.formEncrypt, 0);
}
function SSIDSelected(index)
{
 wlanMode = _wlan_mode[index];
 document.formEncrypt.isNmode.value = _wlan_isNmode[index];
 postSecurity(_encrypt[index], _enable1X[index],
  _wpaAuth[index], _wpaPSKFormat[index], _wpaPSK[index],
  _rsPort[index], _rsIpAddr[index], _rsPassword[index],
  _uCipher[index], _wpa2uCipher[index], _wepAuth[index],
  _wepLen[index], _wepKeyFormat[index]);
 document.formEncrypt.wpaSSID.length = 0;
 if(ssidIdx==0)
  document.formEncrypt.wpaSSID.options[0] = new Option("SSID1", "0", false, false);
 else
  document.formEncrypt.wpaSSID.options[0] = new Option("SSID5", "0", false, false);
 document.formEncrypt.wpaSSID.length = 1;
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onload="SSIDSelected(0)">
<blockquote>
<DIV align="left" style="padding-left:20px; padding-top:10px">
<form action=/boaform/admin/formWlEncrypt method=POST name="formEncrypt">
<b><% multilang("185" "LANG_WLAN_SECURITY_SETTINGS"); %></b><br>
<br><% multilang("186" "LANG_PAGE_DESC_WLAN_SECURITY_SETTING"); %><br>
<table width="540" border="0" cellpadding="0" cellspacing="4">
 <input type=hidden name="isNmode" value=0>
 <tr>
 <tr>
  <td width="35%"> SSID: </td>
  <td><select name="wpaSSID">
   <option value="0">SSID1</option>
   <!--% SSID_select %-->
  </select></td>
 </tr>
</table>
<table width="540" border="0" cellpadding="0" cellspacing="4">
 <tr><hr size=1 noshade align=top></tr>
 <tr><td width="35%"><% multilang("194" "LANG_AUTHENTICATION_MODE"); %>:</b>
  <select size="1" id="security_method" name="security_method" onChange="show_authentication()">
     <% checkWrite("wifiSecurity"); %>
  </select>
 <!-- <select style="display:none" size="1" id="method" name="method" onChange="show_authentication()">
   <% checkWrite("wpaEncrypt"); %>
  </select> -->
 </td></tr>
 <tr id="show_wep_auth" style="display:none">
  <td colspan="2" width="100%">
   <table width="100%" border="0" cellpadding="0" cellspacing="4">
    <tr>
     <td width="30%"><% multilnag("188" "LANG_AUTHENTICATION"); %>:</td>
     <td width="70%">
      <input name="auth_type" type=radio value="open"><% multilang("189" "LANG_OPEN_SYSTEM"); %>
      <input name="auth_type" type=radio value="shared"><% multilnag("190" "LANG_SHARED_KEY"); %>
      <input name="auth_type" type=radio value="both">Auto
     </td>
    </tr>
   </table>
  </td></tr>
 <tr id="setting_wep" style="display:none">
  <td colspan="2" width="100%">
   <table width="100%" border="0" cellpadding="0" cellspacing="4">
    <input type="hidden" name="wepEnabled" value="ON" checked>
    <tr >
     <td width="30%"><% multilnag("191" "LANG_KEY_LENGTH"); %>:</td>
     <td width="70%"><select size="1" name="length0" id="length" onChange="updateWepFormat(document.formEncrypt, 0)">
      <option value=1> 64-bit</option>
      <option value=2>128-bit</option>
     </select></td>
    </tr>
    <tr>
     <td width="30%"><% multilang("229" "LANG_KEY"); %>:</td>
     <td width="70%"><select id="format" name="format0" onChange="setDefaultKeyValue(document.formEncrypt, 0)">
      <option value="1">ASCII</option>
      <option value="2">Hex</option>
     </select></td>
    </tr>
    <tr>
     <td width="30%"><% multilang("1275" "LANG_NETWORK"); %> <% multilang("229" "LANG_KEY"); %>:</td>
     <td width="70%"><input type="text" id="key" name="key0" maxlength="26" size="26" value=""></td>
    </tr>
    <tr>
     <td>&nbsp;</td>
     <td><% multilang("3064" "LANG_WPA_NOTE"); %></td>
    </tr>
   </table>
  </td>
 </tr>
 <tr id="setting_wpa" style="display:none">
  <td colspan="2">
   <table width="100%" border="0" cellpadding="0" cellspacing="4">
    <input type="hidden" name="wpaAuth" value="psk" checked>
    <tr id="show_wpa_cipher" style="display:none">
     <td width="30%">WPA <% multilang("187" "LANG_ENCRYPTION"); %>:</td>
     <td width="70%">
      <input type="checkbox" name="ciphersuite_t" value=1>TKIP&nbsp;
      <input type="checkbox" name="ciphersuite_a" value=1>AES
     </td>
    </tr>
    <tr id="show_wpa2_cipher" style="display:none">
     <td width="30%">WPA2 <% multilang("187" "LANG_ENCRYPTION"); %>:</td>
     <td width="70%">
      <input type="checkbox" name="wpa2ciphersuite_t" value=1>TKIP&nbsp;
      <input type="checkbox" name="wpa2ciphersuite_a" value=1>AES
     </td>
    </tr>
    <tr id="show_wpa_psk2" style="display:none">
     <td width="30%">WPA <% multilang("198" "LANG_PRE_SHARED_KEY"); %>:</td>
     <td width="70%"><input type="text" name="pskValue" id="wpapsk" size="32" maxlength="64" value=""></td>
    </tr>
   </table>
  </td>
 </tr>
</table>
<br><br>
<table>
 <tr>
  <td width='180'><input type='button' onClick='on_submit()' value='<% multilang("827" "LANG_SAVE"); %>'></td>
  <td><input name="button" type='button' onClick ='history.back()' value='<% multilang("1193" "LANG_BACK"); %>'></td>
  <td>&nbsp;</td>
 </tr>
</table>
<input type='hidden' name="lst" >
<input type="hidden" name="submit-url" value="/net_wlan_adv.asp">
<input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
<input type="hidden" name="wlan_idx2" value="222">
<input type="hidden" name="pskFormat">
<script>
 //alert(getUrlVars()['wlan_idx']);
 //alert(window.location.pathname+window.location.search);
 //alert(document.getElementsByName("submit-url").value);
 <% initPage("wlwpa_mbssid"); %>
 <% checkWrite("wpsVer"); %>
 show_authentication();
 defPskLen = document.formEncrypt.pskValue.value.length;
 updateWepFormat(document.formEncrypt, 0);
 SSIDSelected(0);
</script>
</form>
</DIV>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
