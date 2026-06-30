<%SendWebHeadStr(); %>
<html>
<head>
<title>QoS Add</title>
<style type=text/css>
@import url(/style/default.css);
</style>
<script language="javascript" src="common.js"></script>
<script language="javascript" type="text/javascript">
var policy = 1;
var rules = new Array();
var queues = new Array();
<% initQueuePolicy(); %>
function queue_display() {
 var hrow=lstrc.rows[0];
 var hcell=hrow.cells[1];
 if (document.forms[0].queuepolicy[0].checked)
  hcell.innerHTML = "<% multilang("654" "LANG_PRIO"); %>";
 else
  hcell.innerHTML = "<% multilang("655" "LANG_WRR"); %>";
 if(lstrc.rows){while(lstrc.rows.length > 1) lstrc.deleteRow(1);}
 for(var i = 0; i < queues.length; i++) {
  var row = lstrc.insertRow(i + 1);
  row.nowrap = true;
  row.vAlign = "center";
  row.align = "center";
  var cell = row.insertCell(0);
  cell.innerHTML = queues[i].qname;
  cell = row.insertCell(1);
  if (document.forms[0].queuepolicy[0].checked)
   cell.innerHTML = queues[i].prio;
  else
   cell.innerHTML = "<input type=\"text\" name=w" + i + " value=" + queues[i].weight + " size=3>";
  cell = row.insertCell(2);
  qcheck= queues[i].enable? " checked":"";
  cell.innerHTML = "<input type=\"checkbox\" name=qen" + i + qcheck + ">";
 }
}
function on_init(){
 with(document.forms[0]){
  if(policy != 0 && policy !=1)
   policy = 0;
  queuepolicy[policy].checked = true;
  qosen[qosEnable].checked = true;
  qosPly.style.display = qosEnable==0 ? "none":"block";
 }
 queue_display();
}
function on_save() {
 with(document.forms[0]) {
  var sbmtstr = "";
  if(queuepolicy[0].checked==true)
   sbmtstr = "policy=0";
  else{ //WRR²ßÂÔ
   sbmtstr = "policy=1";
   var weight=0;
   if(qen0.checked)
    weight+=parseInt(w0.value);
   if(qen1.checked)
    weight+=parseInt(w1.value);
   if(qen2.checked)
    weight+=parseInt(w2.value);
   if(qen3.checked)
    weight+=parseInt(w3.value);
   if(weight!=100){
    alert("<% multilang("3044" "LANG_TOTAL_WRR_LIMIT"); %>");
    return false;
   }
  }
  lst.value = sbmtstr;
  submit();
 }
}
function qosen_click() {
 document.all.qosPly.style.display = document.all.qosen[0].checked ? "none":"block";
}
function qpolicy_click() {
 queue_display();
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
 <form id="form" action="/boaform/admin/formQosPolicy" method="post">
 <div class="intro_main ">
  <p class="intro_title">QoS <% multilang("224" "LANG_CONFIGURATION"); %></p><br>
 </div>
 <div class="data_common data_common_notitle">
  <table width="400">
   <tr>
      <th width=40%><% multilang("1250" "LANG_IP_QOS"); %>:</th>
    <td><input type="radio" name=qosen value=0 onClick=qosen_click();><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;<input type="radio" name=qosen value=1 onClick=qosen_click();><% multilang("234" "LANG_ENABLE"); %></td>
   </tr>
  </table>
 </div>
 <div id="qosPly" style="display:none">
  <div class="data_common data_common_notitle" >
   <table>
      <tr>
     <th width=40%><% multilang("3040" "LANG_RULE_TEMPLATE"); %>:</th>
     <td><% checkWrite("qos_mode"); %></td>
    </tr>
     <tr>
     <th width=40%><% multilang("660" "LANG_TOTAL_BANDWIDTH_LIMIT"); %>:</th>
     <td><input type="radio" name="enable_force_weight" value=0 <% checkWrite("enable_force_weight0"); %>><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;
         <input type="radio" name="enable_force_weight" value=1 <% checkWrite("enable_force_weight1"); %>><% multilang("234" "LANG_ENABLE"); %>&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
       <th width=40%>DSCP/TC <% multilang("3041" "LANG_REMARK_ENABLE"); %></th>
           <td>
      <input type="radio" name="enable_dscp_remark" value=0 <% checkWrite("enable_dscp_remark0"); %>><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" name="enable_dscp_remark" value=1 <% checkWrite("enable_dscp_remark1"); %>><% multilang("234" "LANG_ENABLE"); %>&nbsp;&nbsp;
         </td>
    </tr>
    <tr>
      <th width=40%>802.1p <% multilang("3042" "LANG_REMARK_MODE"); %></th>
     <td>
      <input type="radio" name="enable_1p_remark" value=0 <% checkWrite("enable_1p_remark0"); %>><% multilang("233" "LANG_DISABLE"); %>&nbsp;&nbsp;
         <input type="radio" name="enable_1p_remark" value=1 <% checkWrite("enable_1p_remark1"); %>><% multilang("1071" "LANG_TRANSPARENT_MODE"); %>&nbsp;&nbsp;
         <input type="radio" name="enable_1p_remark" value=2 <% checkWrite("enable_1p_remark2"); %>><% multilang("3043" "LANG_OVER_WRITE"); %>&nbsp;&nbsp;
     </td>
    </tr>
   </table>
  </div>
  <br>
  <div class="intro_main ">
   <p class="intro_title"><% multilang("652" "LANG_QUEUE_CONFIG"); %></p><br>
   <p class="intro_content"><% multilang("653" "LANG_PAGE_DESC_CONFIGURE_QOS_POLICY"); %></p><br>
  </div>
  <div class="data_common data_common_notitle" >
   <table>
    <tr>
       <th width=40%><% multilang("625" "LANG_POLICY"); %>:</th>
     <td><input type="radio" name="queuepolicy" value="prio" onClick=qpolicy_click();><% multilang("654" "LANG_PRIO"); %>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="queuepolicy" value="wrr" onClick=qpolicy_click();><% multilang("655" "LANG_WRR"); %></td>
    </tr>
     </table>
    </div>
    <br>
    <div class="data_common data_common_notitle data_vertical">
     <table id="lstrc">
    <tr align="center">
     <th><% multilang("656" "LANG_QUEUE"); %></th>
     <th><% multilang("657" "LANG_PRIORITY"); %></th>
     <th><% multilang("234" "LANG_ENABLE"); %></th>
    </tr>
     </table>
  </div>
 </div>
 <br><br>
 <div class="btn_ctl">
    <input type="button" class="link_bg" value="<% multilang("138" "LANG_APPLY_CHANGES"); %>" onClick="on_save();">
    <input type="hidden" id="lst" name="lst" value="">
    <input type="hidden" name="submit-url" value="/net_qos_imq_policy.asp">
 </div>
 <br>
 </form>
</blockquote>
</body>
<%addHttpNoCache();%>
</html>
