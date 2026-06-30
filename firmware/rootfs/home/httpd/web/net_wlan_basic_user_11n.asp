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
var cgi_wlBssid = "wlBssid"; // wlBssid value
var enbl = true; // wlEnbl value: true means wireless is enabled, false means wireless is disable.
var ssid = "FTTH-one"; // SSID value
//var hiddenSSID = true; //Cancel the broadcast switch. False means to enable broadcasting, and true means not to enable broadcasting
var wlanMode = 1; // WLAN mode
var ssid_2g = "<% checkWrite("2G_ssid"); %>";
var ssid_5g = "<% checkWrite("5G_ssid"); %>";
var defaultBand = <% checkWrite("band"); %>;
var Band2G5GSupport = <% checkWrite("Band2G5GSupport"); %>;
var regDomain, defaultChan;
var _wlanEnabled = new Array();
//var _band = new Array();
var _ssid = new Array();
var _bssid = new Array();
//var _chan = new Array();
//var _chanwid = new Array();
//var _ctlband = new Array();
//var _txRate = new Array();
var _hiddenSSID = new Array();
//var _wlCurrentChannel = new Array();
//var _auto = new Array();
var wlan_num = <% checkWrite("wlan_num"); %>;
var wlan_sta_control = 0;
var wlan_module_enable = <% checkWrite("wlan_module_enable"); %>;
var wlan_rate_prior_enable = <% checkWrite("wlan_rate_prior_enable"); %>;
var _wlan_rate_prior = new Array();
<% init_wlan_page(); %>
/********************************************************************

**          on document load

********************************************************************/
function on_init()
{
 with (document.wlanSetup) {
  /* Tsai: the initial value */
  wlanEnabled.checked = wlan_module_enable;
  ssid.value = "<% getInfo("ssid"); %>";
  if(ssid.value.substr(0,9) == "ChinaNet-")
   ssid.value = ssid.value.substr(9);
  hiddenSSID.checked = _hiddenSSID[0];
  elements.wlan_idx.value = 0;
  /* Tsai: show or hide elements */
  wlSecCbClick(wlanEnabled);
  if(ssid_2g.substr(0,9) == "ChinaNet-")
   ssid_2g = ssid_2g.substr(9);
  if(ssid_5g.substr(0,9) == "ChinaNet-")
   ssid_5g = ssid_5g.substr(9);
 }
}
/********************************************************************

**          on document update

********************************************************************/
function wlSecCbClick(cb)
{
 var status = cb.checked;
 with (document.wlanSetup) {
  wlSecAll.style.display = status ? "block" : "none";
  if(status)
   advanced.style.display = wlSecInfo.style.display;
  else
   advanced.style.display = "none";
 }
 /*



	with (document.wlanSetup) {

		ssid.disabled = !status;

		hiddenSSID.disabled = !status;



		wlSecInfo.style.display = status ? "block" : "none";

		adminWlinfo.style.display = status ? "block" : "none";

		advanced.style.display = status ? "block" : "none";

  	}

	*/
}
/********************************************************************

**          on document submit

********************************************************************/
function on_submit()
{
 var str;
 with (document.wlanSetup) {
  if (wlanEnabled.checked) {
   str = ssid.value;
   //if (str.length == 0) {
   //	alert("SSID <% multilang(LANG_INVALID); %>");
   //	return;
   //}
   if (str.length > 32) {
    alert('SSID ' + str + ' <% multilang("2236" "LANG_LENGTH_SHOULD_LESS_THEN_32"); %>');
    return;
   }
   if (isIncludeInvalidChar(str)) {
    alert("<% multilang("2455" "LANG_INVALID_SSID"); %>");
    return;
   }
  }
  submit();
 }
}
function on_adv()
{
 var wlan_idx = document.wlanSetup.elements["wlan_idx"].value;
 var loc;
 if(wlan_num>1){
  if(wlan_sta_control==1)
   loc = 'boaform/admin/formWlanRedirect?redirect-url=/net_wlan_adv.asp&wlan_idx=0';
  else
  //loc = 'net_wlan_adv.asp?wlan_idx='+wlan_idx;
  loc = 'boaform/admin/formWlanRedirect?redirect-url=/net_wlan_adv.asp&wlan_idx='+wlan_idx;
 }
 else
  loc = 'net_wlan_adv.asp';
 var code = 'location.assign("' + loc + '")';
 eval(code);
}
function Set_SSIDbyBand()
{
 var c;
 with (document.wlanSetup) {
  if(document.getElementsByName('select_2g5g')[0].checked == true)
   c = document.getElementsByName('select_2g5g')[0].innerHTML.charAt(1);
  else
   c = document.getElementsByName('select_2g5g')[1].innerHTML.charAt(1);
  if (c == "5")
   ssid.value = ssid_5g;
  else if (c == "2")
   ssid.value = ssid_2g;
 }
}
function BandSelected(index)
{
 document.wlanSetup.elements["wlan_idx"].value = index;
//	document.wlanSetup.wlanEnabled.checked = _wlanEnabled[index];
//	document.wlanSetup.band.value = _band[index];
 if(wlan_sta_control==1 && index==1)
  document.wlanSetup.ssid.disabled = true;
 else
  document.wlanSetup.ssid.disabled = false;
 document.wlanSetup.ssid.value = _ssid[index];
 if(document.wlanSetup.ssid.value.substr(0,9) == "ChinaNet-")
  document.wlanSetup.ssid.value = document.wlanSetup.ssid.value.substr(9);
 document.getElementById('wlBssid').innerHTML = _bssid[index];
 //alert(_bssid[index]);
//	document.getElementById('cur_wlChannel').innerHTML = '<% multilang(LANG_CURRENT_CHANNEL); %>:  '+ _wlCurrentChannel[index];
 document.wlanSetup.hiddenSSID.checked = _hiddenSSID[index];
 document.getElementsByName('select_2g5g')[index].checked = true;
//	document.wlanSetup.chan.value = _chan[index];
//	document.wlanSetup.chanwid.selectedIndex = _chanwid[index];
//	document.wlanSetup.ctlband.selectedIndex = _ctlband[index];
//	txrate = _txRate[index];
//	auto = _auto[index];
//	updateBand(_band[index]);
//	get_rate(txrate);
//	updatePage();
 Set_SSIDbyBand();
 //wlan_idx = index;
 var status = _wlanEnabled[index];
 with (document.wlanSetup) {
  wlSecInfo.style.display = status ? "block" : "none";
  adminWlinfo.style.display = status ? "block" : "none";
  if(wlanEnabled.checked==false)
   advanced.style.display = "none";
  else
   advanced.style.display = status ? "block" : "none";
  if(wlan_rate_prior_enable==1)
   wlanRatePrior.checked = _wlan_rate_prior[index];
   }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onload="BandSelected(0)">
 <blockquote>
 <DIV align="left" style="padding-left:20px; padding-top:10px">
 <form action=/boaform/admin/formWlanSetup method="post" name="wlanSetup">
 <!-- Modified by Slim for bug#0003395 -->
 <b><% multilang("1279" "LANG_WIRELESS"); %> <% multilang("1218" "LANG_BASIC_SETTINGS"); %></b><br>
 <br>
    <% multilang("3586" "LANG_WLAN_BASIC_USER_PAGE_1"); %><br>
 <br>
    <% multilang("3587" "LANG_WLAN_BASIC_USER_PAGE_2"); %><br>
 <br>
 <table border="0" cellpadding="4" cellspacing="0">
  <tr>
   <td valign="middle" align="center" width="30" height="30">
    <input type='checkbox' name='wlanEnabled' onClick='wlSecCbClick(this);' value="ON"></td>
   <td><% multilang("234" "LANG_ENABLE"); %> <% multilang("1279" "LANG_WIRELESS"); %></td>
  </tr>
 </table>
 <div id='wlSecAll'>
 <div id='wlSecInfoDualband'>
 <table border="0" cellpadding="5" cellspacing="0">
  <tr>
  <td width=100% colspan="2">
   <% checkWrite("wlbandchoose"); %>
  </td>
  </tr>
 </table>
 </div>
 <div id='wlSecInfo'>
 <table border="0" cellpadding="4" cellspacing="0">
  <tr id="wlRatePrior" style="display:none">
   <td valign="middle" align="center" width="30" height="30">
    <input type='checkbox' name='wlanRatePrior' onClick='' value="ON"></td>
   <td><% multilang("3430" "LANG_ENABLE_RATE_PRIORITY"); %></td>
  </tr>
 </table>
 <table border="0" cellpadding="5" cellspacing="0">
  <tr>
   <td width="26%">SSID:</td>
   <td>
    ChinaNet-<input type='text' name='ssid' maxlength="32" size="32" value=""></td>
  </tr>
  <tr>
   <td width="26%">BSSID:</td>
   <td id='wlBssid'>
    <script language="javascript">
     document.writeln(cgi_wlBssid);
    </script>
   </td>
  </tr>
 </table>
 </div>
 <div id="adminWlinfo" style="display:none">
 <table width="337">
  <tr>
   <td width="26%"><% multilang("3588" "LANG_CANCEL_BROADCAST"); %>:</td>
   <td valign="middle" width="30" height="30">
    <input type='checkbox' name='hiddenSSID' value="ON"></td>
  </tr>
  <tr>
   <td width="26%">&nbsp;</td>
   <td colspan="2">&nbsp;</td>
  </tr>
 </table>
 </div>
 </div>
 <table width="295" border="0" cellpadding="4" cellspacing="0">
  <tr>
   <td><input type="hidden" value="/net_wlan_basic_user_11n.asp" name="submit-url"></td>
   <td width="162"><input type='button' onClick='on_submit()' value='<% multilang("827" "LANG_SAVE"); %>'></td>
   <td><input type='button' onClick='on_adv()' name="advanced" value='<% multilang("2698" "LANG_ADVANCED"); %>'></td>
   <td><input type="hidden" name="wlan_idx" value=0></td>
   <!-- End of bug#0003395-->
  </tr>
  <script>
    <% initPage("wle8basic"); %>
    on_init();
    //BandSelected(0);
  </script>
 </table>
 </form>
 </DIV>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
