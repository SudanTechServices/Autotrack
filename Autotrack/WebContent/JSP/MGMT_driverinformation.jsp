<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp"%>
<%@ page import="com.ts.service.dropdown"%>
<%@ page import="com.ts.service.ShiftNumberDropdown"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*"%>
<%@page import="java.lang.*"%>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

<title>Autotrack</title>
<script type="text/javascript" src="../JS/validate.js"></script>
<script type="text/javascript">
	function driver_info() {
		
		

			document.DriverInfo.action = "/Autotrack/ControllerServlet/DriverInfoService";
			document.DriverInfo.submit();
			alert('Driver Information Saved Successfully !');
		

	}

	function driver_info_update() {

		document.DriverInfo.action = "../JSP/MGMT_driverinfo_search.jsp";
		document.DriverInfo.submit();

	}

	/* function diver_info_delete()
	{
	
		document.DriverInfo.action="../JSP/DriverInfo_Update.jsp";
		document.DriverInfo.submit();
		
	}
	 */
</script>
</head>
<%
	String message = request.getParameter("message");
	if (message == null) {
		message = "";
	} else if (message.equalsIgnoreCase("success")) {
		message = "Driver Information Successfully Inserted !!!";
	} else if (message.equalsIgnoreCase("updated")) {
		message = "Driver Information Successfully Updated !!!";
	} else if (message.equalsIgnoreCase("deleted")) {
		message = "Driver Information Successfully deleted !!!";
	}
%>
<body>
	<div class="content_bg">
		<span class="content_headning">Driver Information</span>
	</div>

	<div style="color: red; font-size: 15px; padding-left: 15px;"><%=message%></div>

	<form method="post" name="DriverInfo">
		<table cellpadding="4" cellspacing="0" class="table_content" style="width: 100%; background-color: #f8f8f8; border: 1px solid #dfdddb;">
