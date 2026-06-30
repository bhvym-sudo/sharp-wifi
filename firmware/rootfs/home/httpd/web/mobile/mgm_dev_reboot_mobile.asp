<%SendWebHeadStr("mobile_normal_2"); %>
<title></title>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
 <form id="form" action="/boaform/admin/formReboot" method="post">
 <div id="header">
          <a href="index_mobile.asp" class="button create"><img src="img/icons/blocks.png" width="16" height="16" alt="icon" /></a>
         <div class="clear"></div>
 </div>
<div class="page">
 <div class="simplebox">
   <table class="tabletitle">
    <tr><td><% multilang("511" "LANG_COMMIT_AND_REBOOT"); %></td></tr>
   </table>
   <table class="tabledata">
    <tr>
     <td width="40%"><% multilang("511" "LANG_COMMIT_AND_REBOOT"); %>:</td>
     <td><input class="submit-button" type="submit" value="<% multilang("3215" "LANG_LOOPBACK_TEST_PAGE_BUTTON"); %>"></td>
    </tr>
              </table>
              <input type="hidden" value="/mgm_dev_reboot.asp" name="submit-url">
              <br><br>
            <div class="topbutton"><a href="#"><span>Top</span></a></div>
            <div class="footer"><a href="../index.html" target="_top"><% multilang("3648" "LANG_PC_WEB"); %></a></div>
      <div class="clear"></div>
      </div>
    </div>
<script type="text/javascript" src="js/frame.js"></script>
</body>
<%addHttpNoCache();%>
</html>
