<%SendWebHeadStr(); %>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT>
var popUpWin=0;
var cgi = new Object();
<%init_dhcpmain_page();%>
var old_lan_ip = null;
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
 typeClick();
 old_lan_ip = document.forms[0].uIp.value;
}
/********************************************************************
**          on document update
********************************************************************/
<!-- Added by dyh for bug#0003874 -->
function dns4ModeChange()
{
 with ( document.dhcpd )
 {
  var dns_mode =ipv4landnsmode.value;
  Ipv4Dns1.disabled = true;
  Ipv4Dns2.disabled = true;
  switch(dns_mode){
   case '0': //HGWProxy
     break;
   case '1': //Static
     Ipv4Dns1.disabled = false;
     Ipv4Dns2.disabled = false;
     break;
   case '2': //FromISP
     break;
  }
 }
}
function typeClick(obj)
{
 with ( document.forms[0])
 {
  if(uDhcpType[0].checked == true)
  {
   dhcpRangeStart.disabled = true;
   dhcpRangeEnd.disabled = true;
   //ipMask.disabled = true;//LGD_FOR_TR098
   ulTime.disabled = true;
   uServerIp.disabled = true;
   Ipv4Dns1.disabled = true;
   Ipv4Dns2.disabled = true;
   ipv4landnsmode.disabled = true;
  }
  else if(uDhcpType[1].checked == true)
  {
   dhcpRangeStart.disabled = false;
   dhcpRangeEnd.disabled = false;
   //ipMask.disabled = false;//LGD_FOR_TR098
   ulTime.disabled = false;
   uServerIp.disabled = true;
   ipv4landnsmode.disabled = false;
   dns4ModeChange();
  }
  else
  {
   dhcpRangeStart.disabled = true;
   dhcpRangeEnd.disabled = true;
   //ipMask.disabled = true;//LGD_FOR_TR098
   ulTime.disabled = true;
   uServerIp.disabled = false;
   Ipv4Dns1.disabled = true;
   Ipv4Dns2.disabled = true;
   ipv4landnsmode.disabled = true;
  }
 }
}
function popUpWindow(URLStr, left, top, width, height)
{
 if(popUpWin)
 {
  if(!popUpWin.closed) popUpWin.close();
 }
 popUpWin = open(URLStr, "popUpWin", "toolbar=yes,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width="+width+",height="+height+",left="+left+", top="+top+",screenX="+left+",screenY="+top+"");
}
function dhcpDevice()
{
 var loc = "net_dhcpdevice.asp";
 var code = "location=\"" + loc + "\"";
 eval(code);
}
function isSameSubNet(lan1Ip, lan1Mask, lan2Ip, lan2Mask)
{
 var count = 0;
 lan1a = lan1Ip.split(".");
 lan1m = lan1Mask.split(".");
 lan2a = lan2Ip.split(".");
 lan2m = lan2Mask.split(".");
 for (i = 0; i < 4; i++)
 {
  l1a_n = parseInt(lan1a[i]);
  l1m_n = parseInt(lan1m[i]);
  l2a_n = parseInt(lan2a[i]);
  l2m_n = parseInt(lan2m[i]);
  if ((l1a_n & l1m_n) == (l2a_n & l2m_n))
   count++;
 }
 if (count == 4)
  return true;
 else
  return false;
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit(reboot)
{
 if(reboot)
 {
  var loc = "mgm_dev_reboot.asp";
  var code = "location.assign(\"" + loc + "\")";
  eval(code);
 }
 else
 {
  with ( document.forms[0] )
  {
   if ( sji_checkvip(uIp.value) == false )
   {
    uIp.focus();
    alert(uIp.value + "<% multilang("3053" "LANG_IS_INVALID"); %>" + "IP" + "<% multilang("2997" "LANG_ADDRESS"); %>");
    return;
   }
   if ( sji_checkmask(uMask.value) == false )
   {
    uMask.focus();
    alert(uMask.value + "<% multilang("3053" "LANG_IS_INVALID"); %>" + "<% multilang("88" "LANG_SUBNET_MASK"); %>");
    return;
   }
   if ( uDhcpType[1].checked == true )
   {
    /*
				//LGD_FOR_TR098
				if ( sji_checkmask(ipMask.value) == false )
				{
					ipMask.focus();
					alert("DHCP" + "<% multilang(LANG_SUBNET_MASK); %>" + " \"ipMask.value + "\" " + "<% multilang(LANG_IS_INVALID); %>" + "<% multilang(LANG_SUBNET_MASK); %>");
					return;
				}
				*/
    if (sji_checkvip(dhcpRangeStart.value) == false || !(isSameSubNet(uIp.value, uMask.value, dhcpRangeStart.value, uMask.value)))
    {
     dhcpRangeStart.focus();
     alert(dhcpRangeStart.value + "<% multilang("3053" "LANG_IS_INVALID"); %>" + "<% multilang("487" "LANG_START"); %>" + "<% multilang("2997" "LANG_ADDRESS"); %>");
     return;
    }
    if ( sji_checkvip(dhcpRangeEnd.value) == false || !(isSameSubNet(uIp.value, uMask.value, dhcpRangeEnd.value, uMask.value)))
    {
     dhcpRangeEnd.focus();
     alert(dhcpRangeEnd.value + "<% multilang("3053" "LANG_IS_INVALID"); %>" + "<% multilang("487" "LANG_START"); %>" + "<% multilang("2997" "LANG_ADDRESS"); %>");
     return;
    }
    if (sji_ipcmp(dhcpRangeStart.value, dhcpRangeEnd.value) > 0)
    {
     alert("<% multilang("3054" "LANG_END_ADDRESS_MUST_BIG_THANSTART_ADDRESS"); %>");
     return;
    }
   }
   else if ( uDhcpType[2].checked == true )
   {
    if ( sji_checkvip(uServerIp.value) == false )
    {
     uServerIp.focus();
     alert("DHCP" + "<% multilang("89" "LANG_SERVER"); %>"+ "IP" + "<% multilnag("2997" "LANG_ADDRESS"); %>" + uServerIp.value + "<% multilang("3053" "LANG_IS_INVALID"); %>");
     return;
    }
   }
   <!-- Added by dyh for bug#0003874 -->
   if(ipv4landnsmode.value == 1)
   {
    if ( sji_checkvip(Ipv4Dns1.value) == false )
    {
     Ipv4Dns1.focus();
     alert(Ipv4Dns1.value + "<% multilang("3053" "LANG_IS_INVALID"); %>" + "DNS" + "<% multilang("2997" "LANG_ADDRESS"); %>");
     return;
    }
    if ( sji_checkvip(Ipv4Dns2.value) == false )
    {
     Ipv4Dns2.focus();
     alert(Ipv4Dns2.value + "<% multilang("3053" "LANG_IS_INVALID"); %>" + "DNS" + "<% multilang("2997" "LANG_ADDRESS"); %>");
     return;
    }
   }
   submit();
  }
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form action=/boaform/formDhcpServer method=POST name="dhcpd">
 <div class="intro_main ">
  <p class="intro_title">LAN <% multilang("356" "LANG_SETTINGS"); %></p><br>
  <p class="intro_content"><% multilang("3052" "LANG_NET_DHCP_NOTE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%>IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>
    <td><input type="text" name="uIp" value=<% getInfo("dhcplan-ip"); %>></td>
   </tr>
   <tr>
    <th width=40%><% multilang("88" "LANG_SUBNET_MASK"); %>:</th>
    <td><input type="text" name="uMask" value=<% getInfo("dhcplan-subnet"); %>></td>
   </tr>
  </table>
  <table id="dhcpInfo" >
   <tr>
    <th width=40%><% multilang("233" "LANG_DISABLE"); %> DHCP <% multilang("89" "LANG_SERVER"); %></th>
    <td><input type="radio" name="uDhcpType" value = "0" onClick="typeClick(this);"></td>
   </tr>
   <tr>
    <th width=40%><% multilang("234" "LANG_ENABLE"); %> DHCP <% multilang("89" "LANG_SERVER"); %></th>
    <td><input type="radio" name="uDhcpType" value = "1" onClick="typeClick(this);"></td>
   </tr>
   <tr>
    <th width=40%><% multilang("487" "LANG_START"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>
    <td><input type="text" name="dhcpRangeStart" value=<% getInfo("lan-dhcpRangeStart") %>></td>
   </tr>
   <tr>
    <th width=40%><% multilang("591" "LANG_END"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</th>
    <td><input type="text" name="dhcpRangeEnd" value=<% getInfo("lan-dhcpRangeEnd") %>></td>
   </tr>
   <tr>
    <th width=40%><% multilang("467" "LANG_LEASE_TIME"); %>:</th>
    <td><select size="1" name="ulTime">
      <option value="60"><% multilang("3048" "LANG_ONE_MINUTE"); %></option>
      <option value="3600"><% multilang("3049" "LANG_ONE_HOUR"); %></option>
      <option value="86400" ><% multilang("3050" "LANG_ONE_DAY"); %></option>
      <option value="604800"><% multilang("3051" "LANG_ONE_WEEK"); %></option>
     </select>
    </td>
   </tr>
  </table>
  <!-- Added by dyh for bug#0003874 -->
  <table>
   <tr>
    <th width=40%>LAN DNS <% multilang("129" "LANG_MODE"); %></th>
     <td><select name="ipv4landnsmode" onChange="dns4ModeChange()">
        <option value="0">HGWProxy</option>
        <option value="1">Static</option>
        <option value="2">FromISP</option>
      </select>
     </td>
   </tr>
  </table>
  <table id="v4dns_Staic">
   <tr>
    <th width=40%><% multilang("301" "LANG_PRIMARY"); %> IP DNS:</th>
    <td><input type="text" name="Ipv4Dns1" value=<% getInfo("dhcps-dns1"); %> ></td>
   </tr>
   <tr>
    <th width=40%><% multilang("302" "LANG_SECONDARY"); %> IP DNS:</th>
    <td><input type="text" name="Ipv4Dns2" value=<% getInfo("dhcps-dns2"); %> ></td>
   </tr>
  </table>
  <!-- End of bug#0003874 -->
  <table id="relayInfo" >
   <tr>
    <th width=40%><% multilang("234" "LANG_ENABLE"); %> DHCP <% multilang("89" "LANG_SERVER"); %> <% multilang("332" "LANG_RELAY"); %></th>
    <td><input type="radio" name="uDhcpType" value = "2" onClick="typeClick(this)"></td>
   </tr>
   <tr>
    <th width=40%>DHCP <% multilang("89" "LANG_SERVER"); %>IP <% multilnag("2997" "LANG_ADDRESS"); %>:</th>
    <td><input type="text" name="uServerIp" value=<% getInfo("wan-dhcps"); %>></td>
   </tr>
  </table>
 </div>
 <div class="btn_ctl">
  <INPUT type="button" class="link_bg" onClick="popUpWindow('net_mopreipaddr.asp',350,350,500,300);" value="<% multilang("669" "LANG_EDIT"); %> <% multilang("3047" "LANG_RESERVE"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>">
 </div>
 <br><br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" onClick="on_submit(0);" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>">&nbsp; &nbsp; &nbsp; &nbsp;
  <input type="hidden" name="submit-url" value="">
 </div>
 <br>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
<script>
 <% initPage("dhcp-mode"); %>
 var lease_time = <% getInfo("lan-dhcpLTime"); %>;
 if(lease_time == 60)
  document.dhcpd.ulTime.selectedIndex = 0;
 else if(lease_time == 3600)
  document.dhcpd.ulTime.selectedIndex = 1;
 else if(lease_time == 86400)
  document.dhcpd.ulTime.selectedIndex = 2;
 else if(lease_time == 604800)
  document.dhcpd.ulTime.selectedIndex = 3;
 else
  document.dhcpd.ulTime.selectedIndex = -1;
 document.dhcpd.ipv4landnsmode.value=<% getInfo("dhcps-mode"); %>;
 dns4ModeChange();
</script>
</html>
