<%SendWebHeadStr(); %>
</head>
<form action=/boaform/admin/formWirelessRtbl method=POST name="formWirelessRtbl">
<div class="column">
 <div class="column_title">
  <div class="column_title_left"></div>
   <p><% multilang("3651" "LANG_MESH_NEI_TABLE"); %></p>
  <div class="column_title_right"></div>
 </div>
 <div class="data_common data_vertical">
  <table>
   <% wlMeshNeighborRTable(); %>
  </table>
 </div>
</div>
</form>
</body>
</html>
