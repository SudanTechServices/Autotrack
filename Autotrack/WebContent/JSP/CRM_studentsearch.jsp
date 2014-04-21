<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
    <%@page import="java.util.ArrayList"%>
    <%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>

 <%
 String output = "temp";
 String studentname = "";
 String rollnumber = "";
 String place = "";
 
 ArrayList<String> list=new ArrayList<String>(); 
 String name=request.getParameter("student");
 //System.out.println(name);

 String delims = "[,]";
 String[] tokens = name.split(delims);
 
 System.out.println("Length : "+tokens.length);
 
 if(tokens.length > 2){
  studentname = tokens[0].trim();
  rollnumber = tokens[1].trim();
  place = tokens[2].trim();
 }
 else{
	 studentname = name;
	 rollnumber = name;
	 place = name;
	 
 }
 
 
 String enumber="";
 String names="";
 String gender="";
 String standard="";
 String section="";
 String dob="";
 String address="";
 String routenumber="";
 String loc="";
 String pick_point="";
 String pickuptiming="";
 String category="";
 String parentname="";
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
 String maleradio="";
 String femaleradio="";
	 
 try    
 {              
	 DBTransaction dbtranobj=new DBTransaction();
		Connection connection=dbtranobj.connect();
		ResultSet rs = null;
		Statement st=null;
		st=connection.createStatement();
 	String dbquery="select * from student where name='"+studentname+"' AND enrolment_number = '"+rollnumber+"' AND location='"+place+"'";
 	 rs=st.executeQuery(dbquery);
 	  
 			
 		 	while(rs.next())
				 	{
				 		  enumber=rs.getString("enrolment_number");
				 		// System.out.println(rs.getString("enrolment_number"));
						  names=rs.getString("name");
						  gender=rs.getString("gender");
						  standard=rs.getString("standard");
						  section=rs.getString("section");
						  dob=rs.getString("dob");
						  address=rs.getString("residence_address");
						  routenumber=rs.getString("route_number");
						  loc=rs.getString("location");
						  pick_point=rs.getString("pick_point");
						  pickuptiming=rs.getString("pick_up_timing");
						  category=rs.getString("category");
						  parentname=rs.getString("parent_name");
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
				 	
				 	output = "<table cellspacing='1' cellpadding='2' cellspacing='2'  frame='border' style='font-family:Arial; font-size: 12px; width: 100%;background-color:#f1fafc;border: 1px solid #2898b4;'>"; 
				 	output+="<tr><th colspan='3' align='left' style='background-color:#30b8ea; color:#fff; '>Student's Details</th></tr>";
				 	output+="<tr><td>Enrollment Number</td><td> : </td><td>"+enumber+"</tr>";
				 	output+="<tr><td>Name</td><td> : </td><td>"+names+" </td></tr>";
				 	output+="<tr><td>Gender</td><td> : </td><td>"+gender+"</td></tr>";
				 	output+="<tr><td>Standard</td><td> : </td><td>"+standard+"</td></tr>";
				 	output+="<tr><td>Date Of Birth</td><td> : </td><td>"+dob+"</td></tr>";
				 	output+="<tr><td>Address</td><td> : </td><td>"+address+"</td></tr>";
				 	output+="<tr><td>Route Number</td><td> : </td><td>"+routenumber+"</td></tr>";
				 	output+="<tr><td>Location</td><td> : </td><td>"+loc+"</td></tr>";
				 	output+="<tr><td>Pick Point</td><td> : </td><td>"+pick_point+"</td></tr>";
				 	output+="<tr><td>Pick Up Timing</td><td> : </td><td>"+pickuptiming+"</td></tr>";
				 	output+="<tr><td>Category</td><td> : </td><td>"+category+"</td></tr>";
				 	output+="<tr><td>Residential Number</td><td> : </td><td>"+residential_number+"</td></tr></table>";

				 	output+="<div  style='width:50%;float:left;'>";
				 	output+="<table frame='border' cellpadding='2' cellspacing='2' style='font-family:Arial; font-size: 12px; width: 100%;background-color:#f1fafc;border: 1px solid #2898b4;'>";
				 	output+="<tr><th colspan='3' align='left' style='background-color:#74C8EA; color:#fff;'>Father's Details</th></tr>";
				 	output+="<tr><td>Name</td><td> : </td><td>"+parentname+"</td></tr>";
				 	output+="<tr><td>Occupation</td><td> : </td><td>"+occupation+"</td></tr>";
				 	output+="<tr><td>Designation</td><td> : </td><td>"+designation+"</td></tr>";
				 	output+="<tr><td>Office Address</td><td> : </td><td>"+office_address+"</td></tr>";
				 	output+="<tr><td>Contact Number</td><td> : </td><td>"+contact_number+"</td></tr>";
				 	output+="<tr><td>Email</td><td> : </td><td>"+email+"</td></tr></table></div>";

				 	output+="<div  style='width:50%;float:left;'>";
				 	output+="<table cellpadding='2' cellspacing='2' frame='border' style='font-family:arial; font-size: 12px; width: 100%; background-color:#f1fafc;border: 1px solid #2898b4;'>";
				 	output+="<tr><th colspan='3' align='left' style='background-color:#74C8EA; color:#fff;'>Mother's Details</th></tr>";
				 	output+="<tr><td>Name</td><td> : </td><td>"+mother_name+"</td></tr>";
				 	output+="<tr><td>Occupation</td><td> : </td><td>"+mother_occupation+"</td></tr>";
				 	output+="<tr><td>Designation</td><td> : </td><td>"+mother_designation+"</td></tr>";
				 	output+="<tr><td>Office Address</td><td> : </td><td>"+mother_office_address+"</td></tr>";
				 	output+="<tr><td>Contact Number</td><td> : </td><td>"+mother_contact_number+"</td></tr>";
				 	output+="<tr><td>Email</td><td> : </td><td>"+mother_email+"</td></tr></table></div>";


				 	
 	
 	
				 	if(enumber.isEmpty() || tokens.length < 2){
				 		out.println("<center><div style='background-color:#74C8EA; padding: 50px;'>No Records Found</div></center>");
				 	}
				 	else{
				 		
				 			out.println(output);
				 	}
				 	
 	
				 	 connection.close();
					 st.close();
					 rs.close();
 }catch(SQLException e){ System.err.println(e.getMessage()); } 

 %>

<% 

%>

</html>