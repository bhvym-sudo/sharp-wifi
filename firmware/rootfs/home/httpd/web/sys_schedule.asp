<% SendWebHeadStr();%>
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
var cgi = new Object();
<% initPageSysSchedule(); %>
function setValue(id,value)
{
 document.getElementById(id).value=value;
}
function btnApply()
{
 var week = 0;
 if(document.getElementById("mon").checked)
  week += 0x2;
 if(document.getElementById("tue").checked)
  week += 0x4;
 if(document.getElementById("wen").checked)
  week += 0x8;
 if(document.getElementById("thr").checked)
  week += 0x10;
 if(document.getElementById("fri").checked)
  week += 0x20;
 if(document.getElementById("sat").checked)
  week += 0x40;
 if(document.getElementById("sun").checked)
  week += 0x80;
 setValue("day", week);
 document.form.action.value="set";
 form.submit();
}
function on_init()
{
 var i=0;
 for(i=0; i<24; i++)
  document.form.hour.options.add(new Option(i, i));
 document.getElementById("hour").options[_hour].selected = true;
 for(i=0; i<60; i++)
  document.form.minute.options.add(new Option(i, i));
 document.getElementById("minute").options[_minute].selected = true;
 if((_day & 0x2) != 0){
  document.getElementById("mon").checked = true;
 }
 if((_day & 0x4) != 0){
  document.getElementById("tue").checked = true;
 }
 if((_day & 0x8) != 0){
  document.getElementById("wen").checked = true;
 }
 if((_day & 0x10) != 0){
  document.getElementById("thr").checked = true;
 }
 if((_day & 0x20) != 0){
  document.getElementById("fri").checked = true;
 }
 if((_day & 0x40) != 0){
  document.getElementById("sat").checked = true;
 }
 if((_day & 0x80) != 0){
  document.getElementById("sun").checked = true;
 }
}
/*

function timeDisplay()

{

	var selc = document.getElementById("day");

	var index = selc.selectedIndex;



	if( selc.options[index].value==0 )

	{

		document.getElementById("hour").disabled=true;

		document.getElementById("minute").disabled=true;

	}

	else

	{

		document.getElementById("hour").disabled=false;

		document.getElementById("minute").disabled=false;

	}

}

*/
function checkboxOnclick(checkbox)
{
 if ( checkbox.checked == true)
 {
  document.getElementById("mon").checked=false;
  document.getElementById("mon").disabled=true;
  document.getElementById("tue").checked=false;
  document.getElementById("tue").disabled=true;
  document.getElementById("wen").checked=false;
  document.getElementById("wen").disabled=true;
  document.getElementById("thr").checked=false;
  document.getElementById("thr").disabled=true;
  document.getElementById("fri").checked=false;
  document.getElementById("fri").disabled=true;
  document.getElementById("sat").checked=false;
  document.getElementById("sat").disabled=true;
  document.getElementById("sun").checked=false;
  document.getElementById("sun").disabled=true;
  document.getElementById("hour").disabled=true;
  document.getElementById("minute").disabled=true;
 }
 else
 {
  document.getElementById("mon").disabled=false;
  document.getElementById("tue").disabled=false;
  document.getElementById("wen").disabled=false;
  document.getElementById("thr").disabled=false;
  document.getElementById("fri").disabled=false;
  document.getElementById("sat").disabled=false;
  document.getElementById("sun").disabled=false;
  document.getElementById("hour").disabled=false;
  document.getElementById("minute").disabled=false;
 }
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init()">
  <form id="form" action=/boaform/admin/formSysSchedule method=POST name="form">
  <div class="intro_main ">
   <p class="intro_title"><% multilang("3631" "LANG_SYS_SCH_DESC"); %></p>
   <p class="intro_content"><% multilang("3644" "LANG_ONLY_SYNCHRONIZED_CAN_EFFECT"); %></p><br>
  </div>
   <hr align="left" class="sep" size="1" width="90%">
   <div class="data_common data_common_notitle">
    <table>
    <tr>
     <th width=120><% multilang("537" "LANG_CURRENT_TIME"); %>:</th>
     <td><% getInfo("date"); %></td>&nbsp;
     <td><% getInfo("datestatus"); %></td>
    </tr>
    </table>
    <table>
    <tr>
     <th width="120"><% multilang("3632" "LANG_SYS_SCH_DAY"); %>:&nbsp;</th>
     <td>
      <input type="checkbox" id="mon" name="mon" value="1" /><% multilang("3636" "LANG_SYS_SCH_MON"); %>
      <input type="checkbox" id="tue" name="tue" value="2" /><% multilang("3637" "LANG_SYS_SCH_TUE"); %>
      <input type="checkbox" id="wen" name="wen" value="3" /><% multilang("3638" "LANG_SYS_SCH_WEN"); %>
      <input type="checkbox" id="thr" name="thr" value="4" /><% multilang("3639" "LANG_SYS_SCH_THR"); %>
      <input type="checkbox" id="fri" name="fri" value="5" /><% multilang("3640" "LANG_SYS_SCH_FRI"); %>
      <input type="checkbox" id="sat" name="sat" value="6" /><% multilang("3641" "LANG_SYS_SCH_SAT"); %>
      <input type="checkbox" id="sun" name="sun" value="7" /><% multilang("3642" "LANG_SYS_SCH_SUN"); %>
     </td>
     <td>&nbsp;</td>
    </tr>
    </table>
   </div>
   <div class="data_common data_common_notitle">
   <table>
    <tr>
     <th width="120"><% multilang("3633" "LANG_SYS_SCH_TIME"); %>:&nbsp;
     </th>
     <td>
     <select id="hour" name="hour">
     </select>
     &nbsp;<% multilang("3634" "LANG_SYS_SCH_HOUR"); %>&nbsp;
     <select id="minute" name="minute">
     </select>
     &nbsp;<% multilang("3635" "LANG_SYS_SCH_MINUTE"); %>&nbsp;
     </td>
    </tr>
   </table>
   </div>
   <br>
  <div class="btn_ctl">
   <input type="button" class="button" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick="btnApply()">
   <input type="hidden" name="action" value="set">
   <input type="hidden" name="submit-url" value="/sys_schedule.asp">
   <input type="hidden" name="day" id="day" value="">
  </div>
  </form>
</body>
<%addHttpNoCache();%></html>
