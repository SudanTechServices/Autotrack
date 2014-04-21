<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String imeinumber = request.getParameter("vehicle_number");
	String startdate = request.getParameter("course_start_date");
	String enddate = request.getParameter("course_end_date");
	String source = request.getParameter("source_location");
	String destination = request.getParameter("desti_location");
	System.out.println("SOURCE "+source);
	System.out.println("DESTINATION "+destination);
%>
<html>
     <head>
     <title></title>
     <style>
         .loading-indicator {
             font-size:8pt;
             background-image:url(../images/loading.gif);
             background-repeat: no-repeat;
             background-position:top left;
             padding-left:20px;
             height:55px;
             text-align:left;
         }
         #loading{
             position:absolute;
             left:35%;
             top:30%;
             border:3px solid #B2D0F7;
             background:white url(../images/loading/block-bg.gif) repeat-x;
             padding:10px;
             font:bold 14px verdana,tahoma,helvetica;
             color:#003366;
             width:250px;
             text-align:center;
         }
     </style>
 </head>
  <div id="loading">
          <div class="loading-indicator" style="padding-left: 10px;">
             <center><div><img alt="" src="../../images/loading1.gif"> <br><br>
         		Loading Course Taken Report .....</div></center>
         	 </div>
     </div>
     <body onload="location.href = url;" style="overflow:hidden;overflow-y:hidden">
     </body>
     <script>
     var vehno = '<%=imeinumber%>';
     var start = '<%=startdate%>';
     var end = '<%=enddate%>';
     var source = '<%=source%>';
     var destination = '<%=destination%>';
     var url = "New_course_taken_report.jsp?vehicle_number="+vehno+"&start_date="+start+"&end_date="+end+"&source="+source+"&destination="+destination+""; //the Next page you want to display...
     
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