<%SendWebHeadStr(); %>
<TITLE><% multilang("3431" "LANG_ADD_NETWORK_TRAFFIC_CONTROL_TYPE_RULE"); %></TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<style>
SELECT {width:200px;}
</style>
<!--System script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
var dscps = new it_nr("dscplst",
 new it(0, ""),
 new it(1, "(000000)"),
 new it(57, "AF13(001110)"),
 new it(49, "AF12(001100)"),
 new it(41, "AF11(001010)"),
 new it(33, "CS1(001000)"),
 new it(89, "AF23(010110)"),
 new it(81, "AF22(010100)"),
 new it(73, "AF21(010010)"),
 new it(65, "CS2(010000)"),
 new it(121, "AF33(011110)"),
 new it(113, "AF32(011100)"),
 new it(105, "AF31(011010)"),
 new it(97, "CS3(011000)"),
 new it(153, "AF43(100110)"),
 new it(145, "AF42(100100)"),
 new it(137, "AF41(100010)"),
 new it(129, "CS4(100000)"),
 new it(185, "EF(101110)"),
 new it(161, "CS5(101000)"),
 new it(193, "CS6(110000)"),
 new it(225, "CS7(111000)"));
var protos = new Array("", "TCP", "UDP", "ICMP", "TCP/UDP", "RTP");
var states = new Array("<% mutilang("233" "LANG_DISABLE"); %>", "<% multilang("234" "LANG_ENABLE"); %>");
var md802ps = new Array("", "0", "1", "2", "3", "4", "5", "6", "7");
var classTypes = new Array("<% multilang("3432" "LANG_GENERAL_MODE"); %>", "<% multilang("3433" "LANG_APPLICATION_TYPE"); %>");
var connTypes = new Array();
<% initConnType(); %>
var iffs = new Array(""<% checkWrite("qos_interface"); %>);
var quekeys = new it_nr("queuekey");
var oifkeys = new it_nr("outifkey");
var rules = new Array();
<% initQosRulePage(); %>
var sel1 = new Array("phypt", "proto", "dscp", "sip", "smsk", "spts", "spte", "dip", "dmsk", "dpts", "dpte", "smac", "dmac",
      "sip6", "sip6PrefixLen", "dip6", "dip6PrefixLen");
var sel2 = new Array("vlan1p");
var ipversions = new Array("<% multilang("3415" "LANG_FILTER_ADD_ERROR_15"); %>", "IPv4", "IPv6");
//default
quekeys.add(new it("", ""));
<% initRulePriority(); %>
<% initOutif(); %>
var opts = new Array(new Array("prio", quekeys), new Array("outif", oifkeys), new Array("proto", protos),
 new Array("mdscp", dscps), new Array("m1p", md802ps), new Array("phypt", iffs),
 new Array("dscp", dscps), new Array("vlan1p", md802ps), new Array("IpProtocolType", ipversions),
 new Array("conntype", connTypes), new Array("classtype", classTypes));
