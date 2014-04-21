<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<script
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M"
	type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<script type="text/javascript" src="../JS/jquery-1.4.3.min.js"></script>

<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Autotrack</title>
<script type="text/javascript" src="../JS/validate.js"></script>
<script type="text/javascript">
window.history.forward();
function noBack() {
	window.history.forward();
}

	$(document)
			.ready(
					function() {
						//called when key is pressed in textbox
						$("#inputString")
								.keypress(
										function(e) {
											$("#error").hide();
											$("#autoSuggestionsList").hide();
											//if the letter is not digit then display error and don't type anything
											if (e.which != 8
													&& e.which != 0
													&& (e.which<48 || e.which>57)
													&& (e.which<65 || e.which>90)
													&& (e.which<97 || e.which>122)) {
												//display error message
												$("#error")
														.html(
																"No Special Characters.Only number & alphabets")
														.show();
												return false;
											}
										});
					});
	function lookup(inputString) {
		if (inputString.length < 2) {
			$('#suggestions').show();
			$('#autoSuggestionsList').hide();
		} else {
			$('#suggestions').hide();
			$.post("CRM_CheckUsername.jsp", {
				user : "" + inputString + ""
			}, function(data) {
				$('#autoSuggestionsList').html(data).show();
			});
		}
	}
</script>

<script type="text/javascript">

function noBack() { window.history.forward(); }

	function save() {
		
        if(StudentregistrationFormValidator())
			{
        	var month=document.StudentInfo.dob_dropdown_month.value;
        	 if(month == "Jan")
	        	{
	        	
	        	month=01;					
	       }
	        else if(month=="Feb" )
	        	{
	        	month=02;
	        	}
	        else if(month=="Mar" )
	        	{
	        	month=03;
	        	}
	        else if(month=="Apr" )
	        	{
	        	month=04;
	        	}
	        else if(month=="May" )
	        	{
	        	month=05;
	        	}
	        else if(month=="Jun" )
	        	{
	        	month=06;
	        	}
	        else if(month=="Jul" )
	        	{
	        	month=07;
	        	}
	        else if(month=="Aug" )
	        	{
	        	month=08;
	        	}
	        else if(month=="Sep" )
	        	{
	        	month=09;
	        	}
	        else if(month=="Oct" )
	        	{
	        	month=10;
	        	}
	        else if(month=="Nov" )
	        	{
	        	month=11;
	        	}
	        else if(month=="Dec" )
	        	{
	        	month=12;
	        	}
        	var dob_dropdown_day=document.StudentInfo.dob_dropdown_day.value;
        	var dob_dropdown_year=document.StudentInfo.dob_dropdown_year.value;
        	var dob=dob_dropdown_day+"/"+month+"/"+dob_dropdown_year;
        	
		document.StudentInfo.action = "/Autotrack/ControllerServlet/StudentInfoService?dob="+dob;
		document.StudentInfo.submit();
}
	}

	function update() {

		document.StudentInfo.action = "../JSP/CRM_sturegupdate.jsp";
		document.StudentInfo.submit();

	}
</script>


</head>

<%
	String message = request.getParameter("message");
	if (message == null) {
		message = "";
	}

	else if (message.equalsIgnoreCase("updated")) {
		message = "Updated Successfully";
	} else if (message.equalsIgnoreCase("deleted")) {
		message = "Previous Record Deleted Successfully";
	} else if (message.equalsIgnoreCase("saved")) {
		message = "Students Detail Saved Successfully";
	}
%>

<body onload="refresh();">

	<div class="content_bg">
		<div class="content_headning">Student Transport Form</div>
	</div>


	<form name="StudentInfo" method="post">
		<div style="color: red; font-size: 13px; font-family: arial; padding: 5px;"><%=message%></div>

