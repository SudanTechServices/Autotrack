<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
     <%@ page import="com.ts.service.dropdown" %> 
     <%@ page import="com.ts.service.ShiftNumberDropdown" %> 
	<%@ page import="java.util.ArrayList" %>
	<%@ page import="java.util.*" %>
	<%@page import="java.lang.*" %>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
 <script type="text/javascript" src="../JS/DatePick.js"></script>
 <script type="text/javascript" src="../JS/validate.js"></script>
	<link rel="stylesheet" type="text/css" href="../CSS/DatePick.css" />
	
	<title>Autotrack</title> 

<script type="text/javascript" src="../JS/validate.js"></script>
<script type="text/javascript">
        
    function tcss_info_save()
    {   
		
 		if(TcssInfoValidator())
    	{ 
    		 	        var month=document.TcssInfo.doj_dropdown_month.value;
    		 	       
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
    	        var day=document.TcssInfo.doj_dropdown_day.value;
    	        
    	        var year=document.TcssInfo.doj_dropdown_year.value;
    	        var doj=month+"/"+day+"/"+year;
    	       
     			var dob_month=document.TcssInfo.dob_dropdown_month.value;
	 	        if(dob_month == "Jan")
	 	        	{
	 	        	
	 	        	dob_month=01;					
	 	       }
	 	        else if(dob_month=="Feb" )
	 	        	{
	 	        	dob_month=02;
	 	        	}
	 	        else if(dob_month=="Mar" )
		        	{
	 	        	dob_month=03;
		        	}
	 	        else if(dob_month=="Apr" )
		        	{
	 	        	dob_month=04;
		        	}
	 	        else if(dob_month=="May" )
		        	{
	 	        	dob_month=05;
		        	}
	 	        else if(dob_month=="Jun" )
		        	{
	 	        	dob_month=06;
		        	}
	 	        else if(dob_month=="Jul" )
		        	{
	 	        	dob_month=07;
		        	}
	 	        else if(dob_month=="Aug" )
		        	{
	 	        	dob_month=08;
		        	}
	 	        else if(dob_month=="Sep" )
		        	{
	 	        	dob_month=09;
		        	}
	 	        else if(dob_month=="Oct" )
		        	{
	 	        	dob_month=10;
		        	}
	 	        else if(dob_month=="Nov" )
		        	{
	 	        	dob_month=11;
		        	}
	 	        else if(dob_month=="Dec" )
		        	{
	 	        	dob_month=12;
		        	}
	 	        var dob_day=document.TcssInfo.dob_dropdown_day.value;
	 	        var dob_year=document.TcssInfo.dob_dropdown_year.value;
	 	        var date_of_birth=dob_month+"/"+dob_day+"/"+dob_year;
	 	      
    			document.TcssInfo.action="/Autotrack/ControllerServlet/TcssInfoService?doj="+doj+"&dob="+date_of_birth;
    			document.TcssInfo.submit();
    			    }
    }
    
    function tcss_info_update()
    {
         
    	document.TcssInfo.action="../JSP/MGMT_tcssinfo_search.jsp";
    	document.TcssInfo.submit();
    	
    }
     
</script>	
</head> 
<%
String message = request.getParameter("message");
if(message == null){
	message = "";
}
else if(message.equalsIgnoreCase("success")){
	message = "TCSS Information Successfully Inserted !!!";
}
else if(message.equalsIgnoreCase("updated")){
	message = "TCSS Information Successfully Updated !!!";
}
else if(message.equalsIgnoreCase("deleted")){
	message = "TCSS Information Successfully deleted !!!";
}

%>
<body>
<div class="content_bg"><span class="content_headning">TCSS  Information</span></div>

<div style="color: red; font-size: 12px; padding: 8px;"><%=message %></div>
				 
<form method="post" name="TcssInfo">
                     
<table cellpadding="2px;" cellspacing="2px;" class="table_content" style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
<tr>
<td>
<table cellpadding="2px;" cellspacing="4px;" class="table_content" style="width: 40%; background-color: #f1fafc;">
<tr>
<td>
TCCS ID Number
</td>
<td>:</td>
<td>
<input type="text" name="tcss_id_number" size="27" class="tb"/>
</td>
</tr>
<tr>
<td>
Name
</td>
<td>:</td>
<td>
<input type="text" name="tcss_name" size="27" class="tb"/>
</td>
</tr>
<tr>
<td>
Gender           
</td>
<td>:</td>
<td>
<input type="radio" name="gender" value="male" class="tb"/>Male

<input type="radio" name="gender" value="female" class="tb"/>Female
</td>
</tr>
<tr>
<td>
Contact Number
</td>
<td>:</td>
<td>
<input type="text" name="contact_no" size="17" class="tb"/>
</td>
</tr>
<tr>
<td valign="top">
Address
</td>
<td valign="top">:</td>
<td>
<textarea name="address" rows="3" cols="20" style="resize: none;" class="tb"></textarea>
</td>
</tr>
<tr>
<td>Date Of Birth</td>
<td>:</td>
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
									
										<%
											for (int i = 1; i <= 31; i++) {
										%>
									
									<option><%=i%></option>
									<%
										}
									%>

									

							</select>&nbsp; <select id="dropdown" name="dob_dropdown_year" class="tb">
									<option>Year</option>
									
										<%
											for (int j = 1970; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
									

							</select></td>
</tr>
<tr>
<td>
Date Of Joining
</td>
<td>:</td>
<td>
 <select id="dropdown" name="doj_dropdown_month" class="tb">
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
</select>&nbsp;
 <select id="dropdown" name="doj_dropdown_day" class="tb">
<option >Day</option>

	<% for(int i=1;i<=31;i++) 
	{%>
		<option><%= i %></option>
	<%}
	%>

</select>&nbsp;
 <select id="dropdown" name="doj_dropdown_year" class="tb">
<option>Year</option>

	<% for(int j=1980;j<=2030;j++) 
		{%>
			<option><%= j %></option>
		 <%}
	%>

</select>

</td>
</tr>
<tr>
<td>
Years Of Experience
</td>
<td>:</td>
<td>
<input type="text" name="experience" size="5" class="tb"/>
</td>
</tr>
<tr>
<td>
Vehicle Number
</td>
<td>:</td>
<td>
<select name="vehicle_number" style="width: 120px;" class="tb">
                       <%	
                       String belongs=(String)session.getAttribute("belongs");
								dropdown dd=new dropdown();     
								TreeMap hm1 = dd.getName(belongs);
								Set sets1 = hm1.entrySet(); 
								Iterator iterator1 = sets1.iterator();   
								  
								
								out.println("<option>Select a Vehicle</option>"); 
								while(iterator1.hasNext()){   
								     //String temp = iterator.next().toString();
								     Map.Entry me1 = (Map.Entry)iterator1.next();
								     out.println("<option>" + me1.getKey() + "</option> ");   
								}   
  

%>
</select>
</td>
</tr>

<tr>
<td>Route Number</td>
<td>:</td>
<td>
<input type="text" name="Route_number" size="5" class="tb"/>
</td>
</tr>
<tr>
	<td colspan="3"></td>
</tr>
<tr>

	<td colspan="2" align="center"><input type="button" class="submit" value="Save" class="tb" onclick="tcss_info_save();">&nbsp;&nbsp;
					 <input type="button" class="submit" value="Update/Delete"
					class="tb" onclick="tcss_info_update();" />&nbsp;&nbsp; </td>

</tr>
</table>
</td>
</tr>
</table>

</form> 
          				

</body> 
 
</html>