<%SendWebHeadStr("mobile_normal_2"); %>
<title></title>
</head>
<body>
<form action=/boaform/admin/formLogout method=POST name="top" id="myform" target="_top">
<div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
        <div class="clear"></div>
 </div>
    <!-- end header -->
    <!-- start page -->
    <div class="page">
            <!-- start profile box -->
            <div class="profilebox"><table>
             <tr><td width=50% align="left"><% multilang("3649" "LANG_WELCOME"); %></td><td width=50% align="right"></td></tr></table>
                <a href="#" class="logout" onclick="document.getElementById('myform').submit();return false;">logout</a>
                <div class="clear"></div>
            </div>
            <!-- end profile box -->
            <!-- start menu -->
             <ul id="menu">
  <li><a href="basicstatus.asp"><img src="img/icons/devicestatus.png" width="29" height="21" alt="icon" class="m-icon"/><b><% multilang("4" "LANG_DEVICE"); %> <% multilang("3" "LANG_STATUS"); %></b></a></li>
  <li><a href="net_dhcpd_mobile.asp"><img src="img/icons/lansetting.png" width="32" height="22" alt="icon" class="m-icon"/><b>LAN <% multilang("356" "LANG_SETTINGS"); %></b></a></li>
  <li><a href="../boaform/formWlanRedirect?redirect-url=/mobile/wlbasic_mobile.asp&wlan_idx=0"><img src="img/icons/5gwifi.png" width="28" height="21" alt="icon" class="m-icon"/><b>5G WIFI</b></a></li>
  <li><a href="../boaform/formWlanRedirect?redirect-url=/mobile/wlbasic_mobile.asp&wlan_idx=1"><img src="img/icons/24gwifi.png" width="28" height="21" alt="icon" class="m-icon"/><b>2.4G WIFI</b></a></li>
  <li><a href="secu_urlfilter_cfg_mobile.asp"><img src="img/icons/wanaccess.png" width="28" height="21" alt="icon" class="m-icon"/><b><% multilang("2905" "LANG_WAN_ACCESS_CONFIG"); %></b></a></li>
  <li><a href="secu_macfilter_src_mobile.asp"><img src="img/icons/macfilter.png" width="23" height="21" alt="icon" class="m-icon"/><b><% multilang("18" "LANG_MAC_FILTERING"); %></b></a></li>
  <li><a href="mgm_usr_user_mobile.asp"><img src="img/icons/user.png" width="24" height="21" alt="icon" class="m-icon"/><b><% multilang("2920" "LANG_USER_MANAGEMENT"); %></b></a></li>
  <li><a href="mgm_dev_reboot_mobile.asp"><img src="img/icons/devicemanage.png" width="29" height="19" alt="icon" class="m-icon"/><b><% multilang("2921" "LANG_DEVICE_MANAGEMENT"); %></b></a></li>
             </ul>
            <!-- end menu -->
            <!-- start top button -->
            <div class="topbutton"><a href="#"><span>Top</span></a></div>
            <!-- end top button -->
            <!-- start footer -->
            <div class="footer">
             <a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a>
            </div>
            <!-- end footer -->
    <div class="clear"></div>
    </div>
    <!-- end page -->
<script type="text/javascript" src="js/frame.js"></script>
</body>
</html>
