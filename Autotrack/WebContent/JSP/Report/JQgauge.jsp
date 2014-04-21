<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script type="text/javascript">
 function load()
 {
	 
	 
		$(document).ready(function(){
		this.timer = setTimeout(function () {
			
		$('#loading-image').show();
		$('#content').hide();
		
		$.ajax({
		url: 'JQfuelgauge.jsp',
		data: 'Source='+source+"&Destination="+destination+"&date="+date,
		type: 'POST',
		success: function(msg){ 
			
			var msg = msg.trim();
						
			$("#content").html(msg);
			
		},
		complete: function(){
	        $('#loading-image').hide();
	        $('#content').show();
	      }
			}); },200);

		return true;
		});
}
	function refresh(){
		$('#loading-image').hide();
		
	}
	/*  document.Path.action="../JSP/VechileInformation.jsp";
	 document.Path.submit(); */
 
 </script>
<body onload="load();">
<%

%>
<center>
			<div id="loading-image">
				<img alt="" src="../images/loading1.gif"> <br> Loading Vehicle Information ..
			</div>
		</center>
		<div id="content"></div>
</body>
</html>