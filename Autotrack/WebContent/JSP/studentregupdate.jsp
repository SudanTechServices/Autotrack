<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
<script type="text/javascript" src="../JS/validate.js"></script>
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }
	function update()
	{    
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
	 	        var day=document.StudentInfo.dob_dropdown_day.value;
	 	        var year=document.StudentInfo.dob_dropdown_year.value;
	 	        var date_of_birth=day+"/"+month+"/"+year;
			//alert("DOB   "+date_of_birth);
			
		var enumber=document.StudentInfo.enrolment_number.value;
		
		document.StudentInfo.action="/Autotrack/ControllerServlet/Student_update_delService?enrolment_number="+enumber+"&dob="+date_of_birth;
		document.StudentInfo.submit();
			}
				
	}
	/* function refresh(){
		
		document.getElementById("transportnum").disabled = true;
	} */
	
	
function refresh(){
		
		//print_routes("route");
		document.getElementById("inputString").disabled = true;
	}
	
 
 <%-- var route_arr = new Array();
 var s_a = new Array();
 s_a[0]="";
 <%
 int counter=0;
 DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet set = null;
Statement mystatement = connection.createStatement();
set = mystatement.executeQuery("select * from route_registration");
String pickpoint=null,busroute=null,fee=null;
while(set.next())
{
	
	pickpoint=""+set.getString("stopping_point_1")+"|"+set.getString("stopping_point_2")+"|"+set.getString("stopping_point_3")+"|"+set.getString("stopping_point_4")+"|"+set.getString("stopping_point_5")+"";
	
	busroute=set.getString("bus_route_number");
	
	%>
	
	route_arr[<%=counter%>]='<%=busroute%>';
	s_a[<%=counter%>+1]='<%=pickpoint%>';
	<%
	
	counter++;
}
%>
 function print_routes(route_id){
 	// given the id of the <select> tag as function argument, it inserts <option> tags
 	var option_str = document.getElementById(route_id);
 	var x, i=0;
 	for(x in route_arr){
 		
 		option_str.options[i++] = new Option(route_arr[x],route_arr[x]);
 	}
 }

 function print_points(state_id, state_index){
 	var option_str = document.getElementById(state_id);
 	var x, i=0; state_index++;
 	var pick_arr = s_a[state_index].split("|");
 	for(x in pick_arr){
             option_str.options[i++] = new Option(pick_arr[x],pick_arr[x]);
 	}
 }
  --%>
 
 </script>
 

	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Autotrack</title> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<!-- <style type="text/css">

input.groovybutton
{
   font-size:14px;
   font-family:Trebuchet MS,sans-serif;
   font-weight:bold;
   color:#000;
   width:150px;
   height:30px;
   background-image:url("../images/content_pagetitle_bg.jpg");
   background-repeat: repeat-x;
   border-radius:25px;
}
.dropdown{
font-family:Trebuchet MS,sans-serif;
background-color:#B8E2FA; 
border-radius:10px; 
color:#000;
width:200px;
height: 30px;
padding: 2px;
}
option.blue 
{
background-color:#3B5C9A; 
font-weight: bold; 
font-size: 12px; 
color: white;
padding:3px;
}
input.field{
background-color:#B8E2FA;
font-family:Trebuchet MS,sans-serif;
width:150px;
color:#000;
}
</style>
 -->
</head> 
<%
String message = request.getParameter("message");
if(message == null){
	message = "";
}

else if(message.equalsIgnoreCase("updated")){
	message = "Updated Successfully";
}
else if(message.equalsIgnoreCase("deleted")){
	message = "Previous Record Deleted Successfully";
}
else if(message.equalsIgnoreCase("saved")){
	message = "Students Detail Saved Successfully";
}

%>
 
<%
String month_selected="";
String enumber  = request.getParameter("enumber");
String name ="";
String gender=" ";
String std = "";
String section = "";
String dob= "";
String residence_address="";
String route_number="";
String location="";
String pick_point= "";
String pick_up_timing="";
String category="";
String parent_name="";
String occupation="";
String designation="";
String office_address="";
String contact_number="";
String email="";
String mother_name="";
String mother_occupation="";
String mother_designation="";
String mother_office_address="";
String mother_contact_number="";
String mother_email="";
String residential_number="";
String maleradio="",femaleradio="";

