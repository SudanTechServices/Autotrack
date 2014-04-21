<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp"%>
<%@ page import="com.ts.service.dropdown"%>
<%@ page import="com.ts.service.ShiftNumberDropdown"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<script type="text/javascript" src="../JS/validate.js"></script>
<title>Autotrack</title>

<script type="text/javascript">
	function noBack() {
		window.history.forward();
	}

	function update() {

			var license_number = document.DriverInfo.license_number.value;
			document.DriverInfo.action = "/Autotrack/ControllerServlet/DriverInfoUpdateService?license_number="
					+ license_number;
			document.DriverInfo.submit();
	

	}

	function refresh() {
		document.getElementById("licencenum").disabled = true;
	}
</script>
</head>


<%
	String license_number = request.getParameter("licence_number");
	System.out.println(license_number);
	String driver_name = "";
	String gender = "";
	String contact_no = " ";
	String address = "";
	String date_of_birth = "";
	String date_of_joining = " ";
	String date_of_issue = "";
	String date_of_expiry = "";
	String vehicle_number = "";
	String shift_number = "";
	String route_number = "";

	try {

		DBTransaction dbtranobj = new DBTransaction();
		Connection connection = dbtranobj.connect();
		ResultSet rs = null;
		Statement st = null;
		st = connection.createStatement();

		rs = st.executeQuery("SELECT * from driver_info WHERE license_number = '"
				+ license_number + "'");

		while (rs.next()) {

			license_number = rs.getString("license_number");
			System.out.println("License Number in JSP:"
					+ license_number);
			driver_name = rs.getString("driver_name");

			gender = rs.getString("gender");

			contact_no = rs.getString("contact_no");

			address = rs.getString("address");

			date_of_birth = rs.getString("dob");

			date_of_joining = rs.getString("doj");

			date_of_issue = rs.getString("doi");

			date_of_expiry = rs.getString("doe");

			vehicle_number = rs.getString("vehicle_number");

			shift_number = rs.getString("shift_number");

			route_number = rs.getString("route_number");

		}

		 connection.close();
		 rs.close();
			st.close();
	} catch (SQLException e) {
		System.err.println(e.getMessage());
	}
%>

<body onload="refresh();">
	<div class="content_bg">
		<span class="content_headning">Driver Information</span>
	</div>
	<form method="post" name="DriverInfo">

		<table cellpadding="2px;" cellspacing="2px;" class="table_content"
			style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
			<tr>
				<td>
					<table cellpadding="2px;" cellspacing="4px;" class="table_content"
						style="width: 60%; background-color: #f1fafc;">
						<tr>
							<td>License Number</td>
							<td>:</td>
							<td><input class="tb" type="text" id="licencenum"
								name="license_number" size="28" value="<%=license_number%>" />
							</td>
						</tr>

						<tr>
							<td>Name</td>
							<td>:</td>
							<td><input class="tb" type="text" name="driver_name"
								size="28" value="<%=driver_name%>" /></td>
						</tr>

						<tr>
							<td>Gender</td>
							<td>:</td>
							<%
							String maleradio ="";
							String femaleradio ="";
							
							if(gender.equalsIgnoreCase("male"))
									{
										maleradio="checked";
										femaleradio="";
		
								} else if(gender.equalsIgnoreCase("female")){
								femaleradio="checked";
								maleradio="";
								} %>
							<td>
							    <input type="radio" name="gender" value="male" <%=maleradio %>/>Male
								<input type="radio" name="gender" value="female" <%=femaleradio %>/>Female
							</td>
						</tr>

						<tr>
							<td>Contact Number</td>
							<td>:</td>
							<td><input class="tb" type="text" name="contact_no"
								size="17" value="<%=contact_no%>" /></td>
						</tr>
						<tr>
							<td valign="top">Address</td>
							<td valign="top">:</td>
							<td><textarea name="address" rows="3" cols="20" class="tb" style="resize: none; width: 180px;"><%=address %></textarea>
							</td>
						</tr>
						
						<tr>							
							<td>Date Of Birth</td>
							<td>:</td>
							<td><input class="tb" type="text" name="date_of_birth"
								size="17" value="<%=date_of_birth%>" /></td>
						</tr>
						<tr>							
							<td>Date Of Joining</td>
							<td>:</td>
							<td><input class="tb" type="text" name="date_of_joining"
								size="17" value="<%=date_of_joining%>" /></td>
						</tr>	
						
						<tr>							
							<td>Date Of Issue</td>
							<td>:</td>
							<td><input class="tb" type="text" name="date_of_issue"
								size="17" value="<%=date_of_issue%>" /></td>
						</tr>
						
						<tr>							
							<td>Date Of Expiry</td>
							<td>:</td>
							<td><input class="tb" type="text" name="date_of_expiry"
								size="17" value="<%=date_of_expiry%>" /></td>
						</tr>
							
						
						<tr>
							<td>Vehicle Number</td>
							<td>:</td>
							<td><select name="vehicle_number" class="tb">
								<option><%=vehicle_number %></option>
									<%
										String belongs = (String) session.getAttribute("belongs");
										dropdown dd = new dropdown();
										TreeMap hm1 = dd.getName(belongs);
										Set sets1 = hm1.entrySet();
										Iterator iterator1 = sets1.iterator();
																			
										while (iterator1.hasNext()) {
											//String temp = iterator.next().toString();
											Map.Entry me1 = (Map.Entry) iterator1.next();
											if(!me1.getKey().equals(vehicle_number)){
											out.println("<option>" + me1.getKey()+ "</option> ");
											}
										}
									%>
							</select></td>
						</tr>
						<tr>
							<td>Shift Number</td>
							<td>:</td>
							<td><select name="shift_number" class="tb">
								<option><%=shift_number %></option>
									<%
										ShiftNumberDropdown SD = new ShiftNumberDropdown();
										HashMap hm = SD.getName();
										Set sets = hm.entrySet();
										Iterator iterator = sets.iterator();
																			
										while (iterator.hasNext()) {
											//String temp = iterator.next().toString();
											Map.Entry me = (Map.Entry) iterator.next();
											if(!me.getKey().equals(shift_number)){
											out.println("<option>" + me.getKey()+ "</option> ");
											}
										}
									%>
							</select></td>
						</tr>

						<tr>
							<td>Route Number</td>
							<td>:</td>
							<td><input class="tb" type="text" name="Route_number"
								size="5" value="<%=route_number%>" /></td>
						</tr>

						<tr>
							<td></td>
							<td></td>
							<td><input type="submit" class="submit" name="action1"
								value="Update" onclick="update();" /> <input type="submit"
								class="submit" name="action1" value="Delete" onclick="update();" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>


</body>

</html>