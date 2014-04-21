<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<%@ page import="com.ts.service.dropdown"%>
<%--   <%@ page import="com.ts.service.ShiftNumberDropdown" %>  --%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.sql.*"%>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<script type="text/javascript" src="../JS/validate.js"></script>

<SCRIPT type="text/javascript">
	
	function update() {
		                    var tcss_id_number=document.TcssInfo.tcss_id_number.value;	
							document.TcssInfo.action = "/Autotrack/ControllerServlet/Tcss_update_delService?tcss_id_number="+tcss_id_number+"";
							document.TcssInfo.submit();
		}

	

</script>



<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Autotrack</title>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
</head>


<%
	String tcss_id_number = request.getParameter("tcss_id_number");
	String name = "";
	String gender = " ";
	String contact_number = "";
	String address = "";
	String dob = "";
	String doj = "";
	String year_of_exp = "";
	String vehicle_number = "";
	String Route_number = "";
	String maleradio = "", femaleradio = "";
	String day = "";
	String month = "";
	String year = "";
	String month_selected = "";
	try {
		DBTransaction dbtranobj = new DBTransaction();
		Connection connection = dbtranobj.connect();
		ResultSet rs = null;
		Statement st = null;
		st = connection.createStatement();
		rs = st.executeQuery("SELECT * from tcss_information WHERE id_number = '"+ tcss_id_number + "'");

		while (rs.next()) {
			name = rs.getString("name");
			gender = rs.getString("gender");
			contact_number = rs.getString("contact_number");
			address = rs.getString("address");
			dob = rs.getString("dob");
			doj = rs.getString("doj");
			year_of_exp = rs.getString("experience");
			vehicle_number = rs.getString("vehicle_number");
			Route_number = rs.getString("route_number");

		}
	} catch (SQLException e) {
		System.err.println(e.getMessage());
	}

	
%>


<body">
	<div class="content_bg">
		<span class="content_headning">TCSS Information</span>
	</div>



	<form method="post" name="TcssInfo">

		<table cellpadding="0" cellspacing="0" class="table_content"
			style="width: 100%; background-color: #fff; border: 1px solid #dfdddb;">
			<tr>
				<td>
					<table cellpadding="4" cellspacing="0" class="table_content"
						style="width: 40%; background-color: #fff;">
						<tr>
							<td>TCCS ID Number</td>
							<td>:</td>
							<td><input type="text" id="inputString"	name="tcss_id_number" size="25"  value=<%=tcss_id_number%>></td>
						</tr>
						<tr>
							<td>Name</td>
							<td>:</td>
							<td><input  type="text" name="tcss_name" size="25" value=<%=name%>></td>
						</tr>
						<tr>
							<td>Gender</td>
							<td>:</td>
							<td>
								<%
									if (gender.equalsIgnoreCase("male")) {
										maleradio = "checked";
										femaleradio = "";
								%> <%
									 	} else if (gender.equalsIgnoreCase("female")) {
									 		femaleradio = "checked";
									 		maleradio = "";
									 	}
 								%> 
 								<input type="radio" name="gender" value="male" <%=maleradio%> />Male
								<input type="radio" name="gender" value="female"<%=femaleradio%> />Female

							</td>
						</tr>
						<tr>
							<td>Contact Number</td>
							<td>:</td>
							<td><input  type="text" name="contact_no"
								size="25" value=<%=contact_number%>></td>
						</tr>
						<tr>
							<td valign="top">Address</td>
							<td valign="top">:</td>
							<td><textarea name="address" rows="3" cols="22"
									style="resize: none;" ><%=address%></textarea></td>
						</tr>
						<tr>
							<td>Date Of Birth</td>
							<td>:</td>
							<td><input type="text" name="dob" size="25" 
								value=<%=dob%>></td>
						</tr>
						<tr>
							<td>Date Of Joining</td>
							<td>:</td>
							<td><input type="text" name="doj" size="25" 
								value=<%=doj%>></td>
						</tr>
						<tr>
							<td>Years Of Experience</td>
							<td>:</td>
							<td><input type="text" name="experience" size="25" 
								value=<%=year_of_exp%>></td>
						</tr>
						<tr>
							<td>Vehicle Number</td>
							<td>:</td>
							<td><select name="vehicle_number" style="width: 120px;">
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
							<td>Route Number</td>
							<td>:</td>
							<td><input type="text" name="Route_number" 
								size="25" value=<%=Route_number%>></td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<input type="submit"	class="submit" name="action" value="Update" onclick="update();" />
								<input type="submit" class="submit" name="action" value="Delete" onclick="update();" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

	</form>


</body>

</html>