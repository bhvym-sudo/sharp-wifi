<%SendWebHeadStr(); %>
<title><% multilang("3666" "LANG_PORT_CONNECT_STATE"); %></title>
<script type="text/javascript" src="share.js">
</script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<% language=javascript %>
<SCRIPT>
<% initLANStatusPage(); %>
function on_init()
{
 var lanNumbers = lan_ports_status.length;
 var table = document.getElementById("lan_stat");
 for(var i = 0 ; i < lanNumbers ; i++)
 {
  var cell;
  var row = table.insertRow(-1);
  cell = row.insertCell(0);
  cell.innerHTML = lan_ports_names[i];
  cell = row.insertCell(1);
  switch(lan_ports_status[i])
  {
  case 0:
   cell.innerHTML = "<% multilang("2971" "LANG_CONNECTED"); %>";
   break;
  case 1:
   cell.innerHTML = "<% multilang("2972" "LANG_NOT_CONNECTED"); %>";
   break;
  }
 }
}
</SCRIPT>
</head>
<body onLoad="on_init();" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3666" "LANG_PORT_CONNECT_STATE"); %></p>
 </div>
 <br>
 <div class="data_common data_common_notitle data_vertical">
  <table id="lan_stat">
   <tr align="center">
    <th><% multilang("199" "LANG_PORT"); %></th>
    <th><% multilang("237" "LANG_STATE"); %></th>
   </tr>
  </table>
 </div>
    <input type="hidden" value="/diag_lan_status.asp" name="submit-url">
</blockquote>
</body>
</html>
