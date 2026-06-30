<%SendWebHeadStr(); %>
<TITLE><% multilang("3551" "LANG_STD_DEVICE_TITLE"); %></TITLE>
<!--System common css-->
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--System common script-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
/********************************************************************
var timeout = 300000;
var timeoutTimer;

timeoutTimer = setTimeout(timeoutFunc, timeout);

function timeoutFunc()
{
	document.forms[0].submit();
}

function resetTimeoutFunc()
{
	clearTimeout(timeoutTimer);
	timeoutTimer = setTimeout(timeoutFunc, timeout);
}
********************************************************************/
/********************************************************************
**          menu class
********************************************************************/
function menu(name)
{
 this.name = name;
 this.names = new Array();
 this.objs = new Array();
 this.destroy = function(){delete map;map = null;}
 this.add = function(obj, name){var i = this.names.length; if(name){this.names[i] = name;}else{this.names[i] = obj.name;} this.objs[i] = obj;}
 return this;
}
var mnroot = new menu("root");
<% createMenuEx(); %>
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
<% createCheckpask(); %>
 if(paskdiff == 1)
 {
  window.top.location.href = "/admin/login.asp";
 }
 var fst = null;
 if(!topmenu) topmenu = document.getElementById("topmenu");
 if(!submenu) submenu = document.getElementById("submenu");
 if(topmenu.cells){while(topmenu.cells.length > 0) topmenu.deleteCell(0);}
 for(var i = 0; i < mnroot.names.length; i++)
 {
  var cell = topmenu.insertCell(i);
        var txt = "<p align=\"center\"><b><font size=\"2\" >";
  txt += "<a href=\"#\" onClick=\"on_catolog(" + i + ");\">";
  txt += "<span style=\"font-size:14pt\">" + mnroot.names[i] + "</span></a></font></b></p>";
  cell.bgColor = "#d1d2d4";
  cell.width = "15%";
  cell.innerHTML = txt;
  cell.mnobj = mnroot.objs[i];
  if(fst == null)fst = i;
 }
 topmenu.sel = 0;
 topmenu.cells[0].bgColor = "#F5F5F5";
 menuname.innerHTML = mnroot.names[0];
 on_catolog(fst);
}
/********************************************************************
**          on catolog changed
********************************************************************/
function on_catolog(index)
{
 var fst = null;
 if(!topmenu.cells || index >= topmenu.cells.length)return;
 if(topmenu.sel != index)
 {
  topmenu.cells[topmenu.sel].bgColor = "#D1D2D4";
  topmenu.cells[index].bgColor = "#F5F5F5";
  topmenu.sel = index;
  menuname.innerHTML = mnroot.names[index];
 }
 var mnobj = topmenu.cells[index].mnobj;
 if(submenu.cells){while(submenu.cells.length > 1) submenu.deleteCell(1);}
 for(var i = 0; i < mnobj.names.length; i++)
 {
  var cell = submenu.insertCell(i * 2 + 1);
  cell.width = "12px";
  //cell.innerHTML = "|";
  var index = i * 2 + 2;
  cell = submenu.insertCell(index);
  var txt = "<b><p align=\"center\">&nbsp;&nbsp;";
        txt += "<a href=\"#\" onClick=\"on_menu(" + index + ");\">";
        txt += "<span style=\"font-size:12pt; color:#1874CD\">" + mnobj.names[i] + "</a>&nbsp;&nbsp;</p></b>";
  //cell.width = "75px";
  cell.innerHTML = txt;
  cell.nowrap = true;
  cell.name = mnobj.names[i];
  cell.mnobj = mnobj.objs[i];
  if(fst == null)fst = index;
 }
 on_menu(fst);
}
/********************************************************************
**          on menu fire
********************************************************************/
function on_menu(index)
{
 if(!submenu.cells || index >= submenu.cells.length)return;
 tbobj = submenu.cells[index];
 var mnobj = tbobj.mnobj;
 var lstmenu = top.leftFrame.lstmenu;
 if(!lstmenu) lstmenu = top.leftFrame.document.getElementById("lstmenu");
 if(!lstmenu)return;
 if(lstmenu.rows){while(lstmenu.rows.length > 0) lstmenu.deleteRow(0);}
 for(var i = 0; i < mnobj.names.length; i++)
 {
  var row = lstmenu.insertRow(i);
  row.nowrap = true;
  row.vAlign = "top";
  row.align = "right";
  var cell = row.insertCell(0);
  cell.width = "100%";
  cell.innerHTML = "<br><b><p><a href=\"" + mnobj.objs[i] + "\", target=\"mainFrame\">" + "<span style=\"font-size:12pt; color:#1874CD\">" + mnobj.names[i] + "</span></a>&nbsp;&nbsp;</p></b>";
  cell.nowrap = true;
  cell.name = mnobj.names[i];
  cell.mnobj = mnobj.objs[i];
 }
 top.mainFrame.location.href=mnobj.objs[0];
}
</SCRIPT>
</HEAD>
<!-------------------------------------------------------------------------------------->
<!--Home Code-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" height="115" width="100%" onLoad="on_init();">
<form action=/boaform/admin/formLogout method=POST name="top" target="_top">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="60">
  <tr>
   <td width="100%" rowspan="2"> <IMG height="55" src="image/background_top.gif" border=0> </td>
  </tr>
  <tr>
    <td width="100%" align="center" valign="bottom">
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="5" bgcolor="#FFFFFF">
  <td bgcolor="#FFFFFF" width="100%" align="right" valign="bottom" height="5" <font color="blue"><input type="submit" value="<% multilang("62" "LANG_LOGOUT"); %>"></font>&nbsp;&nbsp;</td>
  </table>
 </td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="60">
  <tr nowrap>
    <td align="center" valign="middle" width="150" rowspan="3" bgcolor="#d1d2d4" style="font-size:16pt" nowrap>&nbsp;<b><font color="#666"><label id="menuname"><% multilang("3" "LANG_STATUS"); %></label></font></b>&nbsp;</td>
  </tr>
  <tr>
    <td align="center" valign="middle" height="35">
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="35" bgcolor="#d1d2d4">
   <tr id="topmenu" nowrap>
     <td width="15%">¡¡</td>
   </tr>
  </table>
 </td>
  </tr>
  <tr>
    <td align="left" height="25" bgcolor="#F5F5F5">
   <table border="0" cellpadding="3" cellspacing="3" height="25" bgcolor="F5F5F5">
        <tr id="submenu" style="font-size:12pt; color:#4040FF" nowrap>
    <td width="0"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
</body>
<!--%addHttpNoCache();%-->
</html>
