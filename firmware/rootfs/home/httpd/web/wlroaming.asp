<%SendWebHeadStr(); %>
<title>ROAMD</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<style>
tr {height: 16px;}
</style>
<script language="javascript" src="/common.js"></script>
<script language="javascript" type="text/javascript">
var Roamdenable= "<% checkWrite("RoamdEn0"); %>";
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 if(Roamdenable == "checked")
  document.forms[0].RoamdSrvURL.disabled = true;
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 return true;
}
function Srvenable(SrvEn)
{
 if(SrvEn==0)
  document.forms[0].RoamdSrvURL.disabled = true;
 else
  document.forms[0].RoamdSrvURL.disabled = false;
}
</script>
</head>
<!-------------------------------------------------------------------------------------->
<!--Ö÷Ò³´úÂë-->
<body topmargin="0" bgcolor="E0E0E0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init()">
<blockquote>
  <form id="form" action="/boaform/formRoaming" method="post" onsubmit="return on_submit()">
   <div class="intro_main ">
    <p class="intro_title"><% multilang("3714" "LANG_ROAMD_CONFIGURATION"); %></p><br>
    <p class="intro_content"><% multilang("3715" "LANG_ROAMD_CONFIGURATION_PAGE_1"); %></p><br>
   </div>
   <div class="data_common data_common_notitle">
    <table>
    <tr>
     <th width=40%><% multilang("3713" "LANG_ROAMD_ENABLE"); %>:</th>
     <td><input name='RoamdEn' value='1' type='radio' onClick="Srvenable(1)" <% checkWrite("RoamdEn1"); %> ><% multilang("234" "LANG_ENABLE"); %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name='RoamdEn' value='0' type='radio' onClick="Srvenable(0)" <% checkWrite("RoamdEn0"); %> ><% multilang("233" "LANG_DISABLE"); %></td>
    </tr>
    <tr>
     <th width=40%><% multilang("2786" "LANG_DEVICE_MODEL"); %>:</th>
     <td><input type='text' name='RoamdDevModel' size="32" maxlength="64" value="<% getInfo("devModel"); %>" disabled></td>
    </tr>
    <tr>
     <th width=40%><% multilang("3372" "LANG_SERVER_URL"); %>:</th>
     <td><input type='text' name='RoamdSrvURL' size="32" maxlength="256" value="<% getInfo("RoamdSrvURL"); %>"></td>
    </tr>
    </table>
   </div>
    <br>
   <div class="btn_ctl">
    <input type='submit' class="link_bg" onClick="return on_submit('sv')" value='<% multilang("138" "LANG_APPLY_CHANGES"); %>'>
    <input type="hidden" id="action" name="action" value="none">
    <input type="hidden" name="submit-url" value="/wlroaming.asp">
   <div>
  </form>
</blockquote>
</body>
</html>
