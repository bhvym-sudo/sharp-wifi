<% SendWebHeadStr();%>
<TITLE>Internet</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<style>
TABLE{width:320px;}
TR{height:16px;}
SELECT {width:150px;}
</style>
<!--System common script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="base64_code.js"></script>
<SCRIPT language="javascript" type="text/javascript">
var doubleclick = 0;
var lkmodes = new Array("Bridge", "Route");
//var svkinds = new Array("UBR Without PCR", "UBR With PCR", "CBR", "Non Realtime VBR", "Realtime VBR");
//var cpmodes = new Array("LLC", "VC");
//var apmodes = new Array("TR069_INTERNET", "INTERNET", "TR069", "Other", "VOICE", "TR069_VOICE", "VOICE_INTERNET", "TR069_VOICE_INTERNET");
var dlmodes = new Array("<% multilang("328" "LANG_CONTINUOUS"); %>", "<% multilang("329" "LANG_CONNECT_ON_DEMAND"); %>");
var md802ps = new Array(" ", "0", "1", "2", "3", "4", "5", "6", "7");
<% initPageEth2(); %>
<% initVlanRange(); %>
var opts = new Array(new Array("lkmode", lkmodes),
 new Array("applicationtype", apmodes),
 new Array("pppCtype", dlmodes), new Array("vprio", md802ps));
