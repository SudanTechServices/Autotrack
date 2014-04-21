<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String vehicle_number = request.getParameter("vehicle_number");
    String[] select = request.getParameterValues("d_id"); 	
    session.setAttribute("id", select);
    String driver_name = request.getParameter("driver_name");
	
    %>
 
<html>
     <head>
          
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
         		Loading Report .....</div></center>
         	 </div>
     </div>
     <body onload="location.href = url;" style="overflow:hidden;overflow-y:hidden">
     </body>
     <script>
     var vehicle_number = '<%=vehicle_number%>';
     var driver_name = '<%=driver_name%>';
     
          
    // var url = 'coursetakenmarker.jsp?vehicle_number='+imeinumber+'&start_date='+startdate+'&end_date='+enddate+''; //the Next page you want to display... 
     
    var url = "UDR_Driver.jsp?vehicle_number="+vehicle_number+"&driver_name="+driver_name+"";  //the Next page you want to display...
     
    //newwindow=window.open(url,'height=400,width=800');
    
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