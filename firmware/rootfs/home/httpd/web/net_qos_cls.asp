<%SendWebHeadStr(); %>
<TITLE>QoS Setting</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
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
 new it(225, "CS7(111000)")
);
var iffs = new Array(""<% checkWrite("qos_interface"); %>);
var protos = new Array("", "TCP", "UDP", "ICMP", "TCP/UDP", "RTP");
//var protos = new Array("", "TCP", "UDP", "ICMP"); //Remove TCP/UDP, since e8 not require this, and in RG, this need to acl rules.
              //So if user need this, just use web to add two QoS rules.
var rules = new Array();
<% initQosRulePage(); %>
/*
function on_chkstate(index)
{
	if(index < 0 || index >= rules.length)
		return; 
	rules[index].state = !rules[index].state;
//	rules[index].dirty = true;
}
*/
function on_chkclick(index)
{
 if(index < 0 || index >= rules.length)
  return;
 rules[index].select = !rules[index].select;
}
function on_onedit(index)
{
 if(index < 0 || index >= rules.length)
  return;
 window.location.href = "net_qos_cls_edit.asp?rule=" + rules[index].enc();
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 if(lstrc.rows){while(lstrc.rows.length > 2) lstrc.deleteRow(2);}
 for(var i = 0; i < rules.length; i++)
 {
  //var bcheck = " ";
  var row = lstrc.insertRow(i + 2);
  var strprio = "";
  row.nowrap = true;
  row.vAlign = "center";
  row.align = "left";
  var cell = row.insertCell(0);
  cell.innerHTML = rules[i].index;
  cell = row.insertCell(1);
  cell.innerHTML = rules[i].name;
  cell = row.insertCell(2);
  if (rules[i].mdscp != "0") {
   cell.innerHTML = rules[i].mdscp-1;
  } else
   cell.innerHTML = "";
  cell = row.insertCell(3);
  //strprio = rules[i].prio.split("|");
        //cell.innerHTML = strprio[1];
  cell.innerHTML = rules[i].prio;
  cell = row.insertCell(4);
  if (rules[i].m1p != "0") {
   cell.innerHTML = rules[i].m1p-1;
  } else
   cell.innerHTML = "";
  cell = row.insertCell(5);
  cell.innerHTML = iffs[rules[i].phypt];
  cell = row.insertCell(6);
  cell.innerHTML = protos[rules[i].proto];
  cell = row.insertCell(7);
  //cell.innerHTML = dscps[rules[i].dscp];
  if (rules[i].dscp != "0") {
   cell.innerHTML = rules[i].dscp-1;
  } else
   cell.innerHTML = "";
  cell = row.insertCell(8);
  // For IPv4 and IPv6 
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if ( rules[i].IpProtocolType == "1 ") {
    if (rules[i].sip == "0.0.0.0")
     cell.innerHTML = "";
    else {
     if(rules[i].smsk == "")
      cell.innerHTML = rules[i].sip;
     else
      cell.innerHTML = rules[i].sip + "/" + rules[i].smsk;
    }
   }
   // For IPv6
   else if ( rules[i].IpProtocolType == "2" ) {
    if (rules[i].sip6 == "::")
     cell.innerHTML = "";
    else {
     if(rules[i].sip6PrefixLen == "")
      cell.innerHTML = rules[i].sip6;
     else
      cell.innerHTML = rules[i].sip6 + "/" + rules[i].sip6PrefixLen;
    }
   }
  }
  // For IPv4 only
  else {
   if (rules[i].sip == "0.0.0.0")
    cell.innerHTML = "";
   else {
    if(rules[i].smsk == "")
     cell.innerHTML = rules[i].sip;
    else
     cell.innerHTML = rules[i].sip + "/" + rules[i].smsk;
   }
  }
  cell = row.insertCell(9);
  if (rules[i].spts == "0")
   cell.innerHTML = "";
  else if (rules[i].spte == "0")
   cell.innerHTML = rules[i].spts;
  else
   cell.innerHTML = ((typeof rules[i].spte == "undefined") ? rules[i].spts : rules[i].spts + ":" + rules[i].spte);
  cell = row.insertCell(10);
  // For IPv4 and IPv6 
  if ( <%checkWrite("IPv6Show");%> ) {
   // For IPv4
   if ( rules[i].IpProtocolType == "1" ) {
    if (rules[i].dip == "0.0.0.0")
     cell.innerHTML = "";
    else {
     if(rules[i].dmsk == "")
      cell.innerHTML = rules[i].dip;
     else
      cell.innerHTML = rules[i].dip + "/" + rules[i].dmsk;
    }
   }
   // For IPv6
   else if ( rules[i].IpProtocolType == "2" ) {
    if (rules[i].dip6 == "::")
     cell.innerHTML = "";
    else {
     if(rules[i].dip6PrefixLen == "")
      cell.innerHTML = rules[i].dip6;
     else
      cell.innerHTML = rules[i].dip6 + "/" + rules[i].dip6PrefixLen;
    }
   }
  }
  // For IPv4 only
  else {
   if (rules[i].dip == "0.0.0.0")
    cell.innerHTML = "";
   else {
    if(rules[i].dmsk == "")
     cell.innerHTML = rules[i].dip;
    else
     cell.innerHTML = rules[i].dip + "/" + rules[i].dmsk;
   }
  }
  cell = row.insertCell(11);
  if (rules[i].dpts == "0")
   cell.innerHTML = "";
  else if (rules[i].dpte == "0")
   cell.innerHTML = rules[i].dpts;
  else
   cell.innerHTML = rules[i].dpts + ":" + rules[i].dpte;
  cell = row.insertCell(12);
  cell.innerHTML = ((rules[i].smac=="00:00:00:00:00:00")?"":rules[i].smac);
  cell = row.insertCell(13);
  cell.innerHTML = ((rules[i].dmac=="00:00:00:00:00:00")?"":rules[i].dmac);
  cell = row.insertCell(14);
  if (rules[i].vlan1p != "0") {
   cell.innerHTML = rules[i].vlan1p-1;
  } else
   cell.innerHTML = "";
  /*
		cell = row.insertCell(15);
		cell.align = "center";
		if(rules[i].state)
			bcheck = "checked";
		cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkstate(" + i + ");\" "+bcheck+">";
		*/
  cell = row.insertCell(15);
  cell.align = "center";
  cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
  cell = row.insertCell(16);
  cell.align = "center";
  cell.innerHTML = "<input type=\"button\" onClick=\"on_onedit(" + i + ");\" value=\"<% multilang("669" "LANG_EDIT"); %>\">";
  cell = row.insertCell(17);
  if ( <%checkWrite("IPv6Show");%> ) {
   if (rules[i].IpProtocolType == "1")
    cell.innerHTML = "IPv4";
   else if (rules[i].IpProtocolType == "2")
    cell.innerHTML = "IPv6";
  }
  else {
   cell.innerHTML = "IPv4";
  }
  cell = row.insertCell(18);
  if(rules[i].conntypeStr != "")
   cell.innerHTML += rules[i].conntypeStr;
  else
   cell.innerHTML += "none"
 }
}
function rc2string(it)
{
 return it.index + "," + Number(it.state) + "," + Number(it.select);// + "|" + it.tporte + "|" + it.oprotocol + "|" + it.oportb + "|" + it.oporte; 
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 var tmplst = "";
 var first = true;
 if (rules.length == 0)
  return;
 with ( document.forms[0] )
 {
  for(var i = 0; i < rules.length; i++)
  {
   if(first)
   {
    first = false;
   }
   else
   {
    tmplst += "&";
   }
   tmplst += rc2string(rules[i]);
  }
  lst.value = tmplst;
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formQosRule" method="post">
 <div class="intro_main ">
  <p class="intro_title">QoS <% multilang("224" "LANG_CONFIGURATION"); %></p><br>
  <p class="intro_content"><% multilang("661" "LANG_PAGE_DESC_CLASSICY_QOS_RULE"); %></p><br>
 </div>
 <div class="tip" style="width:100% ">
  <font color="red">(<% multilang("662" "LANG_PAGE_DESC_CLASSICY_QOS_RULE_EXTRA"); %>)</font>
 </div>
 <br>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lstrc">
   <tr align="center" nowrap>
    <td colspan="2">&nbsp;</td>
    <td colspan="3"><% multilang("664" "LANG_MARK"); %></td>
    <td colspan="10"><% multilang("663" "LANG_CLASSIFICATION_RULES"); %></td>
    <td colspan="4">&nbsp;</td>
   </tr>
   <tr align="center" nowrap>
    <th><% multilang("665" "LANG_ID"); %></th>
    <th><% multilang("667" "LANG_NAME"); %></th>
    <th>DSCP <% multilang("664" "LANG_MARK"); %></th>
    <th>IP <% multilang("657" "LANG_PRIORITY"); %></th>
    <th>802.1P <% multilang("664" "LANG_MARK"); %></th>
    <th>LAN <% multilang("199" "LANG_PORT"); %></th>
    <th><% multilang("93" "LANG_PROTOCOL"); %></th>
    <th>DSCP</th>
    <th><% multilang("370" "LANG_SOURCE"); %> IP/<% multilang("88" "LANG_SUBNET_MASK"); %></th>
    <th><% multilang("373" "LANG_SOURCE_PORT"); %></th>
    <th><% multilang("371" "LANG_DESTINATION"); %> IP/<% multilang("88" "LANG_SUBNET_MASK"); %></th>
    <th><% multilang("374" "LANG_DESTINATION_PORT"); %></th>
    <th><% multilang("370" "LANG_SOURCE"); %> MAC</th>
    <th><% multilang("371" "LANG_DESTINATION"); %> MAC</th>
    <th>802.1P</th>
    <th><% multilang("289" "LANG_DELETE"); %></th>
    <th><% multilang("669" "LANG_EDIT"); %></th>
    <th><% multilang("123" "LANG_IP_VERSION"); %></th>
    <th><% multilang("3045" "LANG_CONNECT_TYPE"); %></th>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="location.href='net_qos_cls_edit.asp';" value="<% multilang("207" "LANG_ADD"); %>">&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="button" class="link_bg" onClick="on_submit();" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>">
  <input type="hidden" id="lst" name="lst" value="">
  <input type="hidden" name="submit-url" value="/net_qos_cls.asp">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