var curlink = null;
var g_dnsMode;
var g_dnsv6Mode;
var cgi = new Object();
var links = new Array();
var lan_interface_num = 14;
var userwanpppoelock = UserPppoeFlag;
var wlan_interface_change = <%checkWrite("wlan_interface_change") %>;
with(links){<% initPageEth(); %>}
function searchpvc(ipmode, pppcheck, vpi, vci)
{
 vpi = parseInt(vpi);
 vci = parseInt(vci);
 for(var i = 0; i < links.length; i++)
 {
  if(links[i] == curlink)continue;
  if(vpi == links[i]["vpi"] && vci == links[i]["vci"])
  {
   if(pppcheck == true && links[i]["cmode"] == 2)
    continue;
   if((ipmode ==0 && links[i]["cmode"] != 0) || (ipmode ==1 && links[i]["cmode"] == 0))
    continue;
   return true;
  }
 }
 return false;
}
function isAllStar(str)
{
 for (var i=0; i<str.length; i++) {
  if ( str.charAt(i) != '*' ) {
   return false;
  }
 }
 return true;
}
function on_linkchange(itlk)
{
 with ( document.forms[0] )
 {
  if(itlk == null)
  {
   //select
   lkmode.value = vprio.value = pppCtype.value = 0;
   if (4 == applicationtype.options.length)
   {
    applicationtype.value = 0;
   }
   else
   {
    applicationtype.value = 1;
   }
   //radio, default 
   ipmode[2].checked = true;
   //checkbox
   //PPPoEProxyEnable.checked = brmode.checked = napt.checked = vlan.checked = qos.checked = dgw.checked = false;
   PPPoEProxyEnable.checked = brmode.checked = napt.checked = vlan.checked = dgw.checked = false;
   //checkbox array
   chkpt[0].checked = chkpt[1].checked = chkpt[2].checked = chkpt[3].checked = chkpt[4].checked = chkpt[5].checked = chkpt[6].checked = chkpt[7].checked = chkpt[8].checked = chkpt[9].checked =false;/* Modified by jzh for mission#0007684 */
   //input number
   PPPoEProxyMaxUser.value = "0";
   //input ip
   ipAddr.value = remoteIpAddr.value = "0.0.0.0";
   netMask.value = "255.255.255.0";
   //input text
   pppUsername.value = pppPassword.value = pppServiceName.value = "";
   // Mason Yu:20110524 ipv6 setting.			
   if(<%checkWrite("IPv6Show");%>) {
    IpProtocolType.value = 3;
    Ipv6Addr.value = "";
    Ipv6PrefixLen.value = "";
    Ipv6Gateway.value = "";
    Ipv6Dns1.value = "";
    Ipv6Dns2.value = "";
    //DSLiteLocalIP.value = "";
    //DSLiteRemoteIP.value = "";
    //DSLiteGateway.value = "";
    document.getElementById('secIPv6Div').style.display="none";
    document.getElementById('DSLiteDiv').style.display="none";
    if (1 == lkmode.value) //Route and enable IPv6, default enable prefix delegation
     iapd.checked = true;
   }
   disableLanDhcp.checked = false; //bug#0001084
  }
  else
  {
   sji_onchanged(document, itlk);
   //select
   lkmode.value = itlk.cmode >= 1 ? 1 : 0;
   g_dnsMode = itlk.dnsMode;
   g_dnsv6Mode = itlk.dnsv6Mode;
   //checkbox array
   var ptmap = itlk.itfGroup;
   if(wlan_interface_change)
   {
    var tmp = ((itlk.itfGroup & 0x1f0) << 5) | ((itlk.itfGroup & 0x3e00) >>> 5);
    ptmap = tmp | (itlk.itfGroup & 0xf);
   }
   for(var i = 0; i < lan_interface_num; i ++) chkpt[i].checked = (ptmap & (0x1 << i));
   //radio
   //
//			1845 #define CHANNEL_MODE_BRIDGE     0
// 1846 #define CHANNEL_MODE_IPOE        1
//1847 #define CHANNEL_MODE_PPPOE      2
//1848 #define CHANNEL_MODE_PPPOA      3
//1849 #define CHANNEL_MODE_RT1483     4
//1850 #define CHANNEL_MODE_RT1577     5
//1851 #define CHANNEL_MODE_DSLITE     6
   if (curlink.cmode ==2 ) //PPPOE
    ipmode[2].checked = true;
   else if(curlink.IpProtocolType==2 && curlink.cmode == 1 && curlink.AddrMode ==1) //IPv6 only, Addr mode == SLAAC
    ipmode[0].checked = true;
   else if(curlink.IpProtocolType==2 && curlink.cmode == 1 && curlink.AddrMode ==16) //IPv6 only, Addr mode == DHCP
     ipmode[0].checked = true;
   else if(curlink.IpProtocolType==2 && curlink.cmode == 1) //IPv6 only, ipv6 mer
    ipmode[3].checked = true;
   else if(curlink.cmode != 0 && curlink.ipDhcp == 0)
   {
       if(curlink.cmode ==1 )
     ipmode[1].checked = true; //static
    /*
				// Mason Yu:20110524 ipv6 setting.				
				if (<%checkWrite("IPv6Show");%>) 
				{									
					if ( curlink.IpProtocolType != 2 )
						ipmode[curlink.cmode].checked = true;
					else {   // If protocol is IPv6 only.
						// If it is a MER(cmode=1) mode

						if (curlink.cmodeV6 == 4) {
							if (<%checkWrite("DSLiteShow");%>) 
								ipmode[4].checked = true;
						}
						else 
						if (curlink.cmode == 1)             //DHCP
							ipmode[0].checked = true;
						// If it is a PPPoE(cmode=2) mode
						else
							ipmode[2].checked = true;
					}
					
				}
				else 									
					ipmode[curlink.cmode].checked = true;				
					*/
   }
   else ipmode[0].checked = true;
   if (ipmode[2].checked == true && lkmode.value == 1)//pppoe
   {
    pppUsername.value = decode64(itlk.encodePppUserName);
   }
   if ((1 == lkmode.value) && (2 == applicationtype.options.length))
   {
    //mode changed from bridge to route
    // add BOTH and tr069 option
    applicationtype.options.length = 0;
    for(var i in apmodes)
    {
     applicationtype.options.add(new Option(apmodes[i], i));
    }
    applicationtype.value = itlk.applicationtype;
   }
   if(itlk.disableLanDhcp)
    disableLanDhcp.checked = true;
   else
    disableLanDhcp.checked = false;
  }
  protocolChange2();
  on_ctrlupdate(lkmode);
  //on_ctrlupdate(svtype);
  //on_ctrlupdate(vlan);
  on_ctrlupdate(applicationtype);
  if(itlk != null){
   if(itlk.napt==1)
    napt.checked = true;
   else
    napt.checked = false;
  }
        if(!document.getElementsByName('vlan')[0].checked)
        {
            document.getElementsByName('vid')[0].value = 0;
            document.getElementsByName('vid')[0].disabled = true;
            document.getElementsByName('vprio')[0].disabled = true;
        }
 }
}
function show_ipv4_only_or_ipv4v6_ipmode()
{
 document.getElementById('tbipmode_v4').style.display="block";
 document.getElementById('tbipmode_v4v6').style.display="block";
 document.getElementById('tbipmode_v4v6_2').style.display="block";
 document.getElementById('tbipmode_v6').style.display="none";
}
function show_ipv6_only_ipmode()
{
 document.getElementById('tbipmode_v4').style.display="none";
 document.getElementById('tbipmode_v4v6').style.display="block";
 document.getElementById('tbipmode_v4v6_2').style.display="block";
 document.getElementById('tbipmode_v6').style.display="block";
}
function addrModeChangeAccordingToipmode()
{
 options = document.getElementsByName
 document.adsl.AddrMode[0].disabled = false;
 document.adsl.AddrMode[1].disabled = false;
 document.adsl.AddrMode[2].disabled = false;
 if(document.adsl.ipmode[0].checked == true ) { //dhcp
  if(document.adsl.AddrMode.value == 2)
   document.adsl.AddrMode.value = 16;
  document.adsl.AddrMode[1].disabled = true;
    }
 else if(document.adsl.ipmode[1].checked == true ) {//static 
   document.adsl.AddrMode[0].disabled = true;
   document.adsl.AddrMode[2].disabled = true;
    }
 else if(document.adsl.ipmode[2].checked == true ) { //pppoe 
    if(document.adsl.AddrMode.value == 2)
   document.adsl.AddrMode.value = 16;
    document.adsl.AddrMode[1].disabled = true;
    }
 else if(document.adsl.ipmode[3].checked == true ) { //ipv6 mer 
   document.adsl.AddrMode[0].disabled = true;
   document.adsl.AddrMode[2].disabled = true;
    }
}
//if province_8021pcustom_enable = 1, set default vprio value by prio 
function set_default_vprio_value()
{
 with ( document.forms[0] )
 {
  var lk = lkname.value;
  if(vlan.checked == true && province_8021pcustom_enable == 1){
  //alert(applicationtype.options[applicationtype.selectedIndex].text);
   if(applicationtype.options[applicationtype.selectedIndex].text.search("TR069")!=-1)
   {
    //tr069 wan
    vprio.value=prio[0];
   }else if(applicationtype.options[applicationtype.selectedIndex].text.search("VOICE")!=-1){
    //Voice wan
    vprio.value=prio[3];
   }else if(applicationtype.options[applicationtype.selectedIndex].text.search("Other")!=-1){
    //Other wan
    vprio.value=prio[2];
   }else{
    //Internet wan
    vprio.value=prio[1];
   }
  }
 }
}
//If connection type is TR069 return false, else return true
function is_configurable()
{
 var lk = document.forms[0].lkname.value;
 if(cwmp_configurable == 0 && lk != "new" && links[lk].name.search("TR069") != -1)
  return false;
 return true;
}
function check_vlan_reserved(vlanID)
{
 var num = reservedVlanA.length;
 //var vlanID = document.forms[0].vid.value;
 for(var i = 0; i<num; i++){
  if(vlanID == reservedVlanA[i])
   return true;
 }
 return false;
}
function on_ctrlupdate(obj)
{
 with ( document.forms[0] )
 {
  if(obj.name == "lkname")
  {
   var configurable = is_configurable();
   if(configurable)
   {
    for(var i=0; i<document.forms[0].length;i++)
     document.forms[0].elements[i].disabled = false;
   }
   // Mason Yu:20110524 ipv6 setting.				
   if ( !(<%checkWrite("IPv6Show");%>) || (lkmode.value == 0))
   {
    document.getElementById('tbprotocol').style.display="block"; //slim on 2019-03 
    ipv6SettingsDisable();
   }
   else
   {
    document.getElementById('tbprotocol').style.display="block";
    ipv6SettingsEnable();
   }
   if(obj.value == "new")
   {
    curlink = null;
    on_linkchange(curlink);
    //pcr.value = 6000;
   }
   else
   {
    curlink = links[obj.value];
    on_linkchange(curlink);
    // Mason Yu:20110524 ipv6 setting.				
   }
   if(!configurable)
   {
    for(var i=0; i<document.forms[0].length;i++)
    {
     if(document.forms[0].elements[i].name != "lkname")
      document.forms[0].elements[i].disabled = true;
    }
   }
  }
  else if(obj.name == "lkmode")
  {
   tbipmode_v4.style.display = obj.value == 0 ? "none" : "block";
   tbipmode_v4v6.style.display = obj.value == 0 ? "none" : "block";
   tbipmode_v4v6_2.style.display = obj.value == 0 ? "none" : "block";
   tbipmode_v6.style.display = obj.value == 0 ? "none" : "block";
    if(!document.getElementsByName('vlan')[0].checked)
           {
               document.getElementsByName('vid')[0].value = 0;
              document.getElementsByName('vid')[0].disabled = true;
              document.getElementsByName('vprio')[0].disabled = true;
          }
   if(document.getElementById('IpProtocolType').value == 2)
    tbnat.style.display = "none";
   else
    tbnat.style.display = obj.value == 0 ? "none" : "block";
   //tbmtu.style.display = obj.value == 0 ? "none" : "block";			
   tbnat.style.display = obj.value == 0 ? "none" : "block";
   tbdgw.style.display = obj.value == 0 ? "none" : "block";
   if(obj.value == 1 && applicationtype.value != 2)
   {
    //napt.checked = true;  /* Modified by jzh for Nat webpage echo problem*/
   }
   else{
    napt.checked = false;
    tbnat.style.display = "none";
    tbdgw.style.display = "none";
   }
   // Mason Yu:20110524 ipv6 setting.			
   if (<%checkWrite("IPv6Show");%>)
   {
    // If cmode is Router
    if(obj.value == 1)
    {
     document.getElementById('tbprotocol').style.display="block";
     if(document.getElementById('IpProtocolType').value == 2 || document.getElementById('IpProtocolType').value == 3)
     ipv6SettingsEnable();
     if(document.getElementById('IpProtocolType').value == 1)
      ipv6SettingsDisable();
     if((curlink==null) &&(document.getElementById('IpProtocolType').value != 1)) //new link, Router mode, and protocol is not IPv4,default enable iapd
      iapd.checked = true;
    }
    // If cmode is Bridge
    else
    {
     document.getElementById('tbprotocol').style.display="block";
     ipv6SettingsDisable();
    }
   }
   on_ctrlupdate(ipmode[0]);
   var orgapptype;
   if(apmodes[4] == "SPECIAL_SERVICE_1" || apmodes[8] == "SPECIAL_SERVICE_1")
   {
    if (0 == obj.value)
    {
     if (6 != applicationtype.options.length)
     {
      orgapptype = applicationtype.value;
      // INTERNET and Other option
      applicationtype.options.length = 0;
      applicationtype.options.add(new Option(apmodes[1], 1));
      applicationtype.options.add(new Option(apmodes[3], 3));
      if(apmodes[4] == "VOICE")
      {
       applicationtype.options.add(new Option(apmodes[8], 8));
       applicationtype.options.add(new Option(apmodes[9], 9));
       applicationtype.options.add(new Option(apmodes[10], 10));
       applicationtype.options.add(new Option(apmodes[11], 11));
       if ((1 != orgapptype) && (3 != orgapptype)
        && (8 != orgapptype) && (9 != orgapptype)
        && (10 != orgapptype) && (11 != orgapptype))
       {
        applicationtype.value = 1;
       }
       else
        applicationtype.value = orgapptype;
      }
      else
      {
       applicationtype.options.add(new Option(apmodes[4], 4));
       applicationtype.options.add(new Option(apmodes[5], 5));
       applicationtype.options.add(new Option(apmodes[6], 6));
       applicationtype.options.add(new Option(apmodes[7], 7));
       if ((1 != orgapptype) && (3 != orgapptype)
        && (4 != orgapptype) && (5 != orgapptype)
        && (6 != orgapptype) && (7 != orgapptype))
       {
        applicationtype.value = 1;
       }
       else
        applicationtype.value = orgapptype;
      }
     }
    }
    else
    {
     if (6 == applicationtype.options.length)
     {
      orgapptype = applicationtype.value;
      // add BOTH and tr069 option
      applicationtype.options.length = 0;
      for(var i in apmodes)
      {
       applicationtype.options.add(new Option(apmodes[i], i));
      }
      applicationtype.value = orgapptype;
     }
    }
   }
   else
   {
    if (0 == obj.value)
    {
     if (2 != applicationtype.options.length)
     {
      orgapptype = applicationtype.value;
      // INTERNET and Other option
      applicationtype.options.length = 0;
      applicationtype.options.add(new Option(apmodes[1], 1));
      applicationtype.options.add(new Option(apmodes[3], 3));
      if ((1 != orgapptype) && (3 != orgapptype))
      {
       applicationtype.value = 1;
      }
      else
       applicationtype.value = orgapptype;
     }
    }
    else
    {
     if (2 == applicationtype.options.length)
     {
      orgapptype = applicationtype.value;
      // add BOTH and tr069 option
      applicationtype.options.length = 0;
      for(var i in apmodes)
      {
       applicationtype.options.add(new Option(apmodes[i], i));
      }
      applicationtype.value = orgapptype;
     }
    }
   }
   //on_ctrlupdate(applicationtype);
  }
  else if(obj.name == "ipmode")
  {
   var lk = document.forms[0].lkname.value;
   tbip.style.display = "none";
   tbdial.style.display = "none";
   tbdnsset.style.display = "none";
   tbdnsv6set.style.display = "none";
   if (cgi.poe_proxy) {
    tbpppprxy.style.display = "none";
    tbpppbr.style.display = "none";
    tbpppnum.style.display = "none";
   }
   //if(<%checkWrite("IPv6Show");%>)
   //	DSLiteDiv.style.display = "none";
   if(lkmode.value == 1)
   {
    //alert("g_dnsMode="+g_dnsMode);				
    if ( g_dnsMode == 0)
     // disable
     document.adsl.dnsMode[1].checked = true;
    else
     // enable
     document.adsl.dnsMode[0].checked = true;
    if ( g_dnsv6Mode == 0)
    {
     // disable
     document.adsl.dnsv6Mode[1].checked = true;
    }
    else
    {
     // enable
     document.adsl.dnsv6Mode[0].checked = true;
    }
    if (ipmode[0].checked == true) //DHCP, IPv4 only, or IPv4/IPv6
    {
     show_ipv4_only_or_ipv4v6_ipmode();
     tbdnsset.style.display = "block";
     document.adsl.dnsMode[0].disabled = false;
     document.adsl.dnsMode[1].disabled = false;
     if(document.getElementById('lkname').value == 'new' || links[lk]["cmode"] != 1 || links[lk]["ipDhcp"] != 1)
      mtu.value = 1500;
     else
      mtu.value = links[lk]["mtu"];
     //mtu.value = 1500;
     dnsModeClicked();
    }
    else if (ipmode[1].checked == true) //static, IPv4 only, or IPv4/IPv6
    {
     show_ipv4_only_or_ipv4v6_ipmode();
     tbip.style.display = "block";
     tbdnsset.style.display = "block";
     document.adsl.dnsMode[1].checked = true;
     document.adsl.dnsMode[0].disabled = true;
     document.adsl.dnsMode[1].disabled = true;
     //mtu.value = 1500;
     if(document.getElementById('lkname').value == 'new' || links[lk]["cmode"] != 1 || links[lk]["ipDhcp"] != 0)
      mtu.value = 1500;
     else
      mtu.value = links[lk]["mtu"];
     dnsModeClicked();
    }
    else if (ipmode[2].checked == true) //PPPoE, IPv4 only, or IPv4/IPv6, or IPv6 only
    {
     show_ipv4_only_or_ipv4v6_ipmode();
     tbdial.style.display = "block";
     if (cgi.poe_proxy) {
      if (applicationtype.value != 2)
      {
       tbpppprxy.style.display = "block";
       tbpppbr.style.display = "block";
       on_ctrlupdate(PPPoEProxyEnable);
      }else
       tbpppbr.style.display = "block";
     }
     if(document.getElementById('lkname').value == 'new' || links[lk]["cmode"] != 2)
      mtu.value = 1492;
     else
      mtu.value = links[lk]["mtu"];
     if(mtu.value > 1492)
      mtu.value = 1492;
     if(<%checkWrite("IPv6Show");%> && (document.getElementById('IpProtocolType').value != 1))
      ipv6SettingsEnable();
     if(<%checkWrite("IPv6Show");%> && (document.getElementById('IpProtocolType').value == 2))
      show_ipv6_only_ipmode();
    }
    else if(<%checkWrite("IPv6Show");%> && (document.getElementById('IpProtocolType').value == 2)) {
     if (ipmode[3].checked == true){ //IPv6 MER
      show_ipv6_only_ipmode();
      ipv6SettingsEnable();
      mtu.value = 1500;
     }
    }
     if(<%checkWrite("IPv6Show");%> && (document.getElementById('IpProtocolType').value != 1)) {
      ipv6SettingsEnable();
     }
     if(<%checkWrite("IPv6Show");%> && (document.getElementById('IpProtocolType').value == 2))
      show_ipv6_only_ipmode();
   }
  }
  else if(obj.name == "PPPoEProxyEnable")
  {
   tbpppnum.style.display = obj.checked == false ? "none" : "block";
  }
  else if(obj.name == "svtype")
  {
   tbpeakcell.style.display = obj.value >= 1 ? "block" : "none";
   tbothercell.style.display = obj.value >= 3 ? "block" : "none";
  }
  else if(obj.name == "vlan")
  {
   vid.disabled = !obj.checked;
   set_default_vprio_value();
   vprio.disabled = !obj.checked;
  }
  else if(obj.name == "mtu")
  {
   mtu.disabled = !obj.checked;
  }
  else if(obj.name == "applicationtype")
  {
   set_default_vprio_value();
   if(obj.value == 2 || obj.value == 4 || obj.value == 5){
    napt.checked = false;
    tbnat.style.display = "none";
    tbbind.style.display = "none";
    tbindip.style.display = "none";
    dgw.checked = false;
    tbdgw.style.display = "none";
    if (cgi.poe_proxy) {
     PPPoEProxyEnable.checked = false;
     tbpppprxy.style.display = "none";
     //tbpppbr.style.display = "none";
     //brmode.checked = false;				
     on_ctrlupdate(PPPoEProxyEnable);
    }
   }else{
    if(lkmode.value == 1){
     if(document.getElementById('IpProtocolType').value == 2)
      tbnat.style.display = "none";
     else
      tbnat.style.display = "block";
     //napt.checked = true;    /* Modified by jzh for Nat webpage echo problem*/
     if (obj.value == 3)
     {
      dgw.checked = false;
      tbdgw.style.display = "none";
     }
     else
     {
      tbdgw.style.display = "block";
     }
     if (cgi.poe_proxy && ipmode[2].checked == true)
     {
      tbpppprxy.style.display = "block";
      tbpppbr.style.display = "block";
      on_ctrlupdate(PPPoEProxyEnable);
     }
    }
    else{
     napt.checked = false;
     tbdgw.style.display = "none";
    }
    tbbind.style.display = "block";
    tbindip.style.display = "block";
   }
   //if(3 == obj.value)
   //	disableLanDhcp.checked = true;
   if ((3 == obj.value) && (0 == lkmode.value))
   {
    attention.style.display = "block";
   }
   else
   {
    attention.style.display = "none";
   }
  }
/* Added by peichao for bug#0003759*/
  if(userwanpppoelock == 1)
  {
   if( document.getElementsByName("pppServiceName")[0].value == LockpppoeServiceName)
   {
    document.adsl.pppServiceName.disabled = true;
   }
   else
   {
    document.adsl.pppServiceName.disabled = false;
   }
  }
/* Endof */
  <% initdgwoption(); %>
 }
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 sji_docinit(document, cgi);
 for(var i in opts)
 {
  var slit = document.getElementById(opts[i][0]);
  if(typeof slit == "undefined")continue;
  for(var j in opts[i][1])
  {
   slit.options.add(new Option(opts[i][1][j], j));
  }
  slit.selectedIndex = 0;
 }
 with ( document.forms[0] )
 {
  if (!cgi.poe_proxy) {
   tbpppprxy.style.display = "none";
   tbpppbr.style.display = "none";
   tbpppnum.style.display = "none";
  }
  for(var k in links)
  {
   var lk = links[k];
   lkname.options.add(new Option(lk.name, k));
  }
  if(links.length > 0)lkname.value = 0;
  lpppnumleft.innerHTML = cgi.pppnumleft;
  on_ctrlupdate(lkname);
  if (cgi.vlan_map != null) {
   for (var i=0; i<lan_interface_num; i++) {
    if (cgi.vlan_map & (0x1 << i))
    chkpt[i].disabled = true;
   }
  }
  mtu.value = 1500;
  protocolChange2();
  on_ctrlupdate(lkname);
 }
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit(act)
{
 var tmplst = "";
 var rmDis=0;
 with ( document.forms[0] )
 {
  if (document.adsl.pppServiceName.disabled == true)
  {
   rmDis = 1;
   document.adsl.pppServiceName.disabled = false;
  }
  action.value = act;
  if(act == "rm")
  {
   if(lkname.value == "new")
   {
    lkname.focus();
    alert('<% multilang("2003" "LANG_NO_LINK_SELECTED"); %>');
    return;
   }
   if(rmDis)
   {
    document.adsl.pppServiceName.disabled = true;
    alert('<% multilang("3671" "LANG_DONT_DEL_ITF"); %>');
    return;
   }
   tmplst = curlink.name;
  }
  else if(act == "sv")
  {
   if(lkname.value != "new")tmplst = curlink.name;
   if(lkmode.value == 0 && (applicationtype.value != 1 && applicationtype.value != 3))
   {
    if((applicationtype.options.length == 12
     && applicationtype.value != 8
     && applicationtype.value != 9
     && applicationtype.value != 10
     && applicationtype.value != 11)
     ||
     (applicationtype.options.length == 8
     && applicationtype.value != 4
     && applicationtype.value != 5
     && applicationtype.value != 6
     && applicationtype.value != 7)
    )
    {
     lkmode.focus();
     alert("<% multilang("3077" "LANG_ERROR_BRIDGE_MODE_NOT_SUPPORT_TR069_AND_VOICE"); %>");
     return;
    }
   }
   if(lkmode.value != 0) {
    if (<%checkWrite("IPv6Show");%>) {
     if (<%checkWrite("DSLiteShow");%>) {
      if ( ipmode[0].checked == false &&
       ipmode[1].checked == false &&
       ipmode[2].checked == false &&
       ipmode[3].checked == false /* &&
							ipmode[4].checked == false   */ ) {
       alert("<%multilang("3078" "LANG_PLEASE_SET_ISP_SERVICE_MODE"); %> (DHCP, static, PPPoE, IPv6 MER");
       return;
      }
     }
     else {
      if ( ipmode[0].checked == false &&
       ipmode[1].checked == false &&
       ipmode[2].checked == false &&
       ipmode[3].checked == false ) {
       alert("<%multilang("3078" "LANG_PLEASE_SET_ISP_SERVICE_MODE"); %>(DHCP, static, PPPoE, IPv6 MER");
       return;
      }
     }
    }
    else {
     if ( ipmode[0].checked == false &&
       ipmode[1].checked == false &&
       ipmode[2].checked == false ) {
      alert("<%multilang("3078" "LANG_PLEASE_SET_ISP_SERVICE_MODE"); %>");
      return;
     }
    }
   }
   //input number
   if(cgi.poe_proxy==1 && lkmode.value != 0 && ipmode[2].checked == true && sji_checkdigitrange(PPPoEProxyMaxUser.value, 0, cgi.pppnumleft) == false)
   {
    PPPoEProxyMaxUser.focus();
    alert("<% multilang("2994" "LANG_PROXY_USERS"); %>\"" + PPPoEProxyMaxUser.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
    return;
   }
   if(vlan.checked == true && ((sji_checkdigitrange(vid.value, otherVlanStart, otherVlanEnd) == true) || (check_vlan_reserved(vid.value) == true)))
   {
    vid.focus();
    alert("VLAN ID \"" + alertVlanStr + "\" <% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>£¡");
    return;
   }
   if(sji_checkdigitrange(mtu.value, 576, 1500) == false)
   {
    mtu.focus();
    alert('<% multilang("2448" "LANG_INVALID_MTU_VALUE_YOU_SHOULD_SET_A_VALUE_BETWEEN_65_1500"); %>');
    return;
   }
   if(lkmode.value == 1 && ipmode[1].checked == true && sji_checkvip(ipAddr.value) == false)
   {
    ipAddr.focus();
    alert("IP <% multilang("2997" "LANG_ADDRESS"); %>\"" + ipAddr.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
    return;
   }
   if(lkmode.value == 1 && ipmode[1].checked == true && sji_checkmask(netMask.value) == false)
   {
    netMask.focus();
    alert("<% multilang("88" "LANG_SUBNET_MASK"); %>\"" + netMask.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
    return;
   }
   if(lkmode.value == 1 && ipmode[1].checked == true && sji_checkvip(remoteIpAddr.value) == false)
   {
    remoteIpAddr.focus();
    alert("<% multilang("83" "LANG_DEFAULT_GATEWAY"); %>\"" + remoteIpAddr.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
    return;
   }
   if (v4dns1.value != "")
   {
    if(lkmode.value == 1 && (ipmode[0].checked == true || ipmode[1].checked == true ) && dnsMode[1].checked == true && sji_checkvip(v4dns1.value) == false)
    {
     v4dns1.focus();
     alert("<% multilang("301" "LANG_PRIMARY"); %> DNS \"" + v4dns1.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
     return;
    }
   }
   if (v4dns2.value != "")
   {
   if(lkmode.value == 1 && (ipmode[0].checked == true || ipmode[1].checked == true ) && dnsMode[1].checked == true && sji_checkvip(v4dns2.value) == false)
    {
     v4dns2.focus();
     alert("<% multilang("302" "LANG_SECONDARY"); %> DNS \"" + v4dns2.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
     return;
    }
   }
//star:20090302 START ppp username and password can be empty
   //input text
   if (ipmode[2].checked == true && lkmode.value == 1)
   {
    if( (pppUsername.value == "" || pppPassword.value == "")){
      alert('<% multilang("1981" "LANG_PPP_USER_NAME_CANNOT_BE_EMPTY"); %>' + '<% multilang("1984" "LANG_PPP_PASSWORD_CANNOT_BE_EMPTY"); %>');
      return;
    }
    else
    {
     if(pppUsername.value!="" && sji_checkpppacc(pppUsername.value, 1, 64) == false)
     {
      pppUsername.focus();
      alert("<% multilang("1123" "LANG_USERNAME"); %>\"" + pppUsername.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
      return;
     }
     if (!isAllStar(pppPassword.value))
     {
      if(sji_checkpppacc(pppPassword.value, 1, 30) == false)
      {
       pppPassword.focus();
       alert("<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
       return;
      }
     }
     else if (lkname.value == "new")
     {
      pppPassword.focus();
      alert("<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
      return;
     }
    }
    encodePppUserName.value=encode64(pppUsername.value);
    encodePppPassword.value=encode64(pppPassword.value);
    pppUsername.value = pppPassword.value = "";
   }
   if(pppServiceName.value!=""){
    if(lkmode.value == 1 && ipmode[2].checked == true && sji_checkusername(pppServiceName.value, 1, 30) == false)
    {
     pppServiceName.focus();
     alert("<% multilang("278" "LANG_SERVICE_NAME"); %>\"" + pppServiceName.value + "\"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
     return;
    }
   }
  //	cmodeV6.value = 0;
   if(lkmode.value == 0)cmode.value = 0;
   else if(ipmode[2].checked)
   {
    cmode.value = 2;
   }
   else if ((ipmode[0].checked) || (ipmode[1].checked))
   {
    cmode.value = 1;
    ipDhcp.value = ipmode[0].checked ? 1 : 0;
   }
   else if(<%checkWrite("IPv6Show");%>) {
    //alert("lkmode.value="+lkmode.value);
    if(ipmode[3].checked)
     cmode.value = 1;
    else if (<%checkWrite("DSLiteShow");%>) {
    /*
					if(ipmode[4].checked) {
						cmode.value = 1;
			//			cmodeV6.value = 4;
					}
					*/
    }
   }
   //checkbox array
   var ptmap = 0;
   for(var i = 0; i < lan_interface_num; i ++) if(chkpt[i].checked == true) ptmap |= (0x1 << i);
   if(wlan_interface_change){
    var tmp = (((ptmap & 0x1f0) << 5) | ((ptmap & 0x3e00) >>> 5));
    ptmap = (tmp | (ptmap & 0xf));
   }
   itfGroup.value = ptmap;
   <!-- Mason Yu:20110524 ipv6 setting -->
   if (<%checkWrite("IPv6Show");%>) {
    if(document.getElementById('IpProtocolType').value == 3 || document.getElementById('IpProtocolType').value == 2)
    {
     if(document.adsl.lkmode.value != 0) {
/*
						if(document.adsl.staticIpv6.checked == false &&
						document.adsl.itfenable.checked == false &&
						document.adsl.slacc.checked == false &&
						document.adsl.DSLiteRemoteIP.value == "" ) {
							alert("WAN <% multilang(LANG_IPV6_ADDRESS_MODE); %> /<% multilang(LANG_DS_LITE_WAN_CONFIG); %>  <% multilang(LANG_INVALID); %>");
							return false;
						}						
*/
      if (document.adsl.Ipv6Dns1.value != "")
      {
       if(document.adsl.lkmode.value == 1 && (document.adsl.ipmode[0].checked == true || document.adsl.ipmode[1].checked == true ) && document.adsl.dnsMode[1].checked == true && isUnicastIpv6Address( document.adsl.Ipv6Dns1.value) == false)
       {
        document.adsl.Ipv6Dns1.focus();
        alert("<% multilang("1994" "LANG_INVALID_PRIMARY_IPV6_DNS_ADDRESS"); %>");
        return false;
       }
      }
      if (document.adsl.Ipv6Dns2.value != "")
      {
       if(document.adsl.lkmode.value == 1 && (document.adsl.ipmode[0].checked == true || document.adsl.ipmode[1].checked == true ) && document.adsl.dnsMode[1].checked == true && isUnicastIpv6Address( document.adsl.Ipv6Dns2.value) == false)
       {
        document.adsl.Ipv6Dns2.focus();
        alert("<% multilang("1995" "LANG_INVALID_SECONDARY_IPV6_DNS_ADDRESS"); %>");
        return false;
       }
      }
      if(document.getElementById('AddrMode').value==2 && (document.adsl.ipmode[0].checked || document.adsl.ipmode[1].checked || document.adsl.ipmode[2].checked || document.adsl.ipmode[3].checked)) {
        if(document.adsl.Ipv6Addr.value == "" ){
         alert("<% multilang("1988" "LANG_PLEASE_INPUT_IPV6_ADDRESS_OR_SELECT_DHCPV6_CLIENT_OR_CLICK_SLAAC"); %>"); //Please input ipv6 address or open DHCPv6 client!
         document.adsl.Ipv6Addr.focus();
         return false;
        }
       if(document.adsl.Ipv6Addr.value != ""){
        if (! isGlobalIpv6Address( document.adsl.Ipv6Addr.value) ){
         alert("<% multilang("1991" "LANG_INVALID_IPV6_ADDRESS"); %>"); //Invalid ipv6 address!
         document.adsl.Ipv6Addr.focus();
         return false;
        }
        var prefixlen= getDigit(document.adsl.Ipv6PrefixLen.value, 1);
        if (prefixlen > 128 || prefixlen <= 0) {
         alert("<% multilang("1992" "LANG_INVALID_IPV6_PREFIX_LENGTH"); %>"); //Invalid ipv6 prefix length!
         document.adsl.Ipv6PrefixLen.focus();
         return false;
        }
       }
       if(document.adsl.Ipv6Gateway.value != "" ){
        if (! isUnicastIpv6Address( document.adsl.Ipv6Gateway.value) ){
         alert("<% multilang("1993" "LANG_INVALID_IPV6_GATEWAY_ADDRESS"); %>"); //Invalid ipv6 gateway address!
         document.adsl.Ipv6Gateway.focus();
         return false;
        }
       }
      }
      // Check DS-Lite parameter
      if (<%checkWrite("DSLiteShow");%>) {
       if(dslite_enable.checked == true){
        var dslitemode =dslite_aftr_mode.value;
        if(dslitemode=="1") { //static	
         if(dslite_aftr_hostname.value == ""){ //Should not be empty
          alert(dslite_aftr_hostname.value+"<% multilang("3081" "LANG_SHOULD_NOT_BE_EMPTY"); %>");
          dslite_aftr_hostname.focus();
         return false;
        }
         var index_of_dot = dslite_aftr_hostname.value.indexOf('.');
         if(!isUnicastIpv6Address(dslite_aftr_hostname.value) &&
            (index_of_dot==-1) || (dslite_aftr_hostname.value.charAt(0)=='.') || ( (dslite_aftr_hostname.value.charAt(dslite_aftr_hostname.value.length-1)=='.'))) {
          //Not unicast IPv6 address and not is a hostname (has character '.')
          alert(dslite_aftr_hostname.value+"<% multilang("3053" "LANG_IS_INVALID"); %> <% multilang("3080" "LANG_TRY_AGAIN"); %>");
          dslite_aftr_hostname.focus();
          return false;
        }
         }
        }
      }
     }
    }
   }
  }
  form.lst.value = tmplst;
  if (doubleclick == 0) {
   doubleclick = 1;
   submit();
  }
 }
}
function add_dns()
{
   var loc = "net_dns.asp";
   var code = "window.location.href=\"" + loc + "\"";
   eval(code);
}
function add_dsl()
{
   var loc = "net_dsl.asp";
   var code = "window.location.href=\"" + loc + "\"";
   eval(code);
}
// Mason Yu:20110524 ipv6 setting. START
function ipv6SettingsEnable()
{
    addrModeChangeAccordingToipmode();
 if(document.getElementById('IpProtocolType').value != 1){ // not IPv4 only
 /*
	   	if (<%checkWrite("DSLiteShow");%> && document.adsl.ipmode[4].checked == true)
			document.getElementById('DSLiteDiv').style.display="block";	
		else { //not dslite
		*/
   document.getElementById('tbipv6wan').style.display="block";
  //}	
  if (document.adsl.ipmode[0].checked == true ){ //dhcp
   tbdnsv6set.style.display = "block";
   document.adsl.dnsv6Mode[0].disabled = false;
   document.adsl.dnsv6Mode[1].disabled = false;
   dnsv6ModeClicked();
  }
  else if ((document.adsl.ipmode[1].checked == true ) || (document.adsl.ipmode[3].checked == true )) { //static ,ipv4/ipv6 or ipv6 only
   tbdnsv6set.style.display = "block";
   document.adsl.dnsv6Mode[1].checked = true;
   document.adsl.dnsv6Mode[0].disabled = true;
   document.adsl.dnsv6Mode[1].disabled = true;
   dnsv6ModeClicked();
  }
  if(document.getElementById('IpProtocolType').value == 2){ //IPv6 only
   document.getElementById('tbip').style.display="none";
   document.getElementById('DSLiteDiv').style.display="block";
   dsliteSettingChange();
  }
   }
 wanAddrModeChange();
}
function wanAddrModeChange()
{
 document.getElementById('secIPv6Div').style.display="none";
 document.getElementById('dhcp6c_ctrlblock').style.display="none";
 document.getElementById('DSLiteDiv').style.display="none";
 if(document.getElementById('AddrMode').value==""){
  if(document.adsl.ipmode[0].checked == true ) //dhcp
   document.getElementById('AddrMode').value = 1;
  else if(document.adsl.ipmode[1].checked == true ) //static 
   document.getElementById('AddrMode').value = 2; //set to static
  else if(document.adsl.ipmode[2].checked == true ) //pppoe
   document.getElementById('AddrMode').value = 1; // set to slaac
  else if(document.adsl.ipmode[3].checked == true ) //ipv6 mer
   document.getElementById('AddrMode').value = 2; //set to slaac
 }
 if( document.getElementById('IpProtocolType').value == 3 && document.adsl.ipmode[1].checked == true ){ //ipv4/v6  and static
  document.getElementById('AddrMode').value = 2;
 }
 else if(document.adsl.ipmode[3].checked == true){ //ipv6 mer
  document.getElementById('AddrMode').value = 2;
 }
    //else if (document.getElementById('IpProtocolType').value!=1 && ( ) //ipmode not static , means dhcp or pppoe. then addrmode should not be static
 //	document.getElementById('AddrMode').value = 1; 
 switch(document.getElementById('AddrMode').value)
 {
  case '1': //SLAAC
   break;
  case '2': //Static
   document.getElementById('secIPv6Div').style.display="block";
   break;
  case '16': //DHCP
   //document.getElementById('dhcp6c_ctrlblock').style.display="block";
   document.adsl.iana.checked = true;
   break;
 }
 if(document.getElementById('IpProtocolType').value == 2){ //IPv6 only	
  document.getElementById('DSLiteDiv').style.display="block";
 }
}
function ipv6SettingsDisable()
{
 document.getElementById('tbipmode_v6').style.display="none";
 document.getElementById('tbipv6wan').style.display="none";
 document.getElementById('secIPv6Div').style.display="none";
 document.getElementById('dhcp6c_ctrlblock').style.display="none";
 document.getElementById('DSLiteDiv').style.display="none";
 document.getElementById('tbdnsv6set').style.display="none";
}
function showUIBridgeMode()
{
  document.getElementById('tbipmode_v4').style.display="none";
  document.getElementById('tbipmode_v4v6').style.display="none";
  document.getElementById('tbipmode_v4v6_2').style.display="none";
  document.getElementById('tbipmode_v6').style.display="none";
  document.getElementById('tbip').style.display = "none";
}
function protocolChange2()
{
 ipver = document.getElementById('IpProtocolType').value;
 // If protocol is IPv4 only.
 with ( document.forms[0] ) {
  if(document.getElementById('IpProtocolType').value == 1){ //IPv4 only		
   if(document.adsl.ipmode[3].checked == true)
    document.adsl.ipmode[1].checked = true;
   //document.adsl.ipmode[0].disabled = false;
   document.adsl.ipmode[1].disabled = false;
   //document.adsl.ipmode[2].disabled = false;
   document.adsl.ipmode[3].disabled = true;
   document.adsl.dslite_enable.checked = false;
   document.adsl.ipmode[3].checked = false;
   document.getElementById('tbipmode_v4').style.display="block";
   document.getElementById('tbipmode_v4v6').style.display="block";
   document.getElementById('tbipmode_v4v6_2').style.display="block";
   document.getElementById('tbipmode_v6').style.display="none";
   tbnat.style.display = "block";
   if(document.adsl.ipmode[1].checked == true) //show static UI
    document.getElementById('tbip').style.display = "block";
   if(document.adsl.ipmode[2].checked == true)
    mtu.value = 1492;
   else
    mtu.value = 1500;
   ipv6SettingsDisable();
  }else if(document.getElementById('IpProtocolType').value == 2){ //IPv6 only
   if(document.adsl.ipmode[1].checked == true)
    document.adsl.ipmode[3].checked = true;
   //document.adsl.ipmode[0].disabled = false;
   document.adsl.ipmode[1].disabled = true;
   //document.adsl.ipmode[2].disabled = false;
   document.adsl.ipmode[3].disabled = false;
   //document.adsl.ipmode[0].checked = false;
   document.adsl.ipmode[1].checked = false;
   document.getElementById('tbipmode_v4').style.display="none";
   document.getElementById('tbipmode_v4v6').style.display="block";
   document.getElementById('tbipmode_v4v6_2').style.display="block";
   document.getElementById('tbipmode_v6').style.display="block";
   tbnat.style.display = "none";
   if ( document.adsl.lkmode.value == 1 )
    ipv6SettingsEnable();
   }
  else { //IPv4/IPv6
   if(document.adsl.ipmode[3].checked == true)
    document.adsl.ipmode[1].checked = true;
   //document.adsl.ipmode[0].disabled = false;
   document.adsl.ipmode[1].disabled = false;
   //document.adsl.ipmode[2].disabled = false;
   document.adsl.ipmode[3].disabled = true;
   document.adsl.ipmode[3].checked = false;
   document.adsl.dslite_enable.checked = false;
   document.getElementById('tbipmode_v4').style.display="block";
   document.getElementById('tbipmode_v4v6').style.display="block";
   document.getElementById('tbipmode_v4v6_2').style.display="block";
   document.getElementById('tbipmode_v6').style.display="none";
   tbnat.style.display = "block";
   if ( document.adsl.lkmode.value == 1 )
    ipv6SettingsEnable();
   if(document.adsl.ipmode[1].checked == true) //show static UI
    document.getElementById('tbip').style.display = "block";
   if(document.adsl.ipmode[2].checked == true)
    mtu.value = 1492;
   else
    mtu.value = 1500;
  }
 }
 with ( document.forms[0] )
 {
  if(lkmode.value==0) { //bridge mode
   showUIBridgeMode();
  }
 }
}
// Mason Yu:20110524 ipv6 setting. END
function dnsModeClicked()
{
 if ( document.adsl.dnsMode[0].checked )
 {
  document.adsl.v4dns1.disabled = true;
  document.adsl.v4dns2.disabled = true;
 }
 if ( document.adsl.dnsMode[1].checked )
 {
  document.adsl.v4dns1.disabled = false;
  document.adsl.v4dns2.disabled = false;
 }
}
function dnsv6ModeClicked()
{
 if ( document.adsl.dnsv6Mode[0].checked )
 {
  document.adsl.Ipv6Dns1.disabled = true;
  document.adsl.Ipv6Dns2.disabled = true;
 }
 if ( document.adsl.dnsv6Mode[1].checked )
 {
  document.adsl.Ipv6Dns1.disabled = false;
  document.adsl.Ipv6Dns2.disabled = false;
 }
}
function dsliteSettingChange()
{
 with ( document.forms[0] )
 {
  if(dslite_enable.checked == true){
   if (ipmode[2].checked == true) { //PPPoE
    if(mtu.value > 1452) //DS-lite must add IPv6 header for 40 bytes
     mtu.value = 1452;
   }
   else {
    if(mtu.value > 1460)
     mtu.value = 1460;
   }
   dslite_mode_div.style.display = 'block';
   dsliteAftrModeChange();
  }
  else{
   if (ipmode[2].checked == true) {
    mtu.value = 1492;
   }
   else {
    mtu.value = 1500;
   }
   dslite_mode_div.style.display = 'none';
   dslite_aftr_hostname_div.style.display = 'none';
  }
 }
}
function dsliteAftrModeChange()
{
 with ( document.forms[0] )
 {
  var dslitemode =dslite_aftr_mode.value;
  dslite_aftr_hostname_div.style.display = 'none';
  switch(dslitemode){
   case '0': //AUTO
     break;
   case '1': //Static
     dslite_aftr_hostname_div.style.display = 'block';
     if(dslite_aftr_hostname.value == "::") //clear the value
      dslite_aftr_hostname.value ="";
     break;
  }
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formEthernet" method="post" name="adsl">
 <div class="intro_main ">
  <p class="intro_title">WAN <% multilang("224" "LANG_CONFIGURATION"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table id="tbupmode" cellpadding="0px" cellspacing="2px">
   <tr nowrap><th width="150px"><% multilang("2989" "LANG_CONNECTION_NAME"); %>:</th><td><select id="lkname" name="lkname" onChange="on_ctrlupdate(this)" size="1"><option value="new" selected><% multilang("2990" "LANG_ADD_NEW_WAN_LINK"); %></option></select></td></tr>
  </table>
  <table id="tblkmode" cellpadding="0px" cellspacing="2px">
   <tr nowrap><th width="150px"><% multilang("129" "LANG_MODE"); %>:</th><td><select id="lkmode" name="lkmode" onChange="on_ctrlupdate(this)" size="1"></select></td></tr>
  </table>
  <table id=tbprotocol cellpadding="0px" cellspacing="2px" style="display:none">
   <tr nowrap id=TrIpProtocolType>
    <th width="150px"><% multilang("123" "LANG_IP_VERSION"); %>:</th>
    <td width=80%><select id="IpProtocolType" onChange="protocolChange2()" name="IpProtocolType">
      <option value="3" > IPv4/IPv6</option>
      <option value="1" > IPv4</option>
      <option value="2" > IPv6</option>
     </select>
    </td>
   </tr>
  </table>
  <table id="tbipmode_v4v6_2" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px">DHCP</th><td width=80%><input type="radio" id="ipmode" name="ipmode" value="0" onClick="on_ctrlupdate(this)"><% multilang("2991" "LANG_GET_ADDRESS_FROM_ISP_DHCP"); %></td></tr>
  </table>
  <table id="tbipmode_v4"cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px">Static</th><td width=80%><input type="radio" id="ipmode" name="ipmode" value="1" onClick="on_ctrlupdate(this)"><% multilang("2992" "LANG_GET_ADDRESS_FROM_ISP_STATIC"); %></td></tr>
  </table>
  <table id="tbipmode_v4v6" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px">PPPoE </th><td width=80%><input type="radio" id="ipmode" name="ipmode" value="2" onClick="on_ctrlupdate(this)"><% multilang("2993" "LANG_GET_ADDRESS_VIA_PPPOE"); %></td></tr>
  </table>
  <table id="tbipmode_v6" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <% checkWrite("IPv6vcCheck9"); %>
  </table>
  <table id="tbpppprxy" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="3"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px"><% multilang("234" "LANG_ENABLE"); %> PPPOE <% multilang("887" "LANG_PROXY"); %></th><td width=80%><input type="checkbox" name="PPPoEProxyEnable" onClick="on_ctrlupdate(this);"></td></tr>
  </table>
  <table id="tbpppnum" cellpadding="0px" cellspacing="2px">
   <tr nowrap><th width="150px"><% multilang("2994" "LANG_PROXY_USERS"); %>(<% multilang("2995" "LANG_AVAILABLE"); %><b><label id="lpppnumleft">5</label></b>)</th><td width=80%><input type="text" name="PPPoEProxyMaxUser" maxlength="2" size="2" style="width:40px "></td></tr>
  </table>
  <table id="tbpppbr" cellpadding="0px" cellspacing="2px">
   <tr nowrap><th width="150px">PPPoE <% multilang("2996" "LANG_BRIDGE_ROUTE_MIXED"); %></th><td width=80%><input type="checkbox" name="brmode"></td></tr>
  </table>
  <table id="tbnat" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px"><% multilang("234" "LANG_ENABLE"); %> NAT:</th><td width=80%><input type="checkbox" name="napt"></td></tr>
  </table>
  <table id="tbvlan" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px"><% multilang("234" "LANG_ENABLE"); %> Vlan:</td><td width=80%><input type="checkbox" name="vlan" onClick="on_ctrlupdate(this)"></td></tr>
   <tr nowrap><th>Vlan ID:</th><td width=80%><input type="text" name="vid" maxlength="4" size="4" style="width:40px "></td></tr>
   <tr nowrap><th>802.1p:</th><td width=80%><select id="vprio" name="vprio" size="1"></select></td></tr>
  </table>
  <table id="tbmtu" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px">MTU:</th><td width=80%><input type="text" name="mtu" maxlength="4" size="4" style="width:40px "></td></tr>
  </table>
  <table id="tbdial" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px"><% multilang("1123" "LANG_USERNAME"); %>:</th><td width=80%><input type="text" name="pppUsername" maxlength="64" size="16" style="width:150px "></td></tr>
   <tr nowrap><th><% multilang("65" "LANG_PASSWORD"); %>:</th><td width=80%><input type="password"name="pppPassword" maxlength="32" size="16" style="width:150px "></td></tr>
   <tr nowrap><th><% multilang("278" "LANG_SERVICE_NAME"); %>:</th><td width=80%><input type="text" name="pppServiceName" maxlength="32" size="16" style="width:150px "></td></tr>
   <tr nowrap><th><% multilang("2998" "LANG_PPP_TYPE"); %></th><td width=80%><select id="pppCtype" name="pppCtype" size="1"></select></td></tr>
  </table>
  <table id="tbip" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px"><% multilang("87" "LANG_IP_ADDRESS"); %>:</th><td width=80%><input type="text" name="ipAddr" maxlength="15" size="15" style="width:150px "></td></tr>
   <tr nowrap><th><% multilang("88" "LANG_SUBNET_MASK"); %>:</th><td width=80%><input type="text" name="netMask" maxlength="15" size="15" style="width:150px "></td></tr>
   <tr nowrap><th><% multilang("83" "LANG_DEFAULT_GATEWAY"); %>:</th><td width=80%><input type="text" name="remoteIpAddr" maxlength="15" size="15" style="width:150px "></td></tr>
    <!--<tr nowrap><td><% multilang("3675" "LANG_DNS_FIRST"); %>:</td><td><input type="text" name="fstdns" maxlength="15" size="15" style="width:150px "></td></tr>
    <tr nowrap><td><% multilang("3676" "LANG_DNS_SECOND"); %>:</td><td><input type="text" name="secdns" maxlength="15" size="15" style="width:150px "></td></tr>-->
  </table>
  <table id="tbdnsset" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap>
    <th width="150px">Request DNS:</th>
    <td width=80%><input type="radio" value="1" name="dnsMode" checked onClick='dnsModeClicked()'>Enable</td>
   </tr>
   <tr nowrap>
    <td width="150px"></td>
    <td width=80%><input type="radio" value="0" name="dnsMode" onClick='dnsModeClicked()'>Disable</td>
   </tr>
   <tr nowrap>
    <th width="150px"><% multilang("301" "LANG_PRIMARY"); %> DNS:</th>
    <td width=80%><input type="text" name="v4dns1" size="18" maxlength="15" value= ></td>
   </tr>
   <tr nowrap>
    <th width="150px"><% multilang("302" "LANG_SECONDARY"); %> DNS:</th>
    <td width=80%><input type=text name="v4dns2" size="18" maxlength="15" value=></td>
   </tr>
  </table>
  <table id="tbdgw" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="3"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap><th width="150px"><% multilang("83" "LANG_DEFAULT_GATEWAY"); %>: </th><td width=80%><input type="checkbox" name="dgw"></td></tr>
  </table>
  <table id="tbqos" cellpadding="0px" cellspacing="2px">
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
    <!--<tr nowrap><td width="150px"><% multilang("307" "LANG_ENABLE_QOS"); %>:</td><td><input type="checkbox" name="qos"></td></tr>-->
    <!--<tr nowrap><td><% multilang("92" "LANG_ENCAPSULATION"); %>:</td><td><select id="encap" name="encap" size="1"></select></td></tr>-->
   <tr nowrap><th width="150px"><% multilang("359" "LANG_SERVICE");%> <% multilang("129" "LANG_MODE"); %>:</th><td width=80%><select id="applicationtype" onChange="on_ctrlupdate(this)" name="applicationtype" size="1"></select></td></tr>
   <tr nowrap><th width="150px"><% multilang("233" "LANG_DISABLE"); %> LAN DHCP:</th><td width=80%><input type="checkbox" name="disableLanDhcp"></td></tr>
  </table>
   <!--<table id="tbbind" cellpadding="0px" cellspacing="2px">
    <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
    <tr nowrap><td width="150px"><% multilang("2979" "LANG_BIND_PORT"); %>:</td><td>&nbsp;</td></tr>
    <tr nowrap><td><input type="checkbox" name="chkpt"><% multilang("199" "LANG_PORT");%>_1</td><td ><input type="checkbox" name="chkpt"><% multilang("199" "LANG_PORT");%>_2</td></tr>
    <tr nowrap><td><input type="checkbox" name="chkpt"><% multilang("199" "LANG_PORT");%>_3</td><td ><input type="checkbox" name="chkpt"><% multilang("199" "LANG_PORT");%>_4</td></tr>
    <tr nowrap><td><input type="checkbox" name="chkpt"><% multilang("1279" "LANG_WIRELESS");%>(ROOT/SSID1)</td></tr>
    <tr nowrap><td><input type="checkbox" name="chkpt"><% multilang("1279" "LANG_WIRELESS");%>(SSID2)</td><td ><input type="checkbox" name="chkpt"><% multilang("1279" "LANG_WIRELESS");%>(SSID3)</td></tr>
    <tr nowrap><td><input type="checkbox" name="chkpt"><% multilang("1279" "LANG_WIRELESS");%>(SSID4)</td><td ><input type="checkbox" name="chkpt"><% multilang("1279" "LANG_WIRELESS");%>(SSID5)</td></tr>
   </table>-->
  <% ShowPortMapping(); %>
   <!-- Mason Yu:20110524 ipv6 setting -->
  <table id=tbipv6wan style="display:block" border=0 width="600" cellspacing=4 cellpadding=0>
   <tr><th width="150px"><font size=1>WAN <% multilang("120" "LANG_IPV6_ADDRESS_MODE"); %>:</th><td width=80%></td></tr>
   <tr nowrap id=TrIpv6AddrType>
    <th width="150px"><font size=1><% multilang("3000" "LANG_GLOBAL_IP_MODE"); %>:</th>
    <td width=80%><select id="AddrMode" style="WIDTH: 150px" onChange="wanAddrModeChange()" name="AddrMode">
      <option value="1" ><% multilang("2999" "LANG_STAT_LESS"); %></option>
      <option value="2" ><% multilang("444" "LANG_MANUAL"); %></option>
      <option value="16" > DHCP</option>
     </select>
    </td>
   <tr>
    <th width="150px"><font size=1>DHCP<% multilang("234" "LANG_ENABLE"); %> <% multilang("104" "LANG_PREFIX"); %><% multilang("887" "LANG_PROXY"); %></th>
    <td width=80%>
     <input type="checkbox" value="ON" name="iapd" id="send2">
    </td>
   </tr>
   </tr>
  </table>
   <div id=DSLiteDiv style="display:none">
            <table border=0 width="600" cellspacing=4 cellpadding=0>
    <tr><th width="150px">DS-Lite <% multilang("234" "LANG_ENABLE"); %>:</th>
     <td width=80%> <input type="checkbox" value="ON" name="dslite_enable" id="dslite_enable" onChange="dsliteSettingChange()"> </td>
    </tr>
            </table>
    <div id="dslite_mode_div" style="display:none;">
    <table border="0" cellpadding="0" cellspacing="0">
     <tr>
     <th width="150">AFTR <% multilang("284" "LANG_ADDRESS_MODE"); %></th>
     <td width=80%><select name="dslite_aftr_mode" onChange="dsliteAftrModeChange()">
       <option value="0">DHCPv6</option>
       <option value="1"><% multilang("444" "LANG_MANUAL"); %></option>
      </select></td>
    </tr>
            </table>
            </div>
    <div id='dslite_aftr_hostname_div' style="display:none;">
    <table border="0" cellpadding="0" cellspacing="0">
    <tr>
     <th width="150px">AFTR <% multilang("2997" "LANG_ADDRESS"); %>/<% multilang("400" "LANG_DOMAIN"); %>:</th>
     <td width=80%><input type="text" name="dslite_aftr_hostname" size="64" maxlength="64" style="width:150px"></td>
    </tr>
            </table>
            </div>
            </div>
  <table id=secIPv6Div style="display:none" cellpadding="0px" cellspacing="2px">
   <tr id=TrIpv6Addr>
    <th width="150px">IPv6 <% multilang("87" "LANG_IP_ADDRESS"); %>:</th>
    <td width=80% nowrap><input id="Ipv6Addr" maxLength=39 size=36 name="Ipv6Addr" style="width:150px ">/<input id="Ipv6PrefixLen" maxLength=3 size=3 name="Ipv6PrefixLen"></td>
   </tr>
   <tr id=TrIpv6Gateway>
    <th width="150px">IPv6 <% multilang("94" "LANG_GATEWAY"); %>:</th>
    <td width=80%><input id="Ipv6Gateway" maxLength=39 size=36 name="Ipv6Gateway" style="width:150px "></td>
   </tr>
  </table>
  <table id=tbdnsv6set style="display:block" border=0 width="600" cellspacing=4 cellpadding=0>
   <tr class="sep"><td colspan="2"><hr align="left" class="sep" size="1" width="100%"></td></tr>
   <tr nowrap>
    <th width="150px">Request DNSv6:</th>
    <td width=80%><input type="radio" value="1" name="dnsv6Mode" checked onClick='dnsv6ModeClicked()'>Enable</td>
   </tr>
   <tr nowrap>
    <td width="150px"></td>
    <td width=80%><input type="radio" value="0" name="dnsv6Mode" onClick='dnsv6ModeClicked()'>Disable</td>
   </tr>
   <tr nowrap>
    <th width="150px"><% multilang("301" "LANG_PRIMARY"); %> DNS:</th>
    <td width=80%><input type="text" name="Ipv6Dns1" size="36" maxlength="39" style="width:150px " value= ></td>
   </tr>
   <tr nowrap>
    <th width="150px"><% multilang("302" "LANG_SECONDARY"); %> DNS:</th>
    <td width=80%><input type=text name="Ipv6Dns2" size="36" maxlength="39" style="width:150px " value=></td>
   </tr>
  </table>
  <table id="dhcp6c_ctrlblock" style="display:none" border=0 cellspacing=4 cellpadding=0>
   <tr nowrap>
    <th width="150px"><font size=1>Request Options:</td>
    <td width=80%></td>
   </tr>
   <tr nowrap>
    <th width="150px"><font size=1><b></b></th>
    <td width=80%>
     <input type="checkbox" value="ON" name="iana" id="send1"><font size=1>Request Address
    </td>
   </tr>
  </table>
 </div>
 <br>
 <div class="intro_main" id="tbindip">
  <p class="intro_content"><% multilang("3001" "LANG_WAN_NOTE_1"); %></p><br>
 </div>
 <div class="intro_main" id="attention">
   <p class="intro_content"><% multilang("3002" "LANG_WAN_NOTE_2"); %></p><br>
 </div>
 <div class="btn_ctl">
    <input type="button" class="link_bg" onClick="on_submit('sv');;" value=<% multilang("138" "LANG_APPLY_CHANGES"); %>>&nbsp; &nbsp; &nbsp; &nbsp;
    <input type="button" class="link_bg" onClick="on_submit('rm');" value=<% multilang("289" "LANG_DELETE"); %>>&nbsp; &nbsp; &nbsp; &nbsp;
    <input type="hidden" name="cmode" value="0">
    <!--<input type="hidden" name="dslite_enable" value="0"> -->
    <input type="hidden" name="ipDhcp" value="0">
    <input type="hidden" name="itfGroup" value="0">
    <input type="hidden" name="encodePppUserName" value="">
    <input type="hidden" name="encodePppPassword" value="">
    <input type="hidden" id="lst" name="lst" value="">
    <input type="hidden" id="action" name="action" value="none">
    <input type="hidden" name="submit-url" value="">
    <input type="hidden" id="acnameflag" name="acnameflag" value="none">
    <br><br><br>
 </div>
   </form>
 </blockquote>
</body>
<%addHttpNoCache();%>
</HTML>