try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();  
	  ResultSet rs = null;
	  Statement st=null;
	  st=connection.createStatement();
	  rs = st.executeQuery("SELECT * from student WHERE enrolment_number = '"+enumber+"'");
	  
	  while(rs.next()){ 
		  name = rs.getString("name");
		  gender=rs.getString("gender");
	      std=rs.getString("standard");
	      section=rs.getString("section");
	      dob= rs.getString("dob");
	      
	      residence_address=rs.getString("residence_address");
	      route_number=rs.getString("route_number");
	       location=rs.getString("location");
	       pick_point= rs.getString("pick_point");
	       pick_up_timing=rs.getString("pick_up_timing");
	       category=rs.getString("category");
	       parent_name=rs.getString("parent_name");
	       occupation=rs.getString("occupation");
	       designation=rs.getString("designation");
	       office_address=rs.getString("office_address");
	       contact_number=rs.getString("contact_number");
	       email=rs.getString("email");
	       mother_name=rs.getString("mother_name");
	       mother_occupation=rs.getString("mother_occupation");
	       mother_designation=rs.getString("mother_designation");
	       mother_office_address=rs.getString("mother_office_address");
	       mother_contact_number=rs.getString("mother_contact_number");
	       mother_email=rs.getString("mother_email");
	       residential_number=rs.getString("residential_number");
   }
}catch(SQLException e){ System.err.println(e.getMessage()); } 
String delims = "[/]";
String month="";
String day="";
String year="";

String[] tokens = dob.split(delims);

System.out.println("Length : "+tokens.length);

if(tokens.length > 2){
	month= tokens[1].trim();
	day = tokens[0].trim();
 year = tokens[2].trim();
}
System.out.println("month in db"+month);
if(month.equalsIgnoreCase("1"))
{

month_selected="Jan";					
}
else if(month.equalsIgnoreCase("2") )
{
	month_selected="Feb";
}
else if(month.equalsIgnoreCase("3"))
{
	month_selected="Mar";
}
else if(month.equalsIgnoreCase("4"))
{
	month_selected="Apr";
}
else if(month.equalsIgnoreCase("5"))
{
	month_selected="May";
}
else if(month.equalsIgnoreCase("6") )
{
	month_selected="Jun";
}
else if(month.equalsIgnoreCase("7") )
{
	month_selected="Jul";
}
else if(month.equalsIgnoreCase("8") )
{
	month_selected="Aug";
}
else if(month.equalsIgnoreCase("9") )
{
	month_selected="Sep";
}
else if(month.equalsIgnoreCase("10") )
{
	month_selected="Oct";
}
else if(month.equalsIgnoreCase("11") )
{
	month_selected="Nov";
}
else if(month.equalsIgnoreCase("12") )
{
	month_selected="Dec";
}

System.out.println("month    "+month_selected);
System.out.println("Day"+day);
System.out.println("Year"+year);
%>

 
<body onload="refresh();">

<div class="content_bg"><span class="content_headning">Student Transport Form</span></div>	
	
		
<form name="StudentInfo" method="post">
<table cellspacing="2" class="table_content" cellpadding="1" style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
			<tr>
				<td colspan="2" class="frmheading">Student's Details</td>
			</tr>
			<tr>
				<td>
					<table cellspacing="1" class="table_content" cellpadding="1" style="width: 100%;">
						<tr>
<td>
Student Name 
</td>
<td>:</td>
<td>
<input size="20" class="tb" type="text" name="name" value=<%= name%>>
</td>
	<td></td>
	<td></td>
	<td></td>
</tr>
<tr>
							<td>Gender</td>
							<td>:</td>
							<td>
<%
if(gender.equalsIgnoreCase("male"))
	{
	maleradio="checked";
	femaleradio="";
		
	%>


<%} else if(gender.equalsIgnoreCase("female"))
{
femaleradio="checked";
maleradio="";
} %>
<input type="radio" class="tb" name="gender" value="male" <%=maleradio %>/>Male
<input type="radio" class="tb" name="gender" value="female" <%=femaleradio %>/>Female
<td></td>
<td></td>
<td></td>
</td>
</tr>
<tr>
							<td valign="top">Date Of Birth</td>
							<td valign="top">:</td>
							<td><select id="dropdown" name="dob_dropdown_month" class="tb">
									<option><%= month_selected %></option>
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
									<option><%=day %></option>
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
									<option><%=year %></option>
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
<td>
Address      
</td>
<td valign="top">:</td>
<td>
<textarea name="address" rows="3" cols="20" class="tb" style="resize: none; background-color:#B8E2FA"><%=residence_address%></textarea>
</td>
</tr>

					</table>
				</td>
				<td valign="top">
					<table cellspacing="1" class="table_content" cellpadding="1">
						<tr>
