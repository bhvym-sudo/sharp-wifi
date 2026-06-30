<%SendWebHeadStr(); %>
<TITLE>DDNS</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT>
var links = new Array();
with(links){<% listWanif("rt"); %>}
/********************************************************************
**          on document load
********************************************************************/
function ddnsChange()
{
 with(form)
 {
  switch(provider.value)
  {
   case "oray":
   document.getElementById("orayInfo").style.display = "block";
   document.getElementById("dyndnsInfo").style.display = "none";
   document.getElementById("tzoInfo").style.display = "none";
   document.getElementById("noipInfo").style.display = "none";
   document.getElementById("gnudipInfo").style.display = "none";
   break;
   case "dyndns":
   document.getElementById("orayInfo").style.display = "none";
   document.getElementById("dyndnsInfo").style.display = "block";
   document.getElementById("tzoInfo").style.display = "none";
   document.getElementById("noipInfo").style.display = "none";
   document.getElementById("gnudipInfo").style.display = "none";
   break;
   case "tzo":
   document.getElementById("orayInfo").style.display = "none";
   document.getElementById("dyndnsInfo").style.display = "none";
   document.getElementById("tzoInfo").style.display = "block";
   document.getElementById("noipInfo").style.display = "none";
   document.getElementById("gnudipInfo").style.display = "none";
   break;
   case "noip":
   document.getElementById("orayInfo").style.display = "none";
   document.getElementById("dyndnsInfo").style.display = "none";
   document.getElementById("tzoInfo").style.display = "none";
   document.getElementById("noipInfo").style.display = "block";
   document.getElementById("gnudipInfo").style.display = "none";
   break;
   case "gnudip":
   document.getElementById("orayInfo").style.display = "none";
   document.getElementById("dyndnsInfo").style.display = "none";
   document.getElementById("tzoInfo").style.display = "none";
   document.getElementById("noipInfo").style.display = "none";
   document.getElementById("gnudipInfo").style.display = "block";
   break;
  }
 }
}
function on_init()
{
 with ( document.forms[0] )
 {
  for(var i = 0; i < links.length; i++)
  {
   ifname.options.add(new Option(links[i].name, links[i].ifIndex));
  }
 }
 ddnsChange();
}
function btnApply()
{
 if(!sji_checkhostname(form.hostname.value, 1, 32))
 {
  alert("<% multilang("3491" "LANG_ADD_DDNS_ERR_1"); %>!");
  return false;
 }
 var ddns = form.provider.value;
 if(ddns == "oray")
 {
  if(!sji_checkusername(form.orayusername.value, 0, 32))
  {
   alert("<% multilang("3492" "LANG_ADD_DDNS_ERR_2"); %>!");
   return false;
  }
  if(!sji_checkpswnor(form.oraypassword.value, 0, 32))
  {
   alert("<% multilang("3493" "LANG_ADD_DDNS_ERR_3"); %>!");
   return false;
  }
 }
 else if(ddns == "dyndns")
 {
  if(!sji_checkusername(form.dynusername.value, 0, 32))
  {
   alert("<% multilang("3492" "LANG_ADD_DDNS_ERR_2"); %>!");
   return false;
  }
  if(!sji_checkpswnor(form.dynpassword.value, 0, 32))
  {
   alert("<% multilang("3493" "LANG_ADD_DDNS_ERR_3"); %>!");
   return false;
  }
 }
 else if(ddns == "tzo")
 {
  if(!sji_checkusername(form.tzoemail.value, 0, 64))
  {
   alert("<% multilang("2059" "LANG_INVALID_EMAIL"); %>!");
   return false;
  }
  if(!sji_checkpswnor(form.tzokey.value, 0, 32))
  {
   alert("<% multilang("2061" "LANG_INVALID_KEY"); %>!");
   return false;
  }
 }
 else if(ddns == "noip")
 {
  if(!sji_checkusername(form.noipusername.value, 0, 35))
  {
   alert("<% multilang("3492" "LANG_ADD_DDNS_ERR_2"); %>!");
   return false;
  }
  if(!sji_checkpswnor(form.noippassword.value, 0, 35))
  {
   alert("<% multilang("3493" "LANG_ADD_DDNS_ERR_3"); %>!");
   return false;
  }
 }
 else
 {
  if(!sji_checkusername(form.gnudipusername.value, 0, 32))
  {
   alert("<% multilang("3492" "LANG_ADD_DDNS_ERR_2"); %>!");
   return false;
  }
  if(!sji_checkpswnor(form.gnudippassword.value, 0, 32))
  {
   alert("<% multilang("3493" "LANG_ADD_DDNS_ERR_3"); %>!");
   return false;
  }
 }
 form.submit();
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Main code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action=/boaform/admin/formDDNS method=POST>
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3485" "LANG_ADD_DYNAMIC_DNS"); %></p><br>
  <p class="intro_content"><% multilang("3486" "LANG_ADD_DYNAMIC_DNS_PAGE_1"); %></p>
 </div>
 <div class="data_common data_common_notitle">
  <table>
   <tr>
    <th width=40%><% multilang("3487" "LANG_DDNS_PROVIDER"); %>:</th>
    <td>
     <select name="provider" size="1" onChange="ddnsChange()" style="width:200px ">
      <option value="oray"><% multilang("3488" "LANG_ORAY_COM"); %></option>
      <option value="dyndns">DynDNS.org</option>
      <option value="tzo">TZO</option>
      <option value="noip">No-IP</option>
      <option value="gnudip">GnuDIP</option>
     </select>
    </td>
   </tr>
  </table>
  <table>
   <tr>
    <th width=40%><% multilang("355" "LANG_HOSTNAME"); %>:</th>
    <td><input type="text" name="hostname" style="width:200px "></td>
   </tr>
   <tr>
    <th width=40%><% multilang("68" "LANG_INTERFACE"); %>:</th>
    <td>
     <select name="ifname" style="width:200px ">
      <option value="LAN">LAN/br0</option>
     </select>
    </td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id="orayInfo">
  <table>
   <tr>
    <th width=40%><% multilang("1123" "LANG_USERNAME"); %>:</th>
    <td><input type="text" name="orayusername" size="20" maxlen="64" style="width:200px "></td>
   </tr>
   <tr>
    <th width=40%><% multilang("65" "LANG_PASSWORD"); %>:</th>
    <td><input type="password" name="oraypassword" style="width:200px "></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id="dyndnsInfo">
  <table>
   <tr>
    <th width=40%><% multilang("1123" "LANG_USERNAME"); %>:</th>
    <td><input type="text" name="dynusername" size="20" maxlen="64" style="width:200px "></td>
   </tr>
   <tr>
    <th width=40%><% multilang("65" "LANG_PASSWORD"); %>:</th>
    <td><input type="password" name="dynpassword" style="width:200px "></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id="tzoInfo">
  <table>
   <tr>
    <th width=40%><% multilang("357" "LANG_EMAIL"); %>:</th>
    <td><input type="text" name="tzoemail" size="20" maxlen="64" style="width:200px "></td>
   </tr>
   <tr>
    <th width=40%><% multilang("229" "LANG_KEY"); %>:</th>
    <td><input type="password" name="tzokey" style="width:200px "></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id="noipInfo">
  <table>
   <tr>
    <th width=40%><% multilang("1123" "LANG_USERNAME"); %>:</th>
    <td><input type="text" name="noipusername" size="20" maxlen="64" style="width:200px "></td>
   </tr>
   <tr>
    <th width=40%><% multilang("65" "LANG_PASSWORD"); %>:</th>
    <td><input type="password" name="noippassword" style="width:200px "></td>
   </tr>
  </table>
 </div>
 <div class="data_common data_common_notitle" id="gnudipInfo">
  <table>
   <tr>
    <th width=40%><% multilang("1123" "LANG_USERNAME"); %>:</th>
    <td><input type="text" name="gnudipusername" size="20" maxlen="64" style="width:200px "></td>
   </tr>
   <tr>
    <th width=40%><% multilang("65" "LANG_PASSWORD"); %>:</th>
    <td><input type="password" name="gnudippassword" style="width:200px "></td>
   </tr>
  </table>
 </div>
 <br>
 <div class="btn_ctl">
  <input type="button" class="link_bg" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>" onClick="btnApply()">
  <input type="hidden" id="action" name="action" value="ad">
  <input type="hidden" value="/app_ddns_show.asp" name="submit-url">
 </div>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