var rule = new it_nr("rule_");
var paramrl = sji_queryparam("rule");
rule.dec(paramrl);
// Check string,  only support  digit, charactor and underline
function checkstr(str)
{
 var ch="";
 if(typeof str != "string") return 0;
 for(var i =0;i< str.length; i++) {
  ch = str.charAt(i);
  if(!(ch =="_"||(ch<="9"&&ch>="0")||(ch<="z"&&ch>="a")||(ch<="Z"&&ch>="A"))) return 0;
 }
 return 1;
}
function onChange_proto()
{
/*	for(var n2 in sel2)
	{
		var oin = document.getElementById(sel2[n2]);
		if(typeof oin == "undefined")continue;
		if(oin.tagName == "SELECT")oin.selectedIndex = 0;
		else oin.value = "";
	}
*/
 with ( document.forms[0] )
 {
  if (proto.value == 3) {
   spts.disabled = true;
   spte.disabled = true;
   dpts.disabled = true;
   dpte.disabled = true;
  } else {
   spts.disabled = false;
   spte.disabled = false;
   dpts.disabled = false;
   dpte.disabled = false;
  }
 }
}
function onchange_sel1()
{
/*
	for(var n2 in sel2)
	{
		var oin = document.getElementById(sel2[n2]);
		if(typeof oin == "undefined")continue;
		if(oin.tagName == "SELECT")oin.selectedIndex = 0;
		else oin.value = "";
	}
	*/
 classtypeChange();
}
function onchange_sel2()
{
/*
	for(var n1 in sel1)
	{
		var oin = document.getElementById(sel1[n1]);
		if(typeof oin == "undefined")continue;
		if(oin.tagName == "SELECT")oin.selectedIndex = 0;
		else oin.value = "";
	}
	*/
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 for(var i in opts)
 {
  var slit = document.getElementById(opts[i][0]);
  if(typeof slit == "undefined")continue;
  for(var j in opts[i][1])
  {
   if(j == "name" || (typeof opts[i][1][j] != "string" && typeof opts[i][1][j] != "number"))continue;
   slit.options.add(new Option(opts[i][1][j], j));
  }
  slit.selectedIndex = 0;
 }
 for(var key in rule)
 {
  if((typeof rule[key] != "string" && typeof rule[key] != "number"))continue;
  if(typeof form[key] == "undefined")continue;
  form[key].value = rule[key];
 }
 if ( <%checkWrite("IPv6Show");%> )
 {
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ipprotbl').style.display = 'block';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ipprotbl.style.display = 'block';
   }
  }
  protocolChange();
 }
 classtypeChange();
