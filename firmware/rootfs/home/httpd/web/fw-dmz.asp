<%SendWebHeadStr(); %>
<TITLE>DMZ Host</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<script type="text/javascript" src="share.js"></script>
<SCRIPT>
function skip () { this.blur(); }
function saveClick()
{
//  if (!document.formDMZ.enabled.checked)
  if (document.formDMZ.dmzcap[0].checked)
  return true;
  if (document.formDMZ.ip == "")
  {
 alert("<% multilang("1685" "LANG_INVALID_IPV4_ADDR_SHOULD_NOT_EMPTY"); %>");
  document.formDMZ.ip.focus();
 return false;
 }
  if ( validateKey( document.formDMZ.ip.value ) == 0 ) {
 alert("<% multilang("1686" "LANG_INVALID_IPV4_ADDR_SHOULD_BE_DECIMAL_NUM"); %>");
 document.formDMZ.ip.focus();
 return false;
  }
  if( IsLoopBackIP( document.formDMZ.ip.value)==1 ) {
 alert("<% multilang("1687" "LANG_INVALID_IPV4_ADDR"); %>");
 document.formDMZ.ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,1,1,223) ) {
       alert("<% multilang("3566" "LANG_CHECK_IP_ERR_4"); %>");
 document.formDMZ.ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,2,0,255) ) {
       alert("<% multilang("1689" "LANG_INVALID_IPV4_ADDR_2ND_DIGIT"); %>");
 document.formDMZ.ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,3,0,255) ) {
       alert("<% multilang("1690" "LANG_INVALID_IPV4_ADDR_3RD_DIGIT"); %>");
 document.formDMZ.ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,4,1,254) ) {
       alert("<% multilang("1691" "LANG_INVALID_IPV4_ADDR_4TH_DIGIT"); %>");
 document.formDMZ.ip.focus();
 return false;
  }
  //if (!checkHostIP(document.formDMZ.ip, 1))
 //return false;
  return true;
}
function updateState()
{
//  if (document.formDMZ.enabled.checked) {
  if (document.formDMZ.dmzcap[1].checked) {
  enableTextField(document.formDMZ.ip);
  }
  else {
  disableTextField(document.formDMZ.ip);
  }
}
</SCRIPT>
</head>
<body>
<blockquote>
 <form action=/boaform/formDMZ method=POST name="formDMZ">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3268" "LANG_NAT_DMZ_HOST"); %></p><br>
  <p class="intro_content"><% multilang("3271" "LANG_DMZ_CONFIG_PAGE_1"); %></p><br>
  <p class="intro_content"><% multilang("3272" "LANG_DMZ_CONFIG_PAGE_2"); %></p><br>
  <p class="intro_content"><% multilang("3273" "LANG_DMZ_CONFIG_PAGE_3"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("3269" "LANG_DMZ_HOST_TITLE"); %></th>
          <td>
     <input type="radio" value="0" name="dmzcap" <% checkWrite("dmz-cap0"); %> onClick="updateState()"><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;
     <input type="radio" value="1" name="dmzcap" <% checkWrite("dmz-cap1"); %> onClick="updateState()"><% multilang("234" "LANG_ENABLE"); %>&nbsp;&nbsp;
          </td>
   </tr>
   <tr>
    <th width=40%><% multilang("3270" "LANG_DMZ_IP_ADDRESS_TITLE"); %></th>
    <td>&nbsp;<input type="text" name="ip" size="15" maxlength="15" value=<% getInfo("dmzHost"); %> ></td>
   </tr>
  </table>
 </div>
 <div class="btn_ctl">
  <input type="submit" class="link_bg" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>" name="save" onClick="return saveClick()">
         <!--input type="reset" value="Reset" name="reset"-->
          <input type="hidden" value="/fw-dmz.asp" name="submit-url">
         </div>
     <script> updateState(); </script>
 </form>
</blockquote>
</body>
</html>
