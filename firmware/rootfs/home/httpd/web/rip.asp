<%SendWebHeadStr(); %>
<TITLE>Dynamic Routing</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" type="text/javascript">
var ifnum;
function selected()
{
 document.rip.ripDel.disabled = false;
}
function resetClicked()
{
 document.rip.ripDel.disabled = true;
}
function disableDelButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.rip.ripDel);
 disableButton(document.rip.ripDelAll);
  }
}
/*  Added by Slim on 2018-09-06   */
function deleteClick()
{
 if ( !confirm("<% multilang("3477" "LANG_DELETE_THIS_SETTTING") %>")) {
  return false;
 }
 else
  return true;
}
function deleteAllClick()
{
 if ( !confirm("<% multilang("3562" "LANG_DELETE_ALL_SETTTING_IN_THE_TABLE") %>")) {
  return false;
 }
 else
  return true;
}
/* End of added */
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form action=/boaform/formRip method=POST name="rip">
 <div class="intro_main ">
  <p class="intro_title">RIP <% multilang("224" "LANG_CONFIGURATION"); %></p><br>
  <p class="intro_content"><% multilang("408" "LANG_ENABLE_THE_RIP_IF_YOU_ARE_USING_THIS_DEVICE_AS_A_RIP_ENABLED_DEVICE_TO_COMMUNICATE_WITH_OTHERS_USING_THE_ROUTING_INFORMATION_PROTOCOL_THIS_PAGE_IS_USED_TO_SELECT_THE_INTERFACES_ON_YOUR_DEVICE_IS_THAT_USE_RIP_AND_THE_VERSION_OF_THE_PROTOCOL_USED"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
     <tr>
    <th width=40%><% multilang("29" "LANG_RIP"); %>:</th>
    <td width=30%><input type="radio" value="0" name="rip_on" <% checkWrite("rip-on-0"); %> ><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;<input type="radio" value="1" name="rip_on" <% checkWrite("rip-on-1"); %> ><% multilang("234" "LANG_ENABLE"); %>&nbsp;&nbsp;</td>
     <td width=30%><input type="submit" class="inner_btn" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="ripSet">&nbsp;&nbsp;</td>
   </tr>
  </table>
  <table>
   <tr>
    <th width=40%><% multilang("68" "LANG_INTERFACE"); %>:</th>
    <td><select name="rip_if"><option value="65535">br0</option><% if_wan_list("rt"); %></select></td>
   </tr>
   <tr>
    <th width=40%><% multilang("409" "LANG_RECEIVE_MODE"); %>:</th>
    <td>
     <select size="1" name="receive_mode">
      <option value="0">None</option>
      <option value="1">RIP1</option>
      <option value="2">RIP2</option>
      <option value="3">Both</option>
     </select>
    </td>
   </tr>
  </table>
  <table>
   <tr>
    <th width=40%><% multilang("410" "LANG_SEND_MODE"); %>:</th>
    <td width=30%>
     <select size="1" name="send_mode">
      <option value="0"><% multilang("327" "LANG_NONE"); %></option>
      <option value="1">RIP1</option>
      <option value="2">RIP2</option>
      <option value="4">RIP1COMPAT</option>
     </select>
    </td>
    <td width=30%><input type="submit" class="inner_btn" value="<% multilang("207" "LANG_ADD"); %>" name="ripAdd"></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("411" "LANG_RIP_CONFIG_TABLE"); %></p><br>
 </div>
 <div class="data_common data_common_notitle data_vertical">
  <table>
    <% showRipIf(); %>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="submit" class="link_bg" value="<% multilang("210" "LANG_DELETE_SELECTED"); %>" name="ripDel" onClick="return deleteClick()">&nbsp;&nbsp;
  <input type="submit" class="link_bg" value="<% multilang("211" "LANG_DELETE_ALL"); %>" name="ripDelAll" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
    </div>
  <input type="hidden" value="/rip.asp" name="submit-url">
 <script>
  <% checkWrite("ripNum"); %>
  </script>
</form>
</blockquote>
</body>
</html>
