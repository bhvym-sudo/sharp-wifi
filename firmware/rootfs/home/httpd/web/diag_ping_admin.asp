<%SendWebHeadStr(); %>
<TITLE><% multilang("3201" "LANG_PING_TEST"); %></TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--System common script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT>
var links = new Array();
with(links){<% listWanif("rt"); %>}
/********************************************************************
**          on document load
********************************************************************/
function on_Apply(){
 if( !sji_checkvip(document.forms[0].target_addr.value) && !sji_checkhostname(document.forms[0].target_addr.value)
  && !isIPv6(document.forms[0].target_addr.value)){
  alert("<% multilang("3203" "LANG_DESTINATION_ADDRESS_ERR"); %>");
  document.forms[0].target_addr.focus();
  return false;
 }
 return true;
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form id="form" action=/boaform/admin/formPing method=POST>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3201" "LANG_PING_TEST"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("3202" "LANG_DESTINATION_ADDRESS"); %></th>
    <td><input type="text" name="target_addr" maxlength="60" /></td>
   </tr>
   <tr>
    <th width=40%><% multilang("405" "LANG_WAN_INTERFACE"); %>:</th>
    <td><select name="waninf"><% checkWrite("wan-interface-name"); %></select></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input class="link_bg" type="submit" value="Ping" width="100px" onClick="return on_Apply();" />
 </div>
 </form>
</blockquote>
</body>
</html>
