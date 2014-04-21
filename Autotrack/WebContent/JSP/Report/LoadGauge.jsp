<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Garudar Bus</title>

<!-- Commen-->
<link rel="stylesheet" href="../../CSS/style.css" type="text/css" />

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	


<script type="text/javascript">
 function search()
 {
	
	
	<%
	String imeinumber = request.getParameter("vehicle_number");
	%>
	
	 
		$(document).ready(function(){
		this.timer = setTimeout(function () {
			
		$('#loading-image').show();
		$('#contents').hide();
		
		$.ajax({
		url: 'fuelgauge.jsp',
		data: 'vehicle_number='+<%=imeinumber%>,
		type: 'POST',
		success: function(msg){ 
			
			var msg = msg.trim();
				alert(msg);		
			$('#contents').html(msg);
			
		},
		complete: function(){
	        $('#loading-image').show();
	        $('#contents').show();
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
 
	
</head>



<body onload="search();">
	<div>

		<!-- Start Content -->
		
		<center>
			<div>
				<img alt="" src="../../images/loading1.gif"> <br> Loading Vehicle Information ..
			</div>
		</center>
		<div id="contents"></div>

	</div>
	<!-- End Content -->

</body>
</html>