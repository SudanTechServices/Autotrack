<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String IMEI=request.getParameter("IMEI");
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
             <center><div><img alt="" src="../images/loading1.gif"> <br><br>
         		Tracking Your Vehicle .....</div></center>
         	 </div>
     </div>
     <body onload="location.href = url;" style="overflow:hidden;overflow-y:hidden">
     </body>
     <script>
     var IMEI = '<%=IMEI%>';
     var url = "dashboardlivetracking.jsp?IMEI="+IMEI+""; //the Next page you want to display...
     
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