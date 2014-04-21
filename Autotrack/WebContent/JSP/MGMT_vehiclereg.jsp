<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>

<%@ page errorPage="errorpage.jsp" %>
    <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
	<script type="text/javascript" src="/Autotrack/JS/vehicle_validate.js"></script>
	<title>Welcome to Autotrack</title> 
	<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
	<script type="text/javascript" src="http://jqtouch.googlecode.com/svn-history/r134/trunk/jqtouch/jquery-1.4.2.min.js"></script>

<script type="text/javascript" src="../JS/validate.js"></script>

	<SCRIPT type="text/javascript">
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

	set = mystatement.executeQuery("select DISTINCT customer_id from customer_information");
	while(set.next())
	{
		customerid = set.getString("customer_id");
			%>
			customerid_arr[<%=counter%>]='<%=customerid%>';
			<%
		counter++;
	}
	connection.close();
	mystatement.close();
	set.close();
	}catch(Exception e){}
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
 		
 		if(vehicleFormValidator())
    	{
 			var vehicle_number=document.VehicleInfo.vehicle_number.value;
    		document.VehicleInfo.action="/Autotrack/ControllerServlet/VehicleInfoService?vehicle_no="+vehicle_number;//it go to controllerservlet and after that it go to LoginService
			document.VehicleInfo.submit();
		}
    }
 	
 	function update()
    {
    	    document.VehicleInfo.action="../JSP/MGMT_vehiclereg_search.jsp";//it go to controllerservlet and after that it go to LoginService
			document.VehicleInfo.submit();
    }
 	
 	function check_nooflicence(name){
 		
 		$(document).ready(function(){
		this.timer = setTimeout(function () {
		$.ajax({
		url: 'Check_nooflicence.jsp?customer_id='+name+'',
		data: '',
		type: 'POST',
		success: function(msg){ 
			
			msg = msg.trim();
			
			var split = msg.split('!');
			var total_no_of_licence = split[0];
			var remain_no_of_licence = split[1];
			//var vehicle = new Array();
			var vehicle=split[2];
			
			document.getElementById("total").innerHTML="<table><tr><td>Total Number of licence </td><td>"+": "+total_no_of_licence+"</td></tr><tr><td>Remaining vehicle to enter </td><td>"+": "+remain_no_of_licence+"</td></tr><tr><td>Entered vehicle information </td><td>"+": "+vehicle+"</td></tr></table>";
											
		} }); }, 200);

		return true;
		});
 		
}
 	
 	
 </script>
 
 </head> 

 
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<%

String message = request.getParameter("message");
String mode=request.getParameter("mode");


if(message == null){
	message = "";
}
else if(message.equalsIgnoreCase("success")){
	message = "Vehicle Registered Successfully !!";
}
else if(message.equalsIgnoreCase("updated")){
	message = "Vehicle Information Updated Successfully !!";
}
else if(message.equalsIgnoreCase("deleted")){
	message = "Vehicle Information Deleted Successfully !!";
	
}
else if(message.equalsIgnoreCase("exist")){
	message = "Vehicle Number Already Exist !!";
}

%>


<div class="content_bg"><span class="content_headning">Vehicle Registration</span></div>	
 <div style="color: red; font-family:arial; font-size: 12px; padding: 5px;"><%=message %></div> 
<form name="VehicleInfo" method="post">
                       

<table cellpadding="0" cellspacing="0" style="width: 100%; background-color: #f8f8f8; border: 1px solid #dfdddb;">
<tr>
<td>
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 100%; background-color: #f8f8f8;">
<tr>
	<td>
		Customer ID
	</td>
	<td>:</td>
	<td>			 	
			 	<select id="customer_id" name ="customer_id" style="width: 190px;" class="tb" onchange="javascript:check_nooflicence(this.value);">
			 		<option>--Select Route --</option>
			 	</select>
			 	<script language="javascript">print_customerid("customer_id");</script>
			 	</td>
</tr>
<tr>
	<td>
		Vehicle Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="vehicle_number" size="25" class="tb"/>
		<%-- <b><label style="color: red"><%=mode%></label></b> --%>
		
	</td>
</tr> 
<tr>
	<td>
		Customer Name
	</td>
	<td>:</td>
	<td>
		<input type="text" name="customer_name" size="25" class="tb"/>
	</td>
</tr> 
<tr>
	<td>
		Mobile Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="Sim_no" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		IMEI Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="IMEI_no" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Camera ID
	</td>
	<td>:</td>
	<td>
		<input type="text" name="camera_id" size="25" class="tb"/>
	</td>
</tr>

<tr>
	<td>
		Vehicle Type
	</td>
	<td>:</td>
	<td>
		<input type="text" name="vehicle_type" size="25" class="tb"/>
	</td>
</tr>                      
<tr>
	<td>
		Vehicle Manufacturer
	</td>
	<td>:</td>
	<td>
		<input type="text" name="vechile_mfg" size="25" class="tb"/>
	</td>
</tr> 
<tr>
	<td>
		Vehicle Fuel Tank Capacity
	</td>
	<td>:</td>
	<td>
		<input type="text" name="fuel_capacity" size="25" class="tb"/>
	</td>
</tr>     
<tr>
	<td>
		Fuel Sender Unit
	</td>
	<td>:</td>
	<td>
        <select name="fuel_sender" style="width: 190px;" class="tb">
             <option>Potentiometric N</option>
             <option>Potentiometric R</option>
             <option>Capacitance N</option>
         </select>
     </td>
</tr>
                        
<tr>
	<td>
		Max Speed
	</td>
	<td>:</td>
	<td>
		<input type="text" name="max_speed" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Empty Fuel Voltage
	</td>
	<td>:</td>
	<td>
		<input type="text" name="min_fuel_volt" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Full Fuel Voltage
	</td>
	<td>:</td>
	<td>
		<input type="text" name="max_fuel_volt" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td></td>	
	<td colspan="2">
		<input type="button" value="Save" onclick="insert();"/>
		<input type="button" value="Update / Delete" onclick="update();"/>
	    
	</td>
</tr>

</table>

</td>
<td style="width:50%;" valign="top">
<table  style="background-color: #f1fafc;" class="table_content" >

<tr>
	<td id="total"></td>
</tr>
</table>

</td>
</tr>
</table>
                   
</form> 

 </body> 
 </html>