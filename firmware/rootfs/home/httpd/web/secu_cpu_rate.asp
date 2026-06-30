<%SendWebHeadStr("normal_2"); %>
<TITLE>RADVD Configuration Setup</TITLE>
<!--System css-->
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--System script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" type="text/javascript">
function resetClick()
{
 document.crate.reset;
}
function saveChanges()
{
 if (document.crate.cpu_rate.value.length !=0) {
  if ( checkDigit(document.crate.cpu_rate.value) == 0) {
   alert("<% multilang("2695" "LANG_INPUT_INTEGER") %>");
   document.crate.cpu_rate.focus();
   return false;
  }
 }
 var rate_val = parseInt(document.crate.cpu_rate.value, 10);
 if ( rate_val < 8 || rate_val > 1048568 ) {
  alert("<% multilang("2695" "LANG_INPUT_INTEGER") %> 8~1048568");
  document.crate.cpu_rate.focus();
  return false;
 }
 return true;
}
</SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
<DIV align="left" style="padding-left:20px; padding-top:5px">
<form action=/boaform/formCpuRate method=POST name="crate">
<div class="tip" style="width:90% ">
 <b>CPU <% multilang("3685" "LANG_CPU_RATE_SETTING") %></b><br><br>
</div>
       <table cellpadding="0px" cellspacing="2px">
         <tr><td width="150px"><% multilang("3684" "LANG_CPU_RATE") %> (kbps):</td>
             <td><input type=text name=cpu_rate size=15 maxlength=15 value=<% getInfo("cpu_rate"); %>></td>
         </tr>
       </table>
  <br>
      <input type="submit" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;
      <!--input type="reset" value="Undo" name="reset" onClick="resetClick()"-->
      <input type="hidden" value="/secu_cpu_rate.asp" name="submit-url">
 </form>
 </DIV>
</blockquote>
</body>
</html>
