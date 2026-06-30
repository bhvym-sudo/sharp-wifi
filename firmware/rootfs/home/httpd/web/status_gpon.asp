<% SendWebHeadStr();%>
<style>
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
    <td width=60%><% showgpon_status(); %></td>
   </tr>
   <tr <% checkWrite("priv"); %>>
    <th width=40%>FEC <% multilang("535" "LANG_CAPABILITY"); %></th>
    <td width=60%><% multilang("542" "LANG_YES"); %></td>
   </tr>
   <tr <% checkWrite("priv"); %>>
    <th width=40%>FEC <% multilang("1718" "LANG_TUPSTREAM"); %><% multilang("237" "LANG_STATE"); %></th>
    <td width=60%><% ponGetStatus("gpon-fec-us-state"); %></td>
   </tr>
   <tr <% checkWrite("priv"); %>>
    <th width=40%>FEC <% multilang("1717" "LANG_TDOWNSTREAM"); %><% multilang("237" "LANG_STATE"); %></th>
    <td width=60%><% ponGetStatus("gpon-fec-ds-state"); %></td>
   </tr>
   <tr <% checkWrite("priv"); %>>
    <th><% multilang("187" "LANG_ENCRYPTION"); %><% multilang("129" "LANG_MODE"); %></th>
    <td><% ponGetStatus("gpon-encryption"); %></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="intro_main">
  <p class="intro_title"><% multilang("2973" "LANG_LASER_DEVICE"); %> <% multilang("2969" "LANG_INFO"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("111" "LANG_TX_POWER"); %></th>
    <td width=60%><% ponGetStatus("tx-power"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("112" "LANG_RX_POWER"); %></th>
    <td width=60%><% ponGetStatus("rx-power"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("109" "LANG_TEMPERATURE"); %></th>
    <td width=60%><% ponGetStatus("temperature"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("110" "LANG_VOLTAGE"); %></th>
    <td width=60%><% ponGetStatus("voltage"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("113" "LANG_BIAS_CURRENT"); %></th>
    <td width=60%><% ponGetStatus("bias-current"); %></td>
   </tr>
  </table>
 </div>
 <br>
 <span <% checkWrite("priv"); %>>
 <div class="intro_main">
 <p class="intro_title">GPON <% multilang("1233" "LANG_STATISTICS"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("867" "LANG_BYTES_SENT"); %></th>
    <td width=60%><% ponGetStatus("bytes-sent"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("868" "LANG_BYTES_RECEIVED"); %></th>
    <td width=60%><% ponGetStatus("bytes-received"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("869" "LANG_PACKETS_SENT"); %></th>
    <td width=60%><% ponGetStatus("packets-sent"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("870" "LANG_PACKETS_RECEIVED"); %></th>
    <td width=60%><% ponGetStatus("packets-received"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("871" "LANG_UNICAST_PACKETS_SENT"); %></th>
    <td width=60%><% ponGetStatus("unicast-packets-sent"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("872" "LANG_UNICAST_PACKETS_RECEIVED"); %></th>
    <td width=60%><% ponGetStatus("unicast-packets-received"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("873" "LANG_MULTICAST_PACKETS_SENT"); %></th>
    <td width=60%><% ponGetStatus("multicast-packets-sent"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("874" "LANG_MULTICAST_PACKETS_RECEIVED"); %></th>
    <td width=60%><% ponGetStatus("multicast-packets-received"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("875" "LANG_BROADCAST_PACKETS_SENT"); %></th>
    <td width=60%><% ponGetStatus("broadcast-packets-sent"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("876" "LANG_BROADCAST_PACKETS_RECEIVED"); %></th>
    <td width=60%><% ponGetStatus("broadcast-packets-received"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("877" "LANG_FEC_ERRORS"); %></th>
    <td width=60%><% ponGetStatus("fec-errors"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("878" "LANG_HEC_ERRORS"); %></th>
    <td width=60%><% ponGetStatus("hec-errors"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("879" "LANG_PACKETS_DROPPED"); %></th>
    <td width=60%><% ponGetStatus("packets-dropped"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("880" "LANG_PAUSE_PACKETS_SENT"); %></th>
    <td width=60%><% ponGetStatus("pause-packets-sent"); %></td>
   </tr>
   <tr>
    <th width=40%><% multilang("881" "LANG_PAUSE_PACKETS_RECEIVED"); %></th>
    <td width=60%><% ponGetStatus("pause-packets-received"); %></td>
   </tr>
   </table>
  </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("968" "LANG_ALARM"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%>GPON <% multilang("968" "LANG_ALARM"); %></th>
    <td width=60%><% ponGetStatus("gpon-alarm"); %></td>
   </tr>
  </table>
 </div><br>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
