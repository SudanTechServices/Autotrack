<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
 <%@ page errorPage="errorpage.jsp" %>
   
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<title>Autotrack</title> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }
   
    
    function update()
    {   if(customerFormValidator())
    	{
    	

	        
    	
    	var customer_id=document.CustomerInfo.customer_id.value;
    	document.CustomerInfo.action="/Autotrack/ControllerServlet/CustomerInfoUpdateService?customer_id="+customer_id;
		document.CustomerInfo.submit();
    	}
		
    }
    function delete1()
    {
    	var customer_id=document.CustomerInfo.customer_id.value;
    	document.CustomerInfo.action="/Autotrack/ControllerServlet/CustomerInfoUpdateService?customer_id="+customer_id;
		document.CustomerInfo.submit();
		alert('Successfully deleted!!');
    }
    
     function refresh(){
	
	document.getElementById("customer").disabled = true;
}
    
    
</SCRIPT>


<script type="text/javascript" src="../JS/validate.js"></script>

</head> 

<%
String customer_id  = request.getParameter("customer_id");
String customer_name ="";
String address="";
String contact_number = "";
String contact_person=" ";
String contract_start_date=" ";
String contract_end_date= "";
String no_of_licence="";


try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	  ResultSet rs = null;
	  Statement st=null;
	  st=connection.createStatement();
	  rs = st.executeQuery("SELECT * from customer_information WHERE customer_id = '"+customer_id+"'");
	  
	  while(rs.next()){ 
		  customer_id = rs.getString("customer_id");
		  customer_name = rs.getString("name");
		  System.out.println(customer_name);
		  address = rs.getString("address");
		  contact_number = rs.getString("contact_number");
		  contact_person = rs.getString("contact_person");
		  contract_start_date = rs.getString("contract_start_date");
		  contract_end_date = rs.getString("contract_end_date");
		  no_of_licence=rs.getString("no_of_licence");
		  
		 
		 
	  
   }
	  connection.close();
		rs.close();
		st.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } 

System.out.println("Start Date   "+contract_start_date);
System.out.println("End Date   "+contract_end_date);

%>
<body onload="refresh();" onpageshow="if (event.persisted) noBack();" onunload="">


<div class="content_bg"><span class="content_headning">Customer Registration</span></div>	
			
<form method="post" name="CustomerInfo">
 
                     
<table cellpadding="0" cellspacing="0" class="table_content" style="width: 100%; background-color: #f8f8f8; border: 1px solid #dfdddb;">
<tr>
<td>
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 50%; background-color: #f8f8f8;">

<tr>
	<td>
		Customer ID
	</td>
	<td>:</td>
	<td>
		<input type="text" id ="customer" name="customer_id" value="<%=customer_id %>" size="25" class="tb"/>
	</td>
</tr>

 <tr>
 	<td>
 	Customer Name
 	</td>
 	<td>:</td>
 	<td>
 	<input type="text" name="customer_name" value="<%=customer_name %>"  size="25" class="tb"/>
 	</td>
 </tr>
 


<tr>
	<td valign="top">
		Address
	</td>
	<td valign="top">:</td>
	
	<td>
	<textarea name="customer_address" rows="3" cols="25"	style="resize: none; width: 185px;"><%=address %></textarea>
		
	</td>
</tr>
<tr>
	<td>
		Contact Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="contact_number" value="<%=contact_number %>" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Contact Person
	</td>
	<td>:</td>
	<td>
		<input type="text" name="contact_person" value="<%=contact_person %>" size="25" class="tb"/>
	</td>
</tr>
<%-- <tr>
	<td>
		Contract Start Date
	</td>
	<td>:</td>
	<td><select id="dropdown" name="dropdown_month" class="tb">
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
							</select>&nbsp; <select id="dropdown" name="dropdown_day" class="tb">
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

							</select>&nbsp; <select id="dropdown" name="dropdown_year" class="tb">
									<option>Year</option>
									<option>
										<%
											for (int j = 1900; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
									</option>

							</select>		
	</td>
</tr> --%>
<tr>
	<td>
		Contract Start Date
	</td>
	<td>:</td>
	<td><input type="text" name="contract_Start_date" value="<%=contract_start_date %>" size="25" class="tb"/></td>
</tr>
<%-- <tr>
	<td>
		Contract End Date
	</td>
	<td>:</td>	
	<td><select id="dropdown" name="dropdown_month" class="tb">
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
							</select>&nbsp; <select id="dropdown" name="dropdown_day" class="tb">
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

							</select>&nbsp; <select id="dropdown" name="dropdown_year" class="tb">
									<option>Year</option>
									<option>
										<%
											for (int j = 1900; j <= 2030; j++) {
										%>
									
									<option><%=j%></option>
									<%
										}
									%>
									</option>

							</select>		
	</td>
</tr> --%>
<tr>
	<td>
		Contract End Date
	</td>
	<td>:</td>
	<td><input type="text" name="contract_End_date" value="<%=contract_end_date %>" size="25" class="tb"/></td>
</tr>
<tr>
	<td>
		No. of Licence
	</td>
	<td>:</td>
	<td>
		<input class="tb" type="text" name="number_of_licence" size="25" value="<%=no_of_licence %>"/>
	</td>
</tr>

<tr>
	<td></td>
	<td></td>
	<td>
		<input type="submit" class="submit" name="action1" value="Update" onclick="update();"/>&nbsp;&nbsp;
		<input type="submit" class="submit" name="action1" value="Delete" onclick="delete1();"/>
	</td>
</tr>

</table>
</td>
</tr>
</table>
                        
					</form> 
                    				
	 </div><!--  #content -->
	<!--
	<div id="footer" style="padding-top: 20px;">		
		<div class="content_pad">	
				
			<p>&copy; 2012 Copyright TransNetworkx. Powered by <a href="#">Digital Astraa Solutions Pvt Ltd</a>.</p>
		</div> .content_pad
	</div> #footer		
	
</div> #wrapper
 -->
</body> 
 
</html>