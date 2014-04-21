<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../errorpage.jsp"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Defined Reports</title>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<link href="../../CSS/SyntaxHighlighter.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="../../JS/shCore.js"
	language="javascript"></script>
<script type="text/javascript" src="../../JS/shBrushJScript.js"
	language="javascript"></script>
<script type="text/javascript" src="../../JS/ModalPopups.js"
	language="javascript"></script>
<link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
<script language="javascript" type="text/javascript"
	src="../../JS/datetimepicker_css.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('.box').hide();
		
		$('#dropdown').change(function() {
			$('.box').hide();
			$('#div' + $(this).val()).slideToggle();

		});
	});
</script>
<script type="text/javascript">
	
<%int counter = 0;
			String drivername = null, vehiclenumber = null, busroute = null, standard = null, locations = null;
			DBTransaction dbtranobj = new DBTransaction();
			Connection connection = dbtranobj.connect();
			ResultSet rset = null;
			Statement mystatement = connection.createStatement();%>
	/* function show_UDR_TripSheet() {

		var date = document.tripsheet.date.value;
		if (date == "") {
			alert("select a date");
		} else {
			var chks = document.getElementsByName('t_id');
			var hasChecked = false;
			for ( var i = 0; i < chks.length; i++) {
				if (chks[i].checked) {
					hasChecked = true;
					break;
				}
			}
			if (hasChecked == false) {
				alert("Please select at least one CheckBox.");
				return false;
			}
			document.tripsheet.action = "AJAX_UDR_TripSheet.jsp";
			document.tripsheet.target = "_blank";
			document.tripsheet.submit();
		}
		

	} */
	
	function show_UDR_TripReport() {

		
			document.tripsheet.action = "AJAX_course_taken_report_grid.jsp";
			document.tripsheet.target = "_blank";
			document.tripsheet.submit();
		}
	
	/* function checkAll(field) {
		for (i = 0; i < field.length; i++)
			field[i].checked = true;
	}

	function uncheckAll(field) {
		for (i = 0; i < field.length; i++)
			field[i].checked = false;
	} */
</script>
</head>

<body>
	<div class="content_bg">
		<div class="content_headning">User Defined Report</div>
	</div>
	<div>
	<form name="tripsheet" method="post">
		<table cellpadding="0px;" cellspacing="4px;" class="table_content"
			width="100%"
			style="background-color: #f1fafc; border: 1px solid #2898b4;">
			<tr>
				<td>
					<table cellpadding="2px;" cellspacing="4px;" class="table_content"
						style="width: 46%; background-color: #f1fafc;">
						<tr>
							<td><label>Device Vehicle No</label></td>
							<td></td>
							<td></td>
							<td><label> Select Report Type</label></td>
							<td></td>
							<td></td>
							<td id="start_date_label" colspan="2"><label> Start Date And Time</label></td>
							<td></td>
							<td></td>
							<td><label>Source </label></td>
							<td></td>
							<td></td>
							<td><label>Destination </label></td>

						</tr>
						<tr>
							<td><%@ page import="com.ts.service.dropdown"%>
								<%@ page import="java.util.ArrayList"%> 
								<%@ page import="java.util.*"%> 
								
								<%
								 	String belongs = (String) session.getAttribute("belongs");
								 	dropdown up = new dropdown();
								 	TreeMap hashmap = up.getName(belongs);
								 	Set set = hashmap.entrySet();
								
								 	Iterator iterator = set.iterator();
								
								 	out.println("<select name='vehicle_number' class='tb' style='width: 180px;'>");
								
								 	while (iterator.hasNext()) {
								 		//String temp = iterator.next().toString();
								 		Map.Entry me = (Map.Entry) iterator.next();
								 		out.println("<option class='blue' value=\"" + me.getValue()
								 				+ "\">" + me.getKey() + "</option>");
								 	}
								
								 	out.println("</select>");
								 %>
								</td>
							<td></td>
							<td></td>



							<td><select name="report_type" class="tb" style="width: 180px;">

									<option>Course Taken</option>

							</select></td>
							<td></td>
							<td></td>
							<td id="course_start_date_input"><input class="tb"
								type="Text" id="demo3" size="17" name="course_start_date">
						    </td>
							<td>
								<a href="javascript:NewCssCal('demo3','yyyyMMdd')"><img
									src="../../images/calendar_icon.gif" width="16" height="16"
									border="0" alt="Pick a date"></a>
						   </td>
							<td></td>
							<td></td>

							<td><select name="source_location" class="tb">
									<option class="blue">Adhanur Dam</option>
									
							</select></td>
							<td></td>
							<td></td>

							<td><select name="desti_location" class="tb">
									<option class="blue">Adhanur Dam</option>
								</select></td>

						</tr>

						<tr>
							
							<td colspan="8"><input type="button" name="search" value="Get Report" onclick="show_UDR_TripReport();"></td>
							
						</tr>


					</table>
					
					</div>

				</form>


</body>
</html>