//	on_iptypechange();
//	on_m1pchange();
}
// Mason Yu:20110524 ipv6 setting. START
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with ( document.forms[0] ) {
  var sbmtstr = "addrule";
  if(paramrl != null)
   sbmtstr = "editrule";
  sbmtstr = sbmtstr+"&conntype="+conntype.value;
  sbmtstr = sbmtstr+"&classtype="+classtype.value;
  sbmtstr = sbmtstr+"&index="+index.value;
  if(!checkstr(name.value)) {
   name.value="";
   name.focus();
   alert("<% multilang("3434" "LANG_NET_QOS_CLS_ERROR_1"); %>");
   return;
  } else {
   sbmtstr = sbmtstr+"&name="+name.value;
  }
  //sbmtstr = sbmtstr+"&state="+state.value;
  if(prio.value == "") {
   prio.focus();
   alert("<% multilang}("3435" "LANG_NET_QOS_CLS_ERROR_2"); %>");
   return;
  } else {
   sbmtstr = sbmtstr+"&prio="+prio.value;
  }
  //condition check
  if (phypt.value==0 && proto.value==0 && dscp.value==0 && (sip.value=="" ||
   sip.value=="0.0.0.0") && (spts.value==0 || spts.value=="") && (dip.value=="" ||
   dip.value=="0.0.0.0") && (dpts.value==0 || dpts.value=="") && vlan1p.value==0 &&
   smac.value=="" && dmac.value=="" && sip6.value=="" && dip6.value=="" && conntype.value==0)
  {
   alert("<% multilang("3436" "LANG_NET_QOS_CLS_ERROR_3"); %>");
   return;
  }
 //	if (proto.value==5) {//RTP
 //		if (dpts.value!=0 && dpts.value!="")
 //		{
 //			alert("RTP has been selected, destination port cannot be specified!");
 //			return;
 //		}
 //	}
  sbmtstr = sbmtstr+"&outif="+outif.value;
  sbmtstr = sbmtstr+"&markdscp="+mdscp.value;
  sbmtstr = sbmtstr+"&mark1p="+m1p.value;
  sbmtstr = sbmtstr+"&phyport="+phypt.value;
  sbmtstr = sbmtstr+"&proto="+proto.value;
  sbmtstr = sbmtstr+"&matchdscp="+dscp.value;
  if ( <%checkWrite("IPv6Show");%> ) {
   sbmtstr = sbmtstr+"&IPversion="+IpProtocolType.value;
   if(document.forms[0].IpProtocolType.value == 0) {
    alert("<% multilang("3415" "LANG_FILTER_ADD_ERROR_15" ); %>!");
    return;
   }
   // If this is a IPv4 rule
   if(document.forms[0].IpProtocolType.value == 1) {
    if(sip.value!=""&&!sji_checkip(sip.value)) {
     sip.value = "";
     sip.focus();
     alert("<% multilang("3437" "LANG_NET_QOS_CLS_ERROR_4"); %>,<% multilang(TRY_AGAIN); %>!");
     return;
    } else {
     sbmtstr = sbmtstr+"&sip="+sip.value;
    }
    if(smsk.value!=""&&!sji_checkmask(smsk.value)) {
     smsk.value="";
     smsk.focus();
     alert("<% multilang("3438" "LANG_NET_QOS_CLS_ERROR_5"); %>£¡");
     return;
    } else {
     sbmtstr = sbmtstr+"&smask="+smsk.value;
    }
    if(dip.value!=""&&!sji_checkip(dip.value)) {
     dip.value = "";
     dip.focus();
     alert("<% multilang("3439" "LANG_NET_QOS_CLS_ERROR_6"); %>,<% multilang("3080" "LANG_TRY_AGAIN"); %>!");
     return;
    } else {
     sbmtstr = sbmtstr+"&dip="+dip.value;
    }
   }
   else {
    //If this is IPv6 rule.
    if(document.forms[0].IpProtocolType.value == 2){
     if(sip6.value != ""){
      if (! isGlobalIpv6Address(sip6.value) ){
       alert("Invalid Source IPv6 address!");
       return;
      }
      if ( sip6PrefixLen.value != "" ) {
       var prefixlen= getDigit(sip6PrefixLen.value, 1);
       if (prefixlen > 128 || prefixlen <= 0) {
        alert("<% multilang("3440" "LANG_NET_QOS_CLS_ERROR_7"); %>!");
        return;
       }
      }
     }
     if(dip6.value != ""){
      if (! isGlobalIpv6Address(dip6.value) ){
       alert("<% multilang("3441" "LANG_NET_QOS_CLS_ERROR_8"); %>!");
       return;
      }
      if ( dip6PrefixLen.value != "" ) {
       var prefixlen= getDigit(dip6PrefixLen.value, 1);
       if (prefixlen > 128 || prefixlen <= 0) {
        alert("<% multilang("3442" "LANG_NET_QOS_CLS_ERROR_9"); %>!");
        return;
       }
      }
     }
     sbmtstr = sbmtstr+"&sip6="+sip6.value;
     sbmtstr = sbmtstr+"&dip6="+dip6.value;
     sbmtstr = sbmtstr+"&sip6PrefixLen="+sip6PrefixLen.value;
     sbmtstr = sbmtstr+"&dip6PrefixLen="+dip6PrefixLen.value;
    }
   }
  }
  else {
   if(sip.value!=""&&!sji_checkip(sip.value)) {
    sip.value = "";
    sip.focus();
    alert("<% multilang("3437" "LANG_NET_QOS_CLS_ERROR_4"); %>,<% multilang(TRY_AGAIN); %>!");
    return;
   } else {
    sbmtstr = sbmtstr+"&sip="+sip.value;
   }
   if(smsk.value!=""&&!sji_checkmask(smsk.value)) {
    smsk.value="";
    smsk.focus();
    alert("<% multilang("3438" "LANG_NET_QOS_CLS_ERROR_5"); %>");
    return;
   } else {
    sbmtstr = sbmtstr+"&smask="+smsk.value;
   }
   if(dip.value!=""&&!sji_checkip(dip.value)) {
    dip.value = "";
    dip.focus();
    alert("<% multilang("3439" "LANG_NET_QOS_CLS_ERROR_6"); %>,<% multilang(TRY_AGAIN); %>!");
    return;
   } else {
    sbmtstr = sbmtstr+"&dip="+dip.value;
   }
  }
  if(dmsk.value!=""&&!sji_checkmask(dmsk.value)) {
   dmsk.value="";
   dmsk.focus();
   alert("<% multilang("3443" "LANG_NET_QOS_CLS_ERROR_10"); %>!");
   return;
  } else {
   sbmtstr = sbmtstr+"&dmask="+dmsk.value;
  }
  if(spts.value<0||spts.value>65536) {
   spts.focus();
   alert("<% multilang("3444" "LANG_NET_QOS_CLS_ERROR_11"); %>!");
   return;
  } else {
   if (spts.value!=0 && ( (proto.value==0) || (proto.value==3) ) ) { //NONE or ICMP
    alert("<% multilang("3445" "LANG_NET_QOS_CLS_ERROR_12"); %>!");
    return;
   }
   sbmtstr = sbmtstr+"&spts="+spts.value;
  }
  if(spte.value<0||spte.value>65536) {
   spte.focus();
   alert("<% multilang("3446" "LANG_NET_QOS_CLS_ERROR_13"); %>!");
   return;
  } else {
   if (spte.value!=0 && ( (proto.value==0) || (proto.value==3) ) ) { //NONE or ICMP
    alert("<% multilang("3445" "LANG_NET_QOS_CLS_ERROR_12"); %>!");
    return;
   }
   sbmtstr = sbmtstr+"&spte="+spte.value;
  }
  if(dpts.value<0||dpts.value>65536) {
   dpts.focus();
   alert("<% multilang("3447" "LANG_NET_QOS_CLS_ERROR_14"); %>!");
   return;
  } else {
   if (dpts.value!=0 && ( (proto.value==0) || (proto.value==3) ) ) { //NONE or ICMP	
    alert("<% multilang("3445" "LANG_NET_QOS_CLS_ERROR_12"); %>!");
    return;
   }
   sbmtstr = sbmtstr+"&dpts="+dpts.value;
  }
  if(dpte.value<0||dpte.value>65536) {
   dpte.focus();
   alert("<% multilang("3448" "LANG_NET_QOS_CLS_ERROR_15"); %>!");
   return;
  } else {
   if (dpte.value!=0 && ( (proto.value==0) || (proto.value==3) ) ) { //NONE or ICMP	
    alert("<% multilang("3445" "LANG_NET_QOS_CLS_ERROR_12"); %>!");
    return;
   }
   sbmtstr = sbmtstr+"&dpte="+dpte.value;
  }
  if(smac.value!=""&&!sji_checkmac2(smac.value)) {
   smac.value = "";
   smac.focus();
   alert("<% multilang("3449" "LANG_NET_QOS_CLS_ERROR_16"); %>,<% multilang(TRY_AGAIN); %>!");
   return;
  } else {
   sbmtstr = sbmtstr+"&smac="+smac.value;
  }
  if(dmac.value!=""&&!sji_checkmac2(dmac.value)) {
   dmac.value = "";
   dmac.focus();
   alert("<% multilang("3450" "LANG_NET_QOS_CLS_ERROR_17"); %>,<% multilang(TRY_AGAIN); %>!");
   return;
  } else {
   sbmtstr = sbmtstr+"&dmac="+dmac.value;
  }
  sbmtstr = sbmtstr+"&vlan1p="+vlan1p.value;
  lst.value = sbmtstr;
  submit();
 }
}
function protocolChange()
{
 // If protocol is IPv4 only.
 if(document.forms[0].IpProtocolType.value == 1){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ip4tbl').style.display = 'block';
   document.getElementById('ip6tbl').style.display = 'none';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'block';
    document.all.ip6tbl.style.display = 'none';
   }
  }
  if(sip.value=="0.0.0.0")
   sip.value = "";
  if(dip.value=="0.0.0.0")
   dip.value = "";
 }
 // If protocol is IPv6 only.
 else if(document.forms[0].IpProtocolType.value == 2){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ip4tbl').style.display = 'none';
   document.getElementById('ip6tbl').style.display = 'block';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'none';
    document.all.ip6tbl.style.display = 'block';
   }
  }
  if(sip6.value=="::")
   sip6.value = "";
  if(dip6.value=="::")
   dip6.value = "";
  if(sip6PrefixLen.value==0)
   sip6PrefixLen.value="";
  if(dip6PrefixLen.value==0)
   dip6PrefixLen.value="";
 }
 if(spts.value==0)
  spts.value="";
 if(spte.value==0)
  spte.value="";
 if(dpts.value==0)
  dpts.value="";
 if(dpte.value==0)
  dpte.value="";
 if(smac.value=="00:00:00:00:00:00")
  smac.value="";
 if(dmac.value=="00:00:00:00:00:00")
  dmac.value="";
}
function classtypeChange()
{
 if(document.forms[0].classtype.value == 0){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('appbasedlist').style.display = 'none';
   document.getElementById('normallist').style.display = 'block';
  }
  else
  {
   document.all.appbasedlist.style.display = 'none';
   document.all.normallist.style.display = 'block';
  }
  conntype.value = 0;
 }
 else{
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('appbasedlist').style.display = 'block';
   document.getElementById('normallist').style.display = 'none';
  }
  else
  {
   document.all.appbasedlist.style.display = 'block';
   document.all.normallist.style.display = 'none';
  }
  phypt.value=0;proto.value=0;dscp.value=0;prio.value=0;
  sip.value="";smsk.value="";dip.value="";dmsk.value="";
  vlan1p.value="";sip6.value="";sip6PrefixLen.value="";
  dip6.value="";dip6PrefixLen.value="";spts.value="";
  dpts.value="";spte.value="";dpte.value="";smac.value="";
  dmac.value="";
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formQosRuleEdit" method="post">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3431" "LANG_ADD_NETWORK_TRAFFIC_CONTROL_TYPE_RULE"); %></p><br>
  <p class="intro_content"><% multilang("3451" "LANG_NET_QOS_CLS_PAGE_1"); %></p><br>
  <p class="intro_content"><% multilang("3452" "LANG_NET_QOS_CLS_PAGE_2"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <div id='ipprotbl' style="display:none">
    <tr>
     <th width=40%><% multilang("3459" "LANG_IP_PROTOCOL_VERSION"); %>:</th>
     <td><select id="IpProtocolType" size="1" style="width:200px " onChange="protocolChange()" name="IpProtocolType"></select></td>
    </tr>
   </div>
    <tr><th width=40%><% multilang("3460" "LANG_FLOW_CONTROL_TYPE_NAME"); %>:</th><td><input type="text" id="name" size="22" style="width:200px "></td></tr>
  </table>
 </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3453" "LANG_NET_QOS_CLS_PAGE_3"); %></p><br>
  <p class="intro_content"><% multilang("3454" "LANG_NET_QOS_CLS_PAGE_4"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr><th width=40%><% multilang("3455" "LANG_NET_QOS_CLS_PAGE_5"); %>:</th><td><select id="prio" size="1"></select></td></tr>
   <tr><th width=40%><% multilang("3456" "LANG_NET_QOS_CLS_PAGE_6"); %>:</th><td><select id="mdscp" size="1"></select></td></tr>
   <tr><th width=40%><% multilang("3457" "LANG_NET_QOS_CLS_PAGE_7"); %>:</th><td><select id="m1p" size="1"></select></td></tr>
  </table>
 </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3461" "LANG_SORT_MODE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr><th width=40%><% multilang("3462" "LANG_MODE_SELECTION"); %>: </th><td><select id="classtype" size="1" style="width:200px " onChange="onchange_sel1()" name="classtype"></select></td></tr>
  </table>
 </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3458" "LANG_NET_QOS_CLS_PAGE_8"); %></p><br>
 </div>
 <div class="data_common data_common_notitle" id='appbasedlist' style="display:block;">
  <table>
    <tr><th width=40%><% multilang("3045" "LANG_CONNECT_TYPE"); %>:</th><td><select id="conntype" size="1" style="width:200px " name="connTypes"></select></td></tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='normallist' style="display:block;">
  <table>
   <tr><th width=40%><% multilang("3463" "LANG_PHYSICAL_LAN_PORT"); %>:</th><td><select id="phypt" size="1" style="width:200px " onChange="onchange_sel1();"></select></td></tr>
   <tr><th width=40%><% multilang("93" "LANG_PROTOCOL"); %>: </th><td><select id="proto" size="1" style="width:200px " onChange="onChange_proto();"></select></td></tr>
   <tr><th width=40%><% multilang("3464" "LANG_DSCP_CHECK"); %>:</th><td><select id="dscp" size="1" style="width:200px " onChange="onchange_sel1();"></select></td></tr>
   <tr><th width=40%><% multilang("3465" "LANG_8021P_PROORITY"); %>:</th><td><select id="vlan1p" size="1" style="width:200px " onChange="onchange_sel2();"></select></td></tr>
  </table>
 <div class="data_common data_common_notitle" id='ip4tbl' style="display:block;">
  <table>
   <tr><th width=40%><% multilang("3466" "LANG_SOURCE_IP_ADDRESS"); %>: </th><td><input type="text" id="sip" size="15" maxlength="15" style="width:200px " onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3467" "LANG_SOURCE_SUBNET_MASK_TITLE"); %>: </th><td><input type="text" id="smsk" size="15" maxlength="15" style="width:200px " onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3468" "LANG_DESTINATION_IP_ADDRESS_TITLE"); %>: </th><td><input type="text" id="dip" size="15" maxlength="15" style="width:200px " onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3469" "LANG_DESTINATION_SUBNET_MASK_TITLE"); %>: </th><td><input type="text" id="dmsk" size="15" maxlength="15" style="width:200px " onChange="onchange_sel1();"></td></tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='ip6tbl' style="display:none">
  <table>
   <tr><th width=40%><% multilang("3466" "LANG_SOURCE_IP_ADDRESS"); %>: </th><td><input type="text" id="sip6" size="36" maxlength="39" style="width:200px " onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3470" "LANG_SOURCE_PREFIX_LENGTH_TITILE"); %>: </th><td><input type="text" id="sip6PrefixLen" size="15" maxlength="15" style="width:200px " onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3468" "LANG_DESTINATION_IP_ADDRESS_TITLE"); %>: </th><td><input type="text" id="dip6" size="36" maxlength="39" style="width:200px " onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multiang("3471" "LANG_DESTINATION_PREFIX_LENGTH_TITILE"); %>: </th><td><input type="text" id="dip6PrefixLen" size="15" maxlength="15" style="width:200px " onChange="onchange_sel1();"></td></tr>
  </table>
 </div>
  <table>
   <tr><th width=40%><% multilang("3472" "LANG_SOURCE_PORT_TITLE"); %>: </th><td><input type="text" id="spts" size="5" maxlength="5" style="width:97px" onChange="onchange_sel1();">:<input type="text" id="spte" size="5" maxlength="5" style="width:97px" onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3473" "LANG_DESTINATION_PORT_TITLE"); %>: </th><td><input type="text" id="dpts" size="5" maxlength="5" style="width:97px" onChange="onchange_sel1();">:<input type="text" id="dpte" size="5" maxlength="5" style="width:97px" onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3474" "LANG_SOURCE_MAC_TITLE"); %>:</th><td><input type="text" id="smac" size="17" maxlength="17" style="width:200px " onChange="onchange_sel1();"></td></tr>
   <tr><th width=40%><% multilang("3475" "LANG_DESTINATION_MAC_TITLE"); %>:</th><td><input type="text" id="dmac" size="17" maxlength="17" style="width:200px " onChange="onchange_sel1();"></td></tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id='wan_interface' style="display:none">
  <table>
   <tr><th width=40%><% multilang("3476" "LANG_WAN_INTERFACE_TITILE"); %>: </th><td><select id="outif" size="1"></select></td></tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="on_submit();" value="<% multilang("827" "LANG_SAVE"); %>">
  <input type="hidden" name="submit-url" value="/net_qos_cls.asp">
  <input type="hidden" name="lst" value="">
  <input type="hidden" name="index" value="0">
 </div>
 <br>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
