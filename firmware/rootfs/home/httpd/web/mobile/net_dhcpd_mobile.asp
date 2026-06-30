<%SendWebHeadStr("mobile_normal_1"); %>
<title></title>
<SCRIPT>
var popUpWin=0;
var cgi = new Object();
<% init_dhcpmain_page(); %>
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
function typeClick(obj)
{
 with ( document.forms[0])
 {
  if(uDhcpType[0].checked == true)
  {
   dhcpRangeStart.disabled = true;
   dhcpRangeStart.style.display="none";
   dhcpRangeEnd.disabled = true;
   dhcpRangeEnd.style.display="none";
   //ipMask.disabled = true;//LGD_FOR_TR098
   ulTime.disabled = true;
   ulTime.style.display="none";
   uServerIp.disabled = true;
   uServerIp.style.display="none";
   document.getElementById('relayInfo').style.display = "none";
   document.getElementById('dhcpInfo').style.display = "none";
  }
  else if(uDhcpType[1].checked == true)
  {
   dhcpRangeStart.disabled = false;
   dhcpRangeStart.style.display = "";
   dhcpRangeEnd.disabled = false;
   dhcpRangeEnd.style.display = "";
   //ipMask.disabled = false;//LGD_FOR_TR098
   ulTime.disabled = false;
   ulTime.style.display = "";
   uServerIp.disabled = true;
   uServerIp.style.display = "none";
   document.getElementById('relayInfo').style.display = "none";
   document.getElementById('dhcpInfo').style.display = "";
  }
  else
  {
   dhcpRangeStart.disabled = true;
   dhcpRangeStart.style.display = "none";
   dhcpRangeEnd.disabled = true;
   dhcpRangeEnd.style.display = "none";
   //ipMask.disabled = true;//LGD_FOR_TR098
   ulTime.disabled = true;
   ulTime.style.display = "none";
   uServerIp.disabled = false;
   uServerIp.style.display = "";
   document.getElementById('relayInfo').style.display = "";
   document.getElementById('dhcpInfo').style.display = "none";
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
					alert("DHCP �������� \"" + ipMask.value + "\" ����Ч����������.");
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
   submit();
  }
 }
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--��ҳ����-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form action=/boaform/formDhcpServer method=POST name="dhcpd">
 <div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
         <div class="clear"></div>
 </div>
<div class="page">
 <div class="simplebox">
   <table class="tabletitle">
    <tr>
     <td><% multilang("356" "LANG_SETTINGS"); %></td>
    </tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width=40%><% multilang("2997" "LANG_ADDRESS"); %>:</td>
     <td><input type="text" name="uIp" value=<% getInfo("dhcplan-ip"); %>></td>
    </tr>
    <tr>
     <td width=40%><% multilang("88" "LANG_SUBNET_MASK"); %>:</td>
     <td><input type="text" name="uMask" value=<% getInfo("dhcplan-subnet"); %>></td>
    </tr>
    <tr>
     <td width=40%><% multilang("233" "LANG_DISABLE"); %> DHCP <% multilang("89" "LANG_SERVER"); %></td>
     <td><input type="radio" name="uDhcpType" value = "0" onClick="typeClick(this);"></td>
    </tr>
    <tr>
     <td width=40%><% multilang("234" "LANG_ENABLE"); %> DHCP <% multilang("89" "LANG_SERVER"); %></td>
     <td><input type="radio" name="uDhcpType" value = "1" onClick="typeClick(this);"></td>
    </tr>
    <tr>
     <td width=40><% multilang("234" "LANG_ENABLE"); %> DHCP <% multilang("89" "LANG_SERVER"); %> <% multilang("332" "LANG_RELAY"); %></td>
     <td><input type="radio" name="uDhcpType" value = "2" onClick="typeClick(this)"></td>
    </tr>
   </table>
   <table id="dhcpInfo" class="tabledata">
    <tr>
     <td width=40%><% multilang("487" "LANG_START"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</td>
     <td><input type="text" name="dhcpRangeStart" value=<% getInfo("lan-dhcpRangeStart") %>></td>
    </tr>
    <tr>
     <td width=40%><% multilang("591" "LANG_END"); %> IP <% multilang("2997" "LANG_ADDRESS"); %>:</td>
     <td><input type="text" name="dhcpRangeEnd" value=<% getInfo("lan-dhcpRangeEnd") %>></td>
    </tr>
    <tr>
     <td width=40%><% multilang("467" "LANG_LEASE_TIME"); %>:</td>
     <td><select size="1" name="ulTime">
       <option value="60"><% multilang("3048" "LANG_ONE_MINUTE"); %></option>
       <option value="3600"><% multilang("3049" "LANG_ONE_HOUR"); %></option>
       <option value="86400" ><% multilang("3050" "LANG_ONE_DAY"); %></option>
       <option value="604800"><% multilang("3051" "LANG_ONE_WEEK"); %></option>
      </select>
     </td>
    </tr>
   </table>
   <table id="relayInfo" class="tabledata">
    <tr>
     <td width=40%>DHCP <% multilang("89" "LANG_SERVER"); %>IP <% multilnag("2997" "LANG_ADDRESS"); %>:</td>
     <td><input type="text" name="uServerIp" value=<% getInfo("wan-dhcps"); %>></td>
    </tr>
   </table>
 <br><br>
  <input type="button" name="button" id="button" class="submit-button" onClick="on_submit(0);" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>">&nbsp; &nbsp; &nbsp; &nbsp;
  <input type="hidden" name="submit-url" value="">
 <br><br>
 <div class="topbutton"><a href="#"><span>Top</span></a></div>
 <div class="footer"><a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a></div>
 <div class="clear"></div>
 </div>
</div>
 </form>
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
</script>
</html>
