<%SendWebHeadStr(); %>
<title><% multilang("3551" "LANG_STD_DEVICE_TITLE"); %></title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
 <blockquote>
  <div class="intro_main ">
   <p class="intro_title"><% multilang("2875" "LANG_NET_CONNECT_INFO"); %></p>
  </div>
  <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width=40%><% multilang("2876" "LANG_NET_CONNECT_STATE"); %></th>
     <td><% showepon_status(); %></td>
    </tr>
    <tr <% checkWrite("priv"); %> >
     <th width=40%><% multilang("90" "LANG_MAC_ADDRESS"); %></th>
     <td><% ponGetStatus("epon-mac-address"); %></td>
    </tr>
    <tr <% checkWrite("priv"); %>>
     <th width=40%><% multilang("3337" "LANG_FEC_CAPACITY"); %></th>
     <td><% multilang("801" "LANG_SUPPORT"); %></td>
    </tr>
    <tr <% checkWrite("priv"); %>>
     <th width=40%><% multilang("3338" "LANG_FEC_UPSTREAM_STATUS"); %></th>
     <td><% ponGetStatus("epon-fec-us-state"); %></td>
    </tr>
    <tr <% checkWrite("priv"); %>>
     <th width=40%><% multilang("3339" "LANG_FEC_DOWNSTREAM_STATUS"); %></th>
     <td><% ponGetStatus("epon-fec-ds-state"); %></td>
    </tr>
    <tr <% checkWrite("priv"); %>>
     <th width=40%><% multilang("3340" "LANG_ENCRYPT_MODE"); %></th>
     <td><% ponGetStatus("epon-triple-churning"); %></td>
    </tr>
   </table>
  </div>
  <br>
  <div class="intro_main ">
   <p class="intro_title"><% multilang("3341" "LANG_LASER_DEVICE_INFO"); %></p>
  </div>
  <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width=40%><% multilang("111" "LANG_TX_POWER"); %></th>
     <td><% ponGetStatus("tx-power"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("112" "LANG_RX_POWER"); %></th>
     <td><% ponGetStatus("rx-power"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("109" "LANG_TEMPERATURE");%></th>
     <td><% ponGetStatus("temperature"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("110" "LANG_VOLTAGE"); %></th>
     <td><% ponGetStatus("voltage"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("113" "LANG_BIAS_CURRENT"); %></th>
     <td><% ponGetStatus("bias-current"); %></td>
    </tr>
   </table>
  </div>
  <br>
  <span <% checkWrite("priv"); %>>
  <div class="intro_main ">
   <p class="intro_title"><% multilang("3343" "LANG_LINK_PERFORMANCE_INFO"); %></p>
  </div>
  <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width=40%><% multilang("3344" "LANG_TX_BYTE"); %></th>
     <td><% ponGetStatus("bytes-sent"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3345" "LANG_RX_BYTE"); %></th>
     <td><% ponGetStatus("bytes-received"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3346" "LANG_TX_FRAME"); %></th>
     <td><% ponGetStatus("packets-sent"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3347" "LANG_RX_FRAME"); %></th>
     <td><% ponGetStatus("packets-received"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3348" "LANG_TX_UNICAST_FRAME"); %></th>
     <td><% ponGetStatus("unicast-packets-sent"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3349" "LANG_RX_UNICAST_FRAME"); %></th>
     <td><% ponGetStatus("unicast-packets-received"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3350" "LANG_TX_MULTICAST_FRAME"); %></th>
     <td><% ponGetStatus("multicast-packets-sent"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3351" "LANG_RX_MULTICAST_FRAME"); %></th>
     <td><% ponGetStatus("multicast-packets-received"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3352" "LANG_TX_BROADCAST_FRAME"); %></th>
     <td><% ponGetStatus("broadcast-packets-sent"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3353" "LANG_RX_BROADCAST_FRAME"); %></th>
     <td><% ponGetStatus("broadcast-packets-received"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3354" "LANG_RX_FEC_ERR_FRAME");%></th>
     <td><% ponGetStatus("fec-errors"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3355" "LANG_RX_HEC_ERR_FRAME"); %></th>
     <td><% ponGetStatus("hec-errors"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3356" "LANG_TX_LOSE_FRAME"); %></th>
     <td><% ponGetStatus("packets-dropped"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3357" "LANG_TX_PAUSE_STREAM_CONTROL_FRAME"); %></th>
     <td><% ponGetStatus("pause-packets-sent"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3358" "LANG_RX_PAUSE_STREAM_CONTROL_FRAME"); %></th>
     <td><% ponGetStatus("pause-packets-received"); %></td>
    </tr>
   </table>
  </div>
  <br>
  <div class="intro_main ">
   <p class="intro_title"><% multilang("3359" "LANG_ALARM_INFO"); %></p>
  </div>
  <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width=40%><% multilang("3360" "LANG_EPON_ALARM_INFO"); %></th>
     <td><% ponGetStatus("epon-los"); %></td>
    </tr>
   </table>
  </div>
 </blockquote>
</body>
<%addHttpNoCache();%>
</html>