<td style="width: 30%;">Enrollment No.</td>
<td>:</td>
<td>
<input type="text" size="30" class="tb" name="enrolment_number" id="inputString" value=<%=enumber%>>
</td>
<td></td>
<td></td>
<td></td>
</tr>





<tr>
<td>
Class         
</td>
<td>:</td>
<td>
<input type="text" size="5" class="tb" name="standard" size="4x;" value=<%= std%> >
Section &nbsp;&nbsp;&nbsp;: <input type="text" name="section" class="tb" size="5" size="4px;" value=<%= section%> ></td>

</tr>
<tr>
							<td>Pick Point</td>
							<td>:</td>
							<td><input type="text"  name="pick_point" size="20" class="tb" value=<%= pick_point%>
								 > Pick Time : <input class="tb" type="text" name="pickuptiming" size="20" value=<%= pick_up_timing%> ></td>
						</tr>
<tr>
							<td>Route Number&nbsp;&nbsp;</td>
							<td>:</td>
							<td><input class="tb" type="text" size="20" name="routenumber" value=<%= route_number%> > Location &nbsp;&nbsp;: <input class="tb" type="text" size="20" name="location" value=<%= location%> ></td>
						</tr>					






<tr>
<td> Category </td>
<td>:</td>
<td>
<input size="5" class="tb" type="text" name="category" value=<%= category%> >
</td>
</tr>

<tr>
<td>
Contact No. 
</td>
<td>:</td>
<td>
<input class="tb" size="20" type="text" name="residential_number" value=<%= residential_number%> >
</td>
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
<td style="width: 40%;">
Father/Guardian's Name  
</td>
<td>:</td>
<td>
<input class="tb" size="28" type="text" name="parentname" value=<%= parent_name%> >
</td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>
<td>
Occupation  
</td>
<td>:</td>
<td>
<input class="tb" size="28" type="text" name="occupation" value=<%= occupation%> >
</td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>
<td>
Designation  
</td>
<td>:</td>
<td>
<input class="tb" size="28" type="text" name="designation" value=<%= designation%> >
</td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>
<td valign="top">Office Address</td>
<td valign="top">:</td>
<td>
<textarea name="office_address" rows="3" cols="20" style="resize: none; width: 185px;" class="tb"><%= office_address%></textarea>
</td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>
<td>
Contact No.  
</td>
<td>:</td>
<td>
<input class="tb" type="text"  size="20" name="contact_number" value=<%= contact_number%> >
</td>
<td></td>
<td></td>
<td></td>
</tr>

<tr>
<td>
Email  
</td>
<td>:</td>
<td>
<input class="tb" type="text" size="28" name="email" value=<%= email%> >
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
<td>
<input class="tb" type="text" size="28" name="mother_name" value=<%= mother_name%> >
</td>
</tr>

<tr>
<td>
Occupation
</td>
<td>:</td>
<td>
<input class="tb" type="text" size="28" name="mother_occupation" value=<%= mother_occupation%> >
</td>
</tr>

<tr>
<td>
Designation  
</td>
<td>:</td>
<td>
<input class="tb" type="text" size="28" name="mother_designation" value=<%= mother_designation%> >
</td>
</tr>

<tr>
<td valign="top">Office Address</td>
<td valign="top">:</td>
<td>
<textarea name="mother_office_address" rows="3" cols="20" style="resize: none; width: 185px;" class="tb"><%=  mother_office_address%></textarea>
</td>
</tr>

<tr>
<td>
Contact No.  
</td>
<td>:</td>
<td>
<input class="tb" type="text" size="20" name="mother_contact_number" value=<%= mother_contact_number%> >
</td>
</tr>

<tr>
<td>
Email  
</td>
<td>:</td>
<td>
<input class="tb" type="text" size="28" name="mother_email" value=<%= mother_email%> >
</td>
</tr>

					</table>

				</td>
			</tr>

			<tr>

				<td colspan="2"><div id="show_fare" style="color: red;"></div></td>
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





<tr><td></td><td><!-- <input class="groovybutton" type="button"  class="submit" value="Save" onclick="save();">&nbsp;&nbsp; -->
<input class="submit" type="submit"  class="submit" name="action" value="Update"  onclick="update();">&nbsp;&nbsp;
<input class="submit" type="submit"  class="submit" name="action" value="Delete"  onclick="update();">&nbsp;&nbsp;
<!-- <input class="groovybutton" type="button"  class="submit" value="Delete" onclick="Delete();"> --></td></tr>
</table>
</form>		
		
</body> 
 
</html>