<tr>
<td>
<form method="post" name="CustomerInfo">
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 55%; background-color: #f8f8f8;">
						<tr>
							<td>Name</td>
							<td>:</td>
							<td><input type="text" name="driver_name"
								size="25" /></td>
						</tr>
						<tr>						
							<td>Gender</td>
							<td>:</td>
							<td><input type="radio" name="gender" value="male" />Male <input
								type="radio" name="gender" value="female" />Female</td>
						</tr>
						<tr>
							<td>Contact Number</td>
							<td>:</td>
							<td><input  type="text" name="contact_no"
								size="25" /></td>
						</tr>
						<tr>
							<td valign="top">Address</td>
							<td valign="top">:</td>
							<td><textarea name="address" rows="3" cols="25" 
									style="resize: none; width: 180px;"></textarea>
							</td>
						</tr>
						<tr>
							<td>Date Of Birth</td>
							<td>:</td>
							<td><select id="dropdown" name="dob_dropdown_month">
									<option>Month</option>
									<option>Jan</option>
									<option>Feb</option>
									<option>Mar</option>
									<option>Apr</option>
									<option>May</option>
									<option>Jun</option>
									<option>Jul</option>
									<option>Aug</option>
									<option>Sep</option>
									<option>Oct</option>
									<option>Nov</option>
									<option>Dec</option>
							</select>&nbsp; <select id="dropdown" name="dob_dropdown_day">
									<option>Day</option>
									<option>
										<%
											for (int i = 1; i <= 31; i++) {
										%>
									
									<option><%=i%></option>
									<%
										}
									%>

									</option>

							</select>&nbsp; <select id="dropdown" name="dob_dropdown_year">
									<option>Year</option>
									<option>
										<%
											for (int j = 1950; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
									</option>

							</select></td>
						</tr>
						<tr>							
							<td>Date Of Joining</td>
							<td>:</td>
							<td><select id="dropdown" name="doj_dropdown_month">
									<option>Month</option>
									<option>Jan</option>
									<option>Feb</option>
									<option>Mar</option>
									<option>Apr</option>
									<option>May</option>
									<option>Jun</option>
									<option>Jul</option>
									<option>Aug</option>
									<option>Sep</option>
									<option>Oct</option>
									<option>Nov</option>
									<option>Dec</option>
							</select>&nbsp; <select id="dropdown" name="doj_dropdown_day">
									<option>Day</option>
									<option>
										<%
											for (int i = 1; i <= 31; i++) {
										%>
									
									<option><%=i%></option>
									<%
										}
									%>

									</option>

							</select>&nbsp; <select id="dropdown" name="doj_dropdown_year">
									<option>Year</option>
									<option>
										<%
											for (int j = 1980; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
									</option>

							</select></td>
						</tr>
						
						<tr>
							<td>License Number</td>
							<td>:</td>
							<td><input type="text" name="license_number"
								size="25" /></td>
						</tr>
						<tr>
							<td>Date Of Issue</td>
							<td>:</td>
							<td><select id="dropdown" name="doi_dropdown_month">
									<option>Month</option>
									<option>Jan</option>
									<option>Feb</option>
									<option>Mar</option>
									<option>Apr</option>
									<option>May</option>
									<option>Jun</option>
									<option>Jul</option>
									<option>Aug</option>
									<option>Sep</option>
									<option>Oct</option>
									<option>Nov</option>
									<option>Dec</option>
							</select>&nbsp; <select id="dropdown" name="doi_dropdown_day">
									<option>Day</option>
									<option>
										<%
											for (int i = 1; i <= 31; i++) {
										%>
									
									<option><%=i%></option>
									<%
										}
									%>

									</option>

							</select>&nbsp; <select id="dropdown" name="doi_dropdown_year">
									<option>Year</option>
									<option>
										<%
											for (int j = 2000; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
									</option>

							</select></td>
						</tr>
						<tr>
							<td>Date Of Expiry</td>
							<td>:</td>
							<td><select id="dropdown" name="doe_dropdown_month">
									<option>Month</option>
									<option>Jan</option>
									<option>Feb</option>
									<option>Mar</option>
									<option>Apr</option>
									<option>May</option>
									<option>Jun</option>
									<option>Jul</option>
									<option>Aug</option>
									<option>Sep</option>
									<option>Oct</option>
									<option>Nov</option>
									<option>Dec</option>
							</select>&nbsp; <select id="dropdown" name="doe_dropdown_day">
									<option>Day</option>
									<option>
										<%
											for (int i = 1; i <= 31; i++) {
										%>
									
									<option><%=i%></option>
									<%
										}
									%>

									</option>

							</select>&nbsp; <select id="dropdown" name="doe_dropdown_year" >
									<option>Year</option>
									<option>
										<%
											for (int j = 1975; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
									</option>

							</select></td>
						</tr>
						<tr>
							<td>Vehicle Number</td>
							<td>:</td>
							<td><select name="vehicle_number">
									<%
										String belongs = (String) session.getAttribute("belongs");
										dropdown dd = new dropdown();
										TreeMap hm1 = dd.getName(belongs);
										Set sets1 = hm1.entrySet();
										Iterator iterator1 = sets1.iterator();

										out.println("<option>Select a vehicle</option>");
										while (iterator1.hasNext()) {
											//String temp = iterator.next().toString();
											Map.Entry me1 = (Map.Entry) iterator1.next();
											out.println("<option>" + me1.getKey() + "</option> ");
										}
									%>
							</select></td>
						</tr>
						<tr>
							<td>Shift Number</td>
							<td>:</td>
							<td><select name="shift_number" >
									<%
										ShiftNumberDropdown SD = new ShiftNumberDropdown();
										HashMap hm = SD.getName();
										Set sets = hm.entrySet();
										Iterator iterator = sets.iterator();

										out.println("<option >Select a Shift ID</option>");
										while (iterator.hasNext()) {
											//String temp = iterator.next().toString();
											Map.Entry me = (Map.Entry) iterator.next();
											out.println("<option >" + me.getKey() + "</option> ");
										}
									%>
							</select></td>
						</tr>
						<tr>
							<td>Route Number</td>
							<td>:</td>
							<td><input type="text" class="tb" name="Route_number"
								size="5" /></td>
						</tr>
						<tr>
							<td colspan="2"></td>
							<td><input type="button" class="submit" value="Save"
								onclick="driver_info();" />&nbsp; <input type="button"
								class="submit" value="Update / Delete" onclick="driver_info_update();" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

	</form>


</body>

</html>