<%SendWebHeadStr(); %>
<TITLE>RADVD Configuration Setup</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" type="text/javascript">
function resetClick()
{
 document.radvd.reset;
}
function saveChanges()
{
 if (document.radvd.MaxRtrAdvIntervalAct.value.length !=0) {
  if ( checkDigit(document.radvd.MaxRtrAdvIntervalAct.value) == 0) {
   alert("<% multilang("2328" "LANG_INVALID_MAXRTRADVINTERVAL_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.radvd.MaxRtrAdvIntervalAct.focus();
   return false;
  }
 }
 MaxRAI = parseInt(document.radvd.MaxRtrAdvIntervalAct.value, 10);
 if ( MaxRAI < 4 || MaxRAI > 1800 ) {
  alert("<% multilang("2329" "LANG_MAXRTRADVINTERVAL_MUST_BE_NO_LESS_THAN_4_SECONDS_AND_NO_GREATER_THAN_1800_SECONDS"); %>");
  document.radvd.MaxRtrAdvIntervalAct.focus();
  return false;
 }
 if (document.radvd.MinRtrAdvIntervalAct.value.length !=0) {
  if ( checkDigit(document.radvd.MinRtrAdvIntervalAct.value) == 0) {
   alert("<% multilang("2330" "LANG_INVALID_MINRTRADVINTERVAL_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.radvd.MinRtrAdvIntervalAct.focus();
   return false;
  }
 }
 MinRAI = parseInt(document.radvd.MinRtrAdvIntervalAct.value, 10);
 MaxRAI075 = 0.75 * MaxRAI;
 if ( MinRAI < 3 || MinRAI > MaxRAI075 ) {
  alert("<% multilang("2331" "LANG_MINRTRADVINTERVAL_MUST_BE_NO_LESS_THAN_3_SECONDS_AND_NO_GREATER_THAN_0_75_MAXRTRADVINTERVAL"); %>");
  document.radvd.MinRtrAdvIntervalAct.focus();
  return false;
 }
 if (document.radvd.AdvCurHopLimitAct.value.length !=0) {
  if ( checkDigit(document.radvd.AdvCurHopLimitAct.value) == 0) {
   alert("<% multilang("2332" "LANG_INVALID_ADVCURHOPLIMIT_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.radvd.AdvCurHopLimitAct.focus();
   return false;
  }
 }
 if (document.radvd.AdvDefaultLifetimeAct.value.length !=0) {
  if ( checkDigit(document.radvd.AdvDefaultLifetimeAct.value) == 0) {
   alert("<% multilang("2333" "LANG_INVALID_ADVDEFAULTLIFETIME_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.radvd.AdvDefaultLifetimeAct.focus();
   return false;
  }
 }
 dlt = parseInt(document.radvd.AdvDefaultLifetimeAct.value, 10);
 if ( dlt != 0 && (dlt < MaxRAI || dlt > 9000) ) {
  alert("<% multilang("2334" "LANG_ADVDEFAULTLIFETIME_MUST_BE_EITHER_ZERO_OR_BETWEEN_MAXRTRADVINTERVAL_AND_9000_SECONDS"); %>");
  document.radvd.AdvDefaultLifetimeAct.focus();
  return false;
 }
 if (document.radvd.AdvReachableTimeAct.value.length !=0) {
  if ( checkDigit(document.radvd.AdvReachableTimeAct.value) == 0) {
   alert("<% multilang("2335" "LANG_INVALID_ADVREACHABLETIME_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.radvd.AdvReachableTimeAct.focus();
   return false;
  }
 }
 if (document.radvd.AdvRetransTimerAct.value.length !=0) {
  if ( checkDigit(document.radvd.AdvRetransTimerAct.value) == 0) {
   alert("<% multilang("2336" "LANG_INVALID_ADVRETRANSTIMER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.radvd.AdvRetransTimerAct.focus();
   return false;
  }
 }
 if (document.radvd.AdvLinkMTUAct.value.length !=0) {
  if ( checkDigit(document.radvd.AdvLinkMTUAct.value) == 0) {
   alert("<% multilang("2337" "LANG_INVALID_ADVLINKMTU_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.radvd.AdvLinkMTUAct.focus();
   return false;
  }
 }
 lmtu= parseInt(document.radvd.AdvLinkMTUAct.value, 10);
 if ( lmtu != 0 && (lmtu < 1280 || lmtu > 1500) ) {
  alert("<% multilang("2338" "LANG_ADVLINKMTU_MUST_BE_EITHER_ZERO_OR_BETWEEN_1280_AND_1500"); %>");
  document.radvd.AdvLinkMTUAct.focus();
  return false;
 }
 if (document.radvd.PrefixMode.value == 1) {
  if (document.radvd.prefix_ip.value =="") {
   alert("<% multilang("2339" "LANG_ULA_PREFIX_IP_ADDRESS_CANNOT_BE_EMPTY_FORMAT_IS_IPV6_ADDRESS_FOR_EXAMPLE_FC01"); %>");
   document.radvd.prefix_ip.value = document.radvd.prefix_ip.defaultValue;
   document.radvd.prefix_ip.focus();
   return false;
  } else {
   if ( validateKeyV6IP(document.radvd.prefix_ip.value) == 0) {
    alert("<% multilang("2340" "LANG_INVALID_ULA_PREFIX_IP"); %>");
    document.radvd.prefix_ip.focus();
    return false;
   }
  }
  if (document.radvd.prefix_len.value =="") {
   alert("<% multilang("2341" "LANG_ULA_PREFIX_LENGTH_CANNOT_BE_EMPTY_FOR_EXAMPLE_64"); %>");
   document.radvd.prefix_len.value = document.radvd.prefix_len.defaultValue;
   document.radvd.prefix_len.focus();
   return false;
  } else {
   if ( checkDigit(document.radvd.prefix_len.value) == 0) {
    alert("<% multilang("2342" "LANG_INVALID_ULA_PREFIX_LENGTH_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
    document.radvd.prefix_len.focus();
    return false;
   }
  }
  if (document.radvd.AdvValidLifetimeAct.value.length !=0) {
   if ( checkDigit(document.radvd.AdvValidLifetimeAct.value) == 0) {
   alert("<% multilang("2343" "LANG_ULA_PREFIX_VALID_TIME_CANNOT_BE_EMPTY_VALID_RANGE_IS_600_4294967295"); %>");
    document.radvd.AdvValidLifetimeAct.focus();
    return false;
   }
  }
  if (document.radvd.AdvPreferredLifetimeAct.value.length !=0) {
   if ( checkDigit(document.radvd.AdvPreferredLifetimeAct.value) == 0) {
    alert("<% multilang("2345" "LANG_INVALID_ULAPREFIXPREFEREDTIME_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
    document.radvd.AdvPreferredLifetimeAct.focus();
    return false;
   }
  }
  vlt = parseInt(document.radvd.AdvValidLifetimeAct.value, 10);
  plt = parseInt(document.radvd.AdvPreferredLifetimeAct.value, 10);
  if ( vlt <= plt ) {
   alert("<% multilang("2352" "LANG_ADVVALIDLIFETIME_MUST_BE_GREATER_THAN_ADVPREFERREDLIFETIME"); %>");
   document.radvd.AdvValidLifetimeAct.focus();
   return false;
  }
 }
 return true;
}
function updateInput()
{
 if (document.radvd.PrefixMode.value == 1 ) {
  if (document.getElementById) // DOM3 = IE5, NS6
   document.getElementById('radvdID').style.display = 'block';
   else {
   if (document.layers == false) // IE4
    document.all.radvdID.style.display = 'block';
  }
 } else {
  if (document.getElementById) // DOM3 = IE5, NS6
   document.getElementById('radvdID').style.display = 'none';
  else {
   if (document.layers == false) // IE4
    document.all.radvdID.style.display = 'none';
  }
 }
}
function ramodechange(obj)
{
 with ( document.forms[0] )
 {
  if(obj.value == "0")
  {
   if (document.getElementById) // DOM3 = IE5, NS6
   document.getElementById('radvdID').style.display = 'none';
   else {
    if (document.layers == false) // IE4
     document.all.radvdID.style.display = 'none';
   }
  }
  else
  {
   if (document.getElementById) // DOM3 = IE5, NS6
   document.getElementById('radvdID').style.display = 'block';
   else {
   if (document.layers == false) // IE4
    document.all.radvdID.style.display = 'block';
   }
  }
 }
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
<form action=/boaform/formRadvdSetup method=POST name="radvd">
 <div class="intro_main ">
  <p class="intro_title">RA <% multilang("224" "LANG_CONFIGURATION"); %></p> <br>
 </div>
 <div class="data_common data_common_notitle">
    <table>
     <tr>
      <th width=40%>RA <% multilang("234" "LANG_ENABLE"); %>:&nbsp;&nbsp;</th>
      <td>
       <input type="radio" name="radvd_enable" value=0 <% checkWrite("radvd_enable0"); %>>off&nbsp;&nbsp;
       <input type="radio" name="radvd_enable" value=1 <% checkWrite("radvd_enable1"); %>>on&nbsp;&nbsp;
      </td>
     </tr>
     <tr>
      <th width=40%><% multilang("441" "LANG_ADVMANAGEDFLAG"); %>:&nbsp;&nbsp;</th>
          <td>
        <input type="radio" name="AdvManagedFlagAct" value=0 <% checkWrite("radvd_ManagedFlag0"); %>>off&nbsp;&nbsp;
        <input type="radio" name="AdvManagedFlagAct" value=1 <% checkWrite("radvd_ManagedFlag1"); %>>on&nbsp;&nbsp;
    </td>
   </tr>
     <tr>
      <th width=40%><% multilang("442" "LANG_ADVOTHERCONFIGFLAG"); %>:&nbsp;&nbsp;</th>
    <td>
     <input type="radio" name="AdvOtherConfigFlagAct" value=0 <% checkWrite("radvd_OtherConfigFlag0"); %>>off&nbsp;&nbsp;
     <input type="radio" name="AdvOtherConfigFlagAct" value=1 <% checkWrite("radvd_OtherConfigFlag1"); %>>on&nbsp;&nbsp;
    </td>
   </tr>
    <tr>
    <td width="150px"><% multilang("433" "LANG_MAXRTRADVINTERVAL"); %>:</td>
    <td><input type="text" name="MaxRtrAdvIntervalAct" size="15" maxlength="15" value=<% getInfo("V6MaxRtrAdvInterval"); %>></td>
   </tr>
   <tr>
    <th width=40%><% multilang("434" "LANG_MINRTRADVINTERVAL"); %>:</th>
    <td><input type="text" name="MinRtrAdvIntervalAct" size="15" maxlength="15" value=<% getInfo("V6MinRtrAdvInterval"); %>></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" ID="radvdID" style="display:none">
    <table>
    <tr>
         <th width=40%>AdvCurHopLimit:</th>
         <td><input type="text" name="AdvCurHopLimitAct" size="15" maxlength="15" value=<% getInfo("V6AdvCurHopLimit"); %>></td>
  </tr>
  <tr>
   <th width=40%>AdvDefaultLifetime:</th>
   <td><input type="text" name="AdvDefaultLifetimeAct" size="15" maxlength="15" value=<% getInfo("V6AdvDefaultLifetime"); %>></td>
  </tr>
  <tr>
   <th width=40%>AdvReachableTime:</th>
   <td><input type="text" name="AdvReachableTimeAct" size="15" maxlength="15" value=<% getInfo("V6AdvReachableTime"); %>></td>
  </tr>
  <tr>
   <th width=40%>AdvRetransTimer:</th>
   <td><input type="text" name="AdvRetransTimerAct" size="15" maxlength="15" value=<% getInfo("V6AdvRetransTimer"); %>></td>
  </tr>
  <tr>
   <th width=40%>AdvLinkMTU:</th>
   <td><input type="text" name="AdvLinkMTUAct" size="15" maxlength="15" value=<% getInfo("V6AdvLinkMTU"); %>></td>
  </tr>
    <tr>
     <th width=40%>AdvSendAdvert:&nbsp;&nbsp;</th>
         <td>
       <input type="radio" name="AdvSendAdvertAct" value=0 <% checkWrite("radvd_SendAdvert0"); %>>off&nbsp;&nbsp;
       <input type="radio" name="AdvSendAdvertAct" value=1 <% checkWrite("radvd_SendAdvert1"); %>>on&nbsp;&nbsp;
   </td>
  </tr>
    <tr>
   <th width=40%><% multilang("443" "LANG_PREFIX_MODE"); %>:</th>
   <td><select size="1" name="PrefixMode" id="prefixmode" onChange="ramodechange(this)">
     <OPTION VALUE="0" > <% multilang("155" "LANG_AUTO"); %></OPTION>
     <OPTION VALUE="1" > <% multilang("444" "LANG_MANUAL"); %></OPTION>
    </select>
   </td>
  </tr>
  <tr>
   <th width=40%><% multilang("104" "LANG_PREFIX"); %>:</th>
   <td><input type=text name=prefix_ip size=24 maxlength=24 value=<% getInfo("V6prefix_ip"); %>></td>
  </tr>
  <tr>
   <th width=40%><% multilang("445" "LANG_PREFIX_LENGTH"); %>:</th>
   <td><input type=text name=prefix_len size=15 maxlength=15 value=<% getInfo("V6prefix_len"); %>></td>
  </tr>
  <tr>
   <th width=40%><% multilang("446" "LANG_ADVVALIDLIFETIME"); %>:</th>
   <td><input type=text name=AdvValidLifetimeAct size=15 maxlength=15 value=<% getInfo("V6ValidLifetime"); %>></td>
  </tr>
  <tr>
   <th width=40%><% multilang("447" "LANG_ADVPREFERREDLIFETIME"); %>:</th>
   <td><input type=text name=AdvPreferredLifetimeAct size=15 maxlength=15 value=<% getInfo("V6PreferredLifetime"); %>></td>
  </tr>
  <tr>
   <th width=40%><% multilang("448" "LANG_ADVONLINK"); %>:&nbsp;&nbsp;</th>
   <td>
    <input type="radio" name="AdvOnLinkAct" value=0 <% checkWrite("radvd_OnLink0"); %>>off&nbsp;&nbsp;
    <input type="radio" name="AdvOnLinkAct" value=1 <% checkWrite("radvd_OnLink1"); %>>on&nbsp;&nbsp;
   </td>
  </tr>
  <tr>
   <th width=40%><% multilang("449" "LANG_ADVAUTONOMOUS"); %>:&nbsp;&nbsp;</th>
   <td>
    <input type="radio" name="AdvAutonomousAct" value=0 <% checkWrite("radvd_Autonomous0"); %>>off&nbsp;&nbsp;
    <input type="radio" name="AdvAutonomousAct" value=1 <% checkWrite("radvd_Autonomous1"); %>>on&nbsp;&nbsp;
   </td>
  </tr>
 </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="submit" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;
        <!--input type="reset" value="Undo" name="reset" onClick="resetClick()"-->
        <input type="hidden" value="/radvdconf.asp" name="submit-url">
 </div>
<script>
 <% initPage("radvd_conf"); %>
</script>
 </form>
</blockquote>
</body>
</html>
