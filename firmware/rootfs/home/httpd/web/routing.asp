<%SendWebHeadStr(); %>
<TITLE>Static Routing</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" type="text/javascript">
function postGW( enable, destNet, subMask, nextHop, metric, interface, select )
{
 document.route.enable.checked = enable;
 document.route.destNet.value=destNet;
 document.route.subMask.value=subMask;
 document.route.nextHop.value=nextHop;
 document.route.metric.value=metric;
 document.route.interface.value=interface;
 document.route.select_id.value=select;
}
function checkDest(ip, mask)
{
 var i, dip, dmask, nip;
 for (i=1; i<=4; i++) {
  dip = getDigit(ip.value, i);
  dmask = getDigit(mask.value, i);
  nip = dip & dmask;
  if (nip != dip)
   return true;
 }
 return false;
}
function addClick()
{
 /*if (document.route.destNet.value=="") {
		alert("Enter Destination Network ID !");
		document.route.destNet.focus();
		return false;
	}
	
	if ( validateKey( document.route.destNet.value ) == 0 ) {
		alert("Invalid Destination value.");
		document.route.destNet.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.destNet.value,1,0,255) ) {
		alert('Invalid Destination range in 1st digit. It should be 0-255.');
		document.route.destNet.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.destNet.value,2,0,255) ) {
		alert('Invalid Destination range in 2nd digit. It should be 0-255.');
		document.route.destNet.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.destNet.value,3,0,255) ) {
		alert('Invalid Destination range in 3rd digit. It should be 0-255.');
		document.route.destNet.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.destNet.value,4,0,254) ) {
		alert('Invalid Destination range in 4th digit. It should be 0-254.');
		document.route.destNet.focus();
		return false;
	}
	
	if (document.route.subMask.value=="") {
		alert("Enter Subnet Mask !");
		document.route.subMask.focus();
		return false;
	}
	
	if ( validateKey( document.route.subMask.value ) == 0 ) {
		alert("Invalid Subnet Mask value.");
		document.route.subMask.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.subMask.value,1,0,255) ) {
		alert('Invalid Subnet Mask range in 1st digit. It should be 0-255.');
		document.route.subMask.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.subMask.value,2,0,255) ) {
		alert('Invalid Subnet Mask range in 2nd digit. It should be 0-255.');
		document.route.subMask.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.subMask.value,3,0,255) ) {
		alert('Invalid Subnet Mask range in 3rd digit. It should be 0-255.');
		document.route.subMask.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.subMask.value,4,0,255) ) {
		alert('Invalid Subnet Mask range in 4th digit. It should be 0-255.');
		document.route.subMask.focus();
		return false;
	}
	if (document.route.interface.value==65535) {
	if (document.route.nextHop.value=="" ) {
		alert("Enter Next Hop IP or select a GW interface!");
		document.route.nextHop.focus();
		return false;
	}
	
	if ( validateKey( document.route.nextHop.value ) == 0 ) {
		alert("Invalid Next Hop value.");
		document.route.nextHop.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.nextHop.value,1,0,255) ) {
		alert('Invalid Next Hop range in 1st digit. It should be 0-255.');
		document.route.nextHop.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.nextHop.value,2,0,255) ) {
		alert('Invalid Next Hop range in 2nd digit. It should be 0-255.');
		document.route.nextHop.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.nextHop.value,3,0,255) ) {
		alert('Invalid Next Hop range in 3rd digit. It should be 0-255.');
		document.route.nextHop.focus();
		return false;
	}
	if ( !checkDigitRange(document.route.nextHop.value,4,1,254) ) {
		alert('Invalid Next Hop range in 4th digit. It should be 1-254.');
		document.route.nextHop.focus();
		return false;
	}*/
 if (checkDest(document.route.destNet, document.route.subMask) == true) {
  alert("<% multilang("2374" "LANG_THE_SPECIFIED_MASK_PARAMETER_IS_INVALID_DESTINATION_MASK_DESTINATION"); %>");
  document.route.subMask.focus();
  return false;
 }
 if (!checkHostIP(document.route.destNet, 1))
  return false;
 if (!checkNetmask(document.route.subMask, 1))
  return false;
 if (document.route.interface.value==65535) {
  if (document.route.nextHop.value=="" ) {
   alert("<% multilang("2368" "LANG_ENTER_NEXT_HOP_IP_OR_SELECT_A_GW_INTERFACE"); %>");
   document.route.nextHop.focus();
   return false;
  }
  if (!checkHostIP(document.route.nextHop, 0))
   return false;
 }
 if ( !checkDigitRange(document.route.metric.value,1,0,16) ) {
  alert("<% multilang("2375" "LANG_INVALID_METRIC_RANGE_IT_SHOULD_BE_0_16"); %>");
  document.route.metric.focus();
  return false;
 }
 return true;
}
function routeClick(url)
{
 var wide=600;
 var high=400;
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
    var xMax = 640, yMax=480;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open( url, 'RouteTbl', settings );
}
/*  Added by Slim on 2018-09-06   */
function deleteClick()
{
 if ( !confirm("<% multilang("3477" "LANG_DELETE_THIS_SETTTING") %>")) {
  return false;
 }
 else
  return true;
}
function checkHostIP(ip, checkEmpty)
{
 if (checkEmpty == 1 && ip.value=="") {
  alert("<% multilang("3563" "LANG_CHECK_IP_ERR_1"); %>"); //IP地址不能是空的! 格式为 xxx.xxx.xxx.xxx.
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (validateKey(ip.value) == 0) {
  alert("<% multilang("3564" "LANG_CHECK_IP_ERR_2"); %>"); //IP地址无效. 必须是(0-9)的数字.
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (IsLoopBackIP(ip.value)==1 || IsInvalidIP(ip.value)==1) {
  alert("<% multilang("3565" "LANG_CHECK_IP_ERR_3"); %>"); //IP地址无效.
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 1, 1, 223)) {
  alert('<% multilang("3566" "LANG_CHECK_IP_ERR_4"); %>'); //IP地址的第一个位元无效. 必须是 1-223的数值.
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 2, 0, 255)) {
  alert('<% multilang("3567" "LANG_CHECK_IP_ERR_5"); %>'); //IP地址的第二个位元无效. I必须是 0-255的数值.
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 3, 0, 255)) {
  alert('<% multilang("3568" "LANG_CHECK_IP_ERR_6"); %>'); //IP地址的第三个位元无效. 必须是 0-255的数值.
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 if (!checkDigitRange(ip.value, 4, 0, 254)) {
  alert('<% multilang("3569" "LANG_CHECK_IP_ERR_7"); %>'); //IP地址的第四个位元无效. 必须是 0-254的数值.
  ip.value = ip.defaultValue;
  ip.focus();
  return false;
 }
 return true;
}
/* End of added */
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form action=/boaform/formRouting method=POST name="route">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("37" "LANG_ROUTING"); %><% multilang("224" "LANG_CONFIGURATION"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <td width="30%"><% multilang("234" "LANG_ENABLE"); %>:</td>
    <td width="70%"><input type="checkbox" name="enable" value="1" checked></td>
   </tr>
   <tr>
    <td width="30%"><% multilang("371" "LANG_DESTINATION"); %>:</td>
    <td width="70%"><input type="text" name="destNet" size="15" maxlength="15"></td>
   </tr>
   <tr>
    <td width="30%"><% multilang("88" "LANG_SUBNET_MASK"); %>:</td>
    <td width="70%"><input type="text" name="subMask" size="15" maxlength="15"></td>
   </tr>
   <tr>
    <td width="30%"><% multilang("94" "LANG_GATEWAY"); %>:</td>
    <td width="70%"><input type="text" name="nextHop" size="15" maxlength="15"></td>
   </tr>
   <tr>
    <td width="30%"><% multilang("423" "LANG_METRIC"); %>:</td>
    <td width="70%"><input type="text" name="metric" size="5" maxlength="5"></td>
   </tr>
   <tr>
    <td width="30%"><% multilang("68" "LANG_INTERFACE"); %>:</td>
    <td width="70%"><select name="interface"><% if_wan_list("rt-any");%></select></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="hidden" value="" name="select_id">
  <input class="link_bg" type="submit" value="<% multilang("424" "LANG_ADD_ROUTE"); %>" name="addRoute" onClick="return addClick()">&nbsp;&nbsp;
  <input class="link_bg" type="submit" value="<% multilang("425" "LANG_UPDATE"); %>" name="updateRoute" onClick="return addClick()">&nbsp;&nbsp;
  <input class="link_bg" type="submit" value="<% multilang("210" "LANG_DELETE_SELECTED"); %>" name="delRoute" onClick="return deleteClick()">&nbsp;&nbsp;
  <input class="link_bg" type="button" value="<% multilang("426" "LANG_SHOW_ROUTES"); %>" name="showRoute" onClick="routeClick('/routetbl.asp')">
 </div>
 <br><br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("427" "LANG_STATIC_ROUTE_TABLE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table>
     <% showStaticRoute(); %>
  </table>
 </div>
 <br>
      <input type="hidden" value="/routing.asp" name="submit-url">
  <!--
  <% GetDefaultGateway(); %>
  -->
</form>
</blockquote>
</body>
</html>
