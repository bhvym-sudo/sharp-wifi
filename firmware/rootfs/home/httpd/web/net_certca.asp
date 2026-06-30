<%SendWebHeadStr(); %>
<TITLE>ACS</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--系统公共脚本-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
//var certlist = new Array();	
//certlist.push(new it_devrec("acscert", "C/CN/ST=nanjing/O=127.24.22.1/OU=172.24.22.1", "ca"));
function it_devrec(certName, certSubject, certType)
{
 this.certName = certName;
 this.certSubject = certSubject;
 this.certType = certType;
 this.select = false;
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 //do nothing
}
/********************************************************************
**          on document update
********************************************************************/
/********************************************************************
**          on document submit
********************************************************************/
function importClick()
{
   var loc = 'net_certcaimport.asp';
   var code = 'location=\"' + loc + '\"';
   eval(code);
}
function viewClick(name)
{
   var loc = 'net_showcert.asp';
   var code = 'location=\"' + loc + '\"';
   eval(code);
}
   /*
function removeClick(name, refCount) 
{
   var rem = true;
   var tmplst = "";
   if (certtable.rows.length > 0) 
   {
        if (!confirm('该证书正在使用，删除它将会停止某些正在运行的功能。需要强制删除吗？')) 
        {
            rem = false;
        }
   }
   if (rem) 
   {
			with ( document.forms[0] ) 
			{
				for(var i = 0; i < certlist.length; i++)
				{
						tmplst += certlist[i].certName + "|" + certlist[i].certSubject + "|" + certlist[i].certType;
				}
				lst.value = tmplst;
				alert(tmplst);
				submit();
			}
		}
}*/
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
<form action=/boaform/admin/formTR069CACert method="post" enctype="multipart/form-data" name="ca_cert">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("3382" "LANG_TRUSTED_CA_CERTIFICATE"); %></p><br>
  <p class="intro_content"><% multilang("3383" "LANG_NET_CERTCA_PAGE"); %></p><br>
 </div>
 <center>
 <table>
     <tr>
     <td>
               <input type="file" name="binary" size="20">&nbsp;&nbsp;
               <input type="submit" value="<% multilang("3384" "LANG_CERTIFICATE_IMPORT"); %>" >
     </td>
    </tr>
 </table><br><br>
  <input type="hidden" id="action" name="action" value="none">
<!--
<table id="certtable" border='1' cellpadding='4' cellspacing='0'>
   <tr>
      <td class='hd'>证书类别</td>
      <td class='hd'>颁发机构</td>
      <td class='hd'>类型</td>
      <td class='hd'>作用</td>
   </tr>
</table><br>
<input type='button' name="importcert" onClick='importClick()' value='引入证书'>
<input type="hidden" name="lst" value="">
<input type="hidden" value="/net_certca.asp" name="submit-url">
-->
</center>
</form>
<form action=/boaform/admin/formTR069CACertDel method="post">
<center>
           <table border="0" cellpadding="0" cellspacing="0">
     <tr>
     <td>
               <input type="submit" value="<% multilang("3385" "LANG_DELETE_CERT"); %>" name="delbutton" <% checkWrite("check-certca"); %>>
     </td>
    </tr>
     </table><br>
</center>
</form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
