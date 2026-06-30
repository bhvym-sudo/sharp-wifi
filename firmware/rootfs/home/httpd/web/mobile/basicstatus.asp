<%SendWebHeadStr("mobile_normal_1"); %>
<title></title>
</head>
<body>
<div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
         <div class="clear"></div>
</div>
<div class="page">
 <div class="simplebox">
   <table class="tabletitle">
    <tr>
     <td><% multilang("2859" "LANG_DEVICE_INFO"); %></td>
    </tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width=40%><% multilang("2786" "LANG_DEVICE_MODEL"); %></td>
     <td width=60%><% getInfo("devModel"); %></td>
    </tr>
    <tr>
     <td width=40%><% multilang("2861" "LANG_DEVICE_SN"); %></td>
     <td width=60%><% getInfo("devId"); %></td>
    </tr>
    <tr>
     <td width=40%><% multilang("2829" "LANG_HARDWARE_VERSION"); %></td>
     <td width=60%><% getInfo("hdVer"); %></td>
    </tr>
    <tr>
     <td width=40%><% multilang("77" "LANG_FIRMWARE_VERSION"); %></td>
     <td width=60%><% getInfo("stVer"); %></td>
    </tr>
    <tr>
     <td width="40%"><% multilang("87" "LANG_IP_ADDRESS"); %></td>
     <td><% getInfo("lan-ip"); %></td>
    </tr>
    <tr>
     <td width="40%">MAC Address<% multilang("90" "LANG_MAC_ADDRESS"); %></td>
     <td><% getInfo("elan-Mac"); %></td>
    </tr>
                    </table>
                    <table class="tabletitle">
    <tr <%checkWrite("whichponmode");%>>
     <td>GPON <% multilang("2969" "LANG_INFO"); %></td>
    </tr>
    <tr <%checkWrite("whichponmode1");%>>
     <td>EPON <% multilang("2969" "LANG_INFO"); %></td>
    </tr>
   </table>
                    <table class="tabledata">
    <tr <%checkWrite("whichponmode");%>>
     <td width=40%><% multilang("2876" "LANG_NET_CONNECT_STATE"); %></td>
     <td><% showgpon_status(); %></td>
    </tr>
    <tr <%checkWrite("whichponmode1");%>>
     <td width=40%><% multilang("2876" "LANG_NET_CONNECT_STATE"); %></td>
     <td><% showepon_status(); %></td>
    </tr>
   </table>
    <table class="tabletitle">
    <tr>
     <td><% multilang("2973" "LANG_LASER_DEVICE"); %> <% multilang("2969" "LANG_INFO"); %></td>
    </tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width=40%><% multilang("111" "LANG_TX_POWER"); %></td>
     <td><% ponGetStatus("tx-power"); %></td>
    </tr>
    <tr>
     <td width=40%><% multilang("112" "LANG_RX_POWER"); %></td>
     <td><% ponGetStatus("rx-power"); %></td>
    </tr>
    <tr>
     <td width=40%><% multilang("109" "LANG_TEMPERATURE");%></td>
     <td><% ponGetStatus("temperature"); %></td>
    </tr>
    <tr>
     <td width=40%><% multilang("110" "LANG_VOLTAGE"); %></td>
     <td><% ponGetStatus("voltage"); %></td>
    </tr>
    <tr>
     <td width=40%><% multilang("113" "LANG_BIAS_CURRENT"); %></td>
     <td><% ponGetStatus("bias-current"); %></td>
    </tr>
   </table>
 </div>
 <div class="topbutton"><a href="#"><span>Top</span></a></div>
 <div class="footer"><a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a></div>
 <div class="clear"></div>
</div>
</html>
