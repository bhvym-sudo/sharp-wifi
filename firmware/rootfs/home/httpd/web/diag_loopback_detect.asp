<%SendWebHeadStr(); %>
<title>Loopback Detect</title>
<script type="text/javascript" src="share.js">
</script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<% language=javascript %>
<SCRIPT>
<% initLBDPage(); %>
function on_init()
{
 if(lbd_enable)
  document.lbd.enable.checked = true;
 document.lbd.exist_period.value = lbd_exist_period;
 document.lbd.cancel_period.value = lbd_cancel_period;
 document.lbd.ether_type.value = lbd_ether_type.toString(16).toUpperCase();
 document.lbd.vlans.value = lbd_vlans;
 var table = document.getElementById("port_status");
 for(var i = 0 ; i < lbd_port_status.length ; i++)
 {
  var cell;
  var row = table.insertRow(-1);
  cell = row.insertCell(0);
  cell.innerHTML = "LAN" + (i+1);
  cell = row.insertCell(1);
  switch(lbd_port_status[i])
  {
  case 0:
   cell.innerHTML = "<% multilang("3217" "LANG_NO_LOOPBACK"); %>";
   break;
  case 1:
   cell.innerHTML = "<% multilang("3218" "LANG_LOOPBACK_DETECTE_RESULT_1"); %>";
   break;
  case 2:
   cell.innerHTML = "<% multilang("3219" "LANG_LOOPBACK_DETECTE_RESULT_2"); %>";
   break;
  }
 }
 update_gui();
}
function disable_by_class(str_class, disable)
{
 var elements = document.getElementsByClassName(str_class);
 for (var i = 0 ; i < elements.length ; i++)
  elements[i].disabled = disable;
}
function update_gui()
{
 with(document.lbd)
 {
  if(enable.checked == true)
   disable_by_class("lbd", false);
  else
   disable_by_class("lbd", true);
 }
}
function on_submit()
{
 with(document.lbd)
 {
  if(enable.checked == false)
   return true;
  if(!sji_checkdigitrange(exist_period.value, 1, 60))
  {
   alert("<% multilang("3220" "LANG_LOOPBACK_DETECTE_ERR_1"); %>");
   exist_period.focus();
   return false;
  }
  if(!sji_checkdigitrange(cancel_period.value, 10, 1800))
  {
   alert("<% multilang("3221" "LANG_LOOPBACK_DETECTE_ERR_2"); %>");
   cancel_period.focus();
   return false;
  }
  if(!sji_checkhex(ether_type.value, 1, 4))
  {
   alert("<% multilang("3222" "LANG_LOOPBACK_DETECTE_ERR_3"); %>");
   ether_type.focus();
   return false;
  }
  if(vlans.value.length <= 0)
  {
   alert("<% multilang("3223" "LANG_LOOPBACK_DETECTE_ERR_4"); %>");
   vlans.focus();
   return false;
  }
 }
 return true;
}
</SCRIPT>
</head>
<body onLoad="on_init();" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
<form action=/boaform/formLBD method=POST name="lbd">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3208" "LANG_LOOPBACK_TEST"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
     <tr>
          <th width="40%"><% multilang("3209" "LANG_ENABLE_LOOPBACK_DETECTION"); %></th>
          <td width="60%"><input type="checkbox" name="enable" value="1" onClick="update_gui();"></td>
     </tr>
     <tr>
          <th width="40%"><% multilang("3210" "LANG_DETECTION_FRAME_INTERVAL"); %></th>
          <td width="60%"><input type="text" class="lbd" name="exist_period" size="15" maxlength="5"> (1~60)</td>
         </tr>
     <tr>
          <th width="40%"><% multilang("3211" "LANG_RECOVER_FRAME_INTERVAL"); %></th>
          <td width="60%"><input type="text" class="lbd" name="cancel_period" size="15" maxlength="15"> (10 ~ 1800)</td>
     </tr>
     <tr>
          <th width="40%"><% multilang("3212" "LANG_ETHERTYPE"); %></th>
          <td width="60%">&nbsp;&nbsp;0x<input type="text" class="lbd" name="ether_type" size="13" maxlength="4"></td>
     </tr>
     <tr>
          <th width="40%"><% multilang("3213" "LANG_VLAN_ID_TITLE");%></th>
          <td width="60%"><input type="text" class="lbd" name="vlans" size="30" maxlength="300">&nbsp;&nbsp;&nbsp;<% multilang("3214" "LANG_LOOPBACK_TEST_PAGE"); %></td>
     </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
    <input class="link_bg" type="submit" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>" onClick="return on_submit()">
   </div>
   <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3216" "LANG_PORT_LOOPBACK_DETECT_STATE"); %></p>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table id="port_status">
   <tr align="center">
    <th><% multilang("199" "LANG_PORT"); %></th>
    <th><% multilang("237" "LANG_STATE"); %></th>
   </tr>
  </table>
 </div>
   <br>
      <input type="hidden" value="/diag_loopback_detect.asp" name="submit-url">
</form>
</blockquote>
</body>
</html>
