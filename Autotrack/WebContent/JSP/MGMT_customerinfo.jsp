<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
    <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
   
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<title>Autotrack</title> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

<script type="text/javascript" src="../JS/validate.js"></script>


<script type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }
    
    var customerid_arr = new Array();
	<%
	int counter=0;
	String customerid= null, vehiclenumber=null,busroute=null,standard=null, locations = null;
	try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	ResultSet set = null;
	Statement mystatement = connection.createStatement();

	set = mystatement.executeQuery("select DISTINCT user_name from login_information");
	while(set.next())
	{
		customerid = set.getString("user_name");
			%>
			customerid_arr[<%=counter%>]='<%=customerid%>';
			<%
		counter++;
	}
	 connection.close();
	 mystatement.close();
		set.close();
	}
	catch(Exception e){}
%>

		function print_customerid(id){
			// given the id of the <select> tag as function argument, it inserts <option> tags
			var option_str = document.getElementById(id);
			var x, i=0;
			for(x in customerid_arr){
				
				option_str.options[i++] = new Option(customerid_arr[x],customerid_arr[x]);
			}
		}
    
    function insert()
    {
    	
    	if(customerFormValidator())
    	{   
        	var month=document.CustomerInfo.start_dropdown_month.value;
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
	        var day=document.CustomerInfo.start_dropdown_day.value;
	        var year=document.CustomerInfo.start_dropdown_year.value;
	        var contract_start_date=month+"/"+day+"/"+year;
	
	       
	
	var end_month=document.CustomerInfo.end_dropdown_month.value;
    if(end_month == "Jan")
    	{
    	
    	end_month=01;					
   }
    else if(end_month=="Feb" )
    	{
    	end_month=02;
    	}
    else if(end_month=="Mar" )
	{
    	end_month=03;
	}
    else if(end_month=="Apr" )
	{
    	end_month=04;
	}
    else if(end_month=="May" )
	{
    	end_month=05;
	}
    else if(end_month=="Jun" )
	{
    	end_month=06;
	}
    else if(end_month=="Jul" )
	{
    	end_month=07;
	}
    else if(end_month=="Aug" )
	{
    	end_month=08;
	}
    else if(end_month=="Sep" )
	{
    	end_month=09;
	}
    else if(end_month=="Oct" )
	{
    	end_month=10;
	}
    else if(end_month=="Nov" )
	{
    	end_month=11;
	}
    else if(end_month=="Dec" )
	{
    	end_month=12;
	}
    var end_day=document.CustomerInfo.end_dropdown_day.value;
    var end_year=document.CustomerInfo.end_dropdown_year.value;
    var contract_end_date=end_month+"/"+end_day+"/"+end_year;

	
    		
    			document.CustomerInfo.action="/Autotrack/ControllerServlet/CustomerInfoService?contarct_start_date="+contract_start_date+"&contarct_end_date="+contract_end_date;
				document.CustomerInfo.submit();
				alert('Successfully inserted!!');
    				
    	}
    }
    
    function update()
    {
        document.CustomerInfo.action="../JSP/MGMT_customerinfo_search.jsp";
		document.CustomerInfo.submit();
    		
    }
       
</script>


</head> 


<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
<%
String message = request.getParameter("message");

if(message == null){
	message = "";
}
else if(message.equalsIgnoreCase("success")){
	message = "Registration Completed Successfully !!";
}
else if(message.equalsIgnoreCase("updated")){
	message = "Data Updated Successfully !!";
}
else if(message.equalsIgnoreCase("deleted")){
	message = "Data deleted Successfully !!";
}
%>

<div class="content_bg"><span class="content_headning">Customer Registration</span></div>	
			

 
 <div style="color: red; font-family:Comic Sans MS,sans-serif; font-size: 14px;"><%=message %></div>                     

<table cellpadding="4" cellspacing="0" class="table_content" style="width: 100%; background-color: #f8f8f8; border: 1px solid #dfdddb;">
<tr>
<td>
<form method="post" name="CustomerInfo">
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 55%; background-color: #f8f8f8;">
<tr>
	<td>
		Customer ID
	</td>
	<td>:</td>
	<td>			 	
			 	<select id="customer_id" name ="customer_id" style="width: 190px;" onchange="javascript:check_nooflicence(this.value);">
			 		<option>--Select Route --</option>
			 	</select>
			 	<script type="text/javascript">print_customerid("customer_id");</script>
			 	</td>
</tr>
<tr>
 <tr>
 	<td>
 	Customer Name
 	</td>
 	<td>:</td>
 	<td>
 	<input type="text" name="customer_name" size="25" />
 	</td>
 </tr>
 

<tr>
	<td valign="top">
		Address
	</td>
	<td valign="top">:</td>
	<td>
	<textarea name="customer_address" rows="3" cols="25" 
									style="resize: none; width: 185px;"></textarea>
		
	</td>
</tr>
<tr>
	<td>
		Contact Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="contact_number" size="25" />
	</td>
</tr>
<tr>
	<td>
		Contact Person
	</td>
	<td>:</td>
	<td>
		<input type="text" name="contact_person" size="25" />
	</td>
</tr>
<tr>
	<td>
		Contract Start Date
	</td>
	<td>:</td>
	<td><select id="dropdown" name="start_dropdown_month">
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
							</select>&nbsp; <select id="dropdown" name="start_dropdown_day" class="tb">
									<option>Day</option>
									
										<%
											for (int i = 1; i <= 31; i++) {
										%>
									
									<option><%=i%></option>
									<%
										}
									%>


							</select>&nbsp; <select id="dropdown" name="start_dropdown_year" class="tb">
									<option>Year</option>
									
										<%
											for (int j = 2000; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
								

							</select>		
	</td>
</tr>
<tr>
	<td>
		Contract End Date
	</td>
	<td>:</td>
	<td><select id="dropdown" name="end_dropdown_month" class="tb">
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
							</select>&nbsp; <select id="dropdown" name="end_dropdown_day" class="tb">
									<option>Day</option>
									
										<%
											for (int i = 1; i <= 31; i++) {
										%>
									
									<option><%=i%></option>
									<%
										}
									%>


							</select>&nbsp; <select id="dropdown" name="end_dropdown_year" class="tb">
									<option>Year</option>
									
										<%
										for (int j = 2000; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
								

							</select>		
	</td>
</tr>
<tr>
	<td>
		No. of Licence
	</td>
	<td>:</td>
	<td>
		<input type="text" name="number_of_licence" size="10"/>
	</td>
</tr>
<tr>
    <td></td>	
    <td></td>	
	<td>
		<input type="button" class="submit" value="Save" onclick="insert();"/>
		<input type="button" class="submit" value="Update / Delete" onclick="update();"/>
		
	</td>
</tr>
</table>
</form> 
</td>
</tr>
</table>

</body> 
 
</html>