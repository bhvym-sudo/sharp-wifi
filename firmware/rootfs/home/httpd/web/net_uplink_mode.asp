<%SendWebHeadStr(); %>
<!--System default template-->
<HTML>
<HEAD>
<TITLE><% multilang("1718" "LANG_TUPSTREAM"); %></TITLE>
<!--System common css-->
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<style>
TABLE{width:320px;}
TR{height:16px;}
SELECT {width:150px;}
</style>
<!--System common script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="base64_code.js"></script>
<SCRIPT language="javascript" type="text/javascript">
<% initUpmode(); %>
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 with ( document.forms[0] )
 {
  submit();
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
 <blockquote>
  <DIV align="left" style="padding-left:20px; padding-top:5px">
   <form id="form" action="/boaform/admin/formUpmode" method="post">
    <div class="intro_main ">
     <p class="intro_title"><% multilang("3658" "LANG_UPLINK_MODE"); %></p><br><br>
     <p class="intro_content"><% multilang("3662" "LANG_UPLINK_MODE_CHANGE_WILL_REBOOT"); %></font></p><br>
    </div>
    <br>
    <div class="data_common data_common_notitle">
    <table id="tbupmode" cellpadding="0px" cellspacing="2px">
     <tr><td><% multilang("3659" "LANG_CURRENT_MODE"); %>: </td> <td><script language="javascript">
     <!--
                        document.writeln(curmode);
                    -->
     </script></td></tr>
     <tr>
      <td><% multilang("3658" "LANG_UPLINK_MODE"); %>: </td> <td><select id="upmode" name="upmode">
       <option value = "1"><% multilang("3660" "LANG_GPON_MODE"); %></option>
       <option value = "2"><% multilang("3661" "LANG_EPON_MODE"); %></option>
      </select>
      </td>
     </tr>
    </table>
    </div>
    <br>
    <div class="btn_ctl">
    <input type="button" class="link_bg" onClick="on_submit();" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>">
    <input type="hidden" name="submit-url" value="/net_uplink_mode.asp">
    </div>
   </form>
  </DIV>
 </blockquote>
</body>
<%addHttpNoCache();%>
</HTML>