<table cellspacing="2" class="table_content" cellpadding="1" style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
			<tr>
				<td colspan="2" class="frmheading">Student's Details</td>
			</tr>
			<tr>
				<td>
					<table cellspacing="1" class="table_content" cellpadding="1" style="width: 100%;">
						<tr>
							<td style="width: 40%;">Student Name</td>
							<td>:</td>
							<td><input type="text" name="name" size="28" class="tb" /></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>Gender</td>
							<td>:</td>
							<td><input type="radio" name="gender" value="male"
								class="tb" />Male <input type="radio" name="gender"
								value="female" class="tb" />Female</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td valign="top">Date Of Birth</td>
							<td valign="top">:</td>
							<td><select id="dropdown" name="dob_dropdown_month" class="tb">
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
							</select>&nbsp; <select id="dropdown" name="dob_dropdown_day" class="tb">
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

							</select>&nbsp; <select id="dropdown" name="dob_dropdown_year" class="tb">
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
							<td valign="top">Address</td>
							<td valign="top">:</td>
							<td><textarea name="address" rows="3" cols="20"
									style="resize: none; width: 185px;" class="tb"></textarea></td>
						</tr>

					</table>
				</td>
				<td valign="top">
					<table cellspacing="1" class="table_content" cellpadding="1">
						<tr>
							<td style="width: 30%;">Enrollment No.</td>
							<td>:</td>
							<td><input type="text" name="enrolment_number" size="30"
								class="tb" id="inputString" onkeyup="lookup(this.value);" />
								<div style="display: none; color: red;" id="autoSuggestionsList"></div>
								<div style="display: none;" id="error"></div></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>Class</td>
							<td>:</td>
							<td><input type="text" name="standard" size="5" class="tb" />
								Section &nbsp;&nbsp;&nbsp;: <input type="text" name="section"
								size="5" class="tb" /></td>
						</tr>
						<tr>
							<td>Pick Point</td>
							<td>:</td>
							<td><input type="text" name="pick_point" size="20"
								class="tb" /> Pick Time : <input type="text" name="pickuptiming"
								size="5" class="tb" /></td>
						</tr>
						<tr>
							<td>Route Number&nbsp;&nbsp;</td>
							<td>:</td>
							<td><input type="text" name="routenumber" size="5"
								class="tb" /> Location &nbsp;&nbsp;: <input type="text"
								name="location" size="20" class="tb" /></td>
						</tr>

						<tr>
							<td>Category</td>
							<td>:</td>
							<td><input type="text" name="category" size="5" class="tb" />
							</td>
						</tr>
						<tr>
							<td>Contact No.</td>
							<td>:</td>
							<td><input type="text" name="residential_number" size="20"
								class="tb" /></td>
						</tr>


					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<table cellspacing="1" class="table_content" cellpadding="1"
						style="width: 100%;">
						<tr>
							<td colspan="6" class="frmheading" valign="top">Father's
								Details</td>
						</tr>
						<tr>
							<td style="width: 40%;">Father/Guardian's Name</td>
							<td>:</td>
							<td><input type="text" name="parentname" size="28"
								class="tb" /></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>

						<tr>
							<td>Occupation</td>
							<td>:</td>
							<td><input type="text" name="occupation" size="28"
								class="tb" /></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>

						<tr>
							<td>Designation</td>
							<td>:</td>
							<td><input type="text" name="designation" size="28"
								class="tb" /></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>

						<tr>
							<td valign="top">Office Address</td>
							<td valign="top">:</td>
							<td><textarea name="office_address" rows="3" cols="20"
									style="resize: none; width: 185px;" class="tb"></textarea></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>

						<tr>
							<td>Contact No.</td>
							<td>:</td>
							<td><input type="text" name="contact_number" size="20"
								class="tb" /></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>

						<tr>
							<td>Email</td>
							<td>:</td>
							<td><input type="text" name="email" size="28" class="tb" />
							</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</td>
				<td>
					<table cellspacing="1" class="table_content" cellpadding="1"
						style="width: 100%;">
						<tr>
							<td colspan="6" class="frmheading" valign="top">Mother's
								Details</td>
						</tr>
						<tr>
							<td style="width: 28%;">Mother/Guradian's Name</td>
							<td>:</td>
							<td><input type="text" name="mother_name" size="28"
								class="tb" /></td>
						</tr>

						<tr>
							<td>Occupation</td>
							<td>:</td>
							<td><input type="text" name="mother_occupation" size="28"
								class="tb" /></td>
						</tr>

						<tr>
							<td>Designation</td>
							<td>:</td>
							<td><input type="text" name="mother_designation" size="28"
								class="tb" /></td>
						</tr>

						<tr>
							<td valign="top">Office Address</td>
							<td valign="top">:</td>
							<td><textarea name="mother_office_address" rows="3"
									cols="20" style="resize: none; width: 185px;" class="tb"></textarea>
							</td>
						</tr>

						<tr>
							<td>Contact No.</td>
							<td>:</td>
							<td><input type="text" name="mother_contact_number"
								size="20" class="tb" /></td>
						</tr>

						<tr>
							<td>Email</td>
							<td>:</td>
							<td><input type="text" name="mother_email" size="28"
								class="tb" /></td>
						</tr>

					</table>

				</td>
			</tr>

			<tr>

				<td colspan="2"><div id="show_fare" style="color: red;"></div></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button"
					class="submit" value="Save" class="tb" onclick="save();">&nbsp;&nbsp;
					<input type="button" class="submit" value="Update/Delete"
					class="tb" onclick="update();">&nbsp;&nbsp;</td>
			</tr>

			<%-- <tr>
<td>Vehicle Number</td>
<td>
<select name='vehiclenumber' class='dropdown'>

<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%	
String belongs=(String)session.getAttribute("belongs");
dropdown up=new dropdown();     
HashMap hashmap = up.getName(belongs);  
Set set1=hashmap.entrySet();
  
Iterator iterator = set1.iterator();   
  
//out.println("<select name='vehiclenumber' class='dropdown'>");   

while(iterator.hasNext()){   
     //String temp = iterator.next().toString();
     Map.Entry me = (Map.Entry)iterator.next();
     out.println("<option class='blue' value=\"" + me.getKey() + "\">" + me.getKey() + "</option>");   
}   
  
//out.println("</select>");   

%>
</select>
</td>
</tr>
 --%>


			<!-- <input class="groovybutton" type="button"  class="submit" value="Delete" onclick="Delete();"> -->
		</table>
	</form>

</body>

</html>