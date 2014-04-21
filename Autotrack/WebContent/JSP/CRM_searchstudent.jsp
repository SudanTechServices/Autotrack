<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.*"%>
    <%@page import="java.util.ArrayList"%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
	<link rel="stylesheet" type="text/css" href="../CSS/style1.css" />
	<script type="text/javascript" src="../JS/jquery-1.4.2.min.js"></script>
	<script src="../JS/jquery.autocomplete.js"></script>
	<script type="text/javascript">
	function check(){
		
		var name = document.getElementById("name").value;
		$(document).ready(function(){
		this.timer = setTimeout(function () {
			
		$('#loading-image').show();
		$('#content').hide();
		
		$.ajax({
		url: 'CRM_studentsearch.jsp',
		data: 'student='+name,
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
	
	</script>

</head>
<body onload="refresh();">
<div class="content_bg"><div class="content_headning">Student Transport Form</div></div>
<form name="search_form" method="post">

<table cellpadding="2px;" cellspacing="4px;" class="table_content" style="width: 100%; background-color: #f1fafc;border: 1px solid #2898b4;">
	<tr>
<td>
<table cellpadding="2px;" cellspacing="4px;" class="table_content" style="width: 50%; background-color: #f1fafc;">
		<tr>
			<td><b>Search Student</b><br/> (Name/Enrollment no./Location)</td>
			<td valign="top">:</td>
			<td></td>
			<td valign="top"><input type="text" id="name" name="student" class="input_text" size="30"/></td>
			<td valign="top"><input type="button" id="button" name="search" value="Search"  onclick="check()"></td>
		</tr>
		</table>
		</td>
		</tr>
	</table>	

	
	</form>


<center>
		<div id="loading-image"><img alt="" src="../images/loading1.gif"> <br> Loading The Student's Record .. </div>
</center>
		<div id="content"></div>

</body>
<script>
	jQuery(function(){
		$("#name").autocomplete("CRM_autocomplete.jsp");
	});
</script>
</html>