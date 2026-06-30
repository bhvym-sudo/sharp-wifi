<%SendWebHeadStr(); %>
<TITLE>NAT</TITLE>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<script type="text/javascript" src="share.js"></script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
 <form action=/boaform/formNat method=POST name="nat">
 <div class="intro_main ">
  <p class="intro_title"><% multilang("2882" "LANG_NAT_CONFIG")%></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table>
     <tr>
    <th width=20%>NAT:</th>
    <td width=50%>
        <input type="radio" value="1" name="nat_type" <% checkWrite("nat_type_1"); %> >NAT1&nbsp;&nbsp;
        <input type="radio" value="2" name="nat_type" <% checkWrite("nat_type_2"); %> >NAT2&nbsp;&nbsp;
        <input type="radio" value="0" name="nat_type" <% checkWrite("nat_type_0"); %> >NAT4(<% multilang("1032" "LANG_DEFAULT"); %>)&nbsp;&nbsp;
        </td>
     <td width=30%><input type="submit" class="inner_btn" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" name="nat2Set">&nbsp;&nbsp;</td>
   </tr>
  </table>
 </div>
 <br>
  <input type="hidden" value="/nat_conf.asp" name="submit-url">
</form>
</blockquote>
</body>
</html>
