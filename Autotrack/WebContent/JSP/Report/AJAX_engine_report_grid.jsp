<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String imeinumber = request.getParameter("vehicle_number");
	String startdate = request.getParameter("start_date");
	String enddate = request.getParameter("end_date"); 
%>
<html>
     <head>
     <title></title>
      
 </head>
  <div id="loading">
          <div class="loading-indicator" style="padding-left: 10px;">
             <center><div><img alt="" src="../../images/loading1.gif"> <br><br>
         		Loading Engine Report .....</div></center>
         	 </div>
     </div>
     <body onload="location.href = url;" style="overflow:hidden;overflow-y:hidden">
     </body>
     <script>
     var vehno = '<%=imeinumber%>';
     var start = '<%=startdate%>';
     var end = '<%=enddate%>';
     
     var url = "engine_report_grid.jsp?vehicle_number="+vehno+"&start_date="+start+"&end_date="+end+""; //the Next page you want to display...
     
        if(document.layers) {
             document.write('<Layer src="' + url + '" visibility="hide"></Layer>');
         }
        else if(document.all || document.getElementById) {
             document.write('<iframe src="' + url + '" style="visibility:hidden;"></iframe>');
         }
        else {
             location.href = url;
         }
     </script>
</html>