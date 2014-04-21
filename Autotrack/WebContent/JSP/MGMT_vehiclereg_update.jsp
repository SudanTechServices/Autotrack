
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
 <%@ page errorPage="errorpage.jsp" %>
 <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
	<script type="text/javascript" src="/Autotrack/JS/vehicle_validate.js"></script>
	<title>Trans Workx</title> 
	<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

	<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }
 	
 	function update()
    {
 		if(vehicleFormValidator())
 			{
 			
 			var vehicle_number=document.VehicleInfo.vehicle_number.value;
 			
 			
    		document.VehicleInfo.action="/Autotrack/ControllerServlet/VehicleInfoUpdateDeleteService?vehicle_number="+vehicle_number+"&action1=update";//it go to controllerservlet and after that it go to VehicleInfoUpdateDeleteService
			document.VehicleInfo.submit();
 			}
 	}
 	
 	function delete1()
 	{
 		var vehicle_number=document.VehicleInfo.vehicle_number.value;
		document.VehicleInfo.action="/Autotrack/ControllerServlet/VehicleInfoUpdateDeleteService?vehicle_number="+vehicle_number+"&action1=delete";//it go to controllerservlet and after that it go to VehicleInfoUpdateDeleteService
		document.VehicleInfo.submit();
		
 	}
 	
 </script>
 
 </head> 

 <%

String vehicle_number=request.getParameter("vehicle_number");
 String customer_id  = "";
String customer_name ="";

String vehicle_type = "";
String fuel_tank_capacity=" ";
String sim_no=" ";
String imei_no= "";
String camera_id= "";
String vehicle_mfg= "";
String max_speed= "";
String fuel_sender= "";
String empty_fuel_voltage= "";
String full_fuel_voltage= "";


try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	  ResultSet rs = null;
	  Statement st=null;
	  st=connection.createStatement();
	  rs = st.executeQuery("SELECT * from vehicle_information WHERE vehicle_number='"+vehicle_number+"'");
	  
	  while(rs.next()){ 
		  customer_id = rs.getString("customer_id");
		  System.out.print(customer_id);
		  vehicle_number = rs.getString("vehicle_number");
		  customer_name = rs.getString("customer_name"); 
		  System.out.println(customer_name);
		  
		  vehicle_type = rs.getString("vehicle_type");
		  fuel_tank_capacity = rs.getString("fuel_tank_capacity");
		  sim_no = rs.getString("sim_no");
		  imei_no = rs.getString("imei_no");
		  camera_id = rs.getString("camera_id");
		  vehicle_mfg = rs.getString("vehicle_mfg");
		  max_speed = rs.getString("max_speed");
		  fuel_sender = rs.getString("fuel_sender");
		  empty_fuel_voltage = rs.getString("empty_fuel_voltage");
		  full_fuel_voltage = rs.getString("full_fuel_voltage");
		 
	  
   }
		
		connection.close();
		st.close();
		rs.close();


}catch(SQLException e){ System.err.println(e.getMessage()); } 

%>
<body onload="refresh();" onpageshow="if (event.persisted) noBack();" onunload="">



<div class="content_bg"><span class="content_headning">Vehicle Information</span></div>	
			
<form name="VehicleInfo" method="post">

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
		<input type="text" name="customer_id" value="<%=customer_id %>" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Vehicle Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="vehicle_number" value="<%=vehicle_number %>" disabled="disabled" size="25" class="tb"/>
	</td>
</tr> 
<tr>
	<td>
		Customer Name
	</td>
	<td>:</td>
	<td>
		<input type="text" name="customer_name" value="<%=customer_name %>" size="25" class="tb"/>
	</td>
</tr> 
<tr>
	<td>
		Mobile Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="Sim_no" value="<%=sim_no %>"  size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		IMEI Number
	</td>
	<td>:</td>
	<td>
		<input type="text" name="IMEI_no" value="<%=imei_no %>" size="25" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Camera ID
	</td>
	<td>:</td>
	<td>
		<input type="text" name="camera_id" value="<%=camera_id %>" size="25" class="tb"/>
	</td>
</tr>

<tr>
	<td>
		Vehicle Type
	</td>
	<td>:</td>
	<td>
		<input type="text" name="vehicle_type" value="<%=vehicle_type %>" size="25" class="tb"/>
	</td>
</tr>                      
<tr>
	<td>
		Vehicle Manufacturer
	</td>
	<td>:</td>
	<td>
		<input type="text" name="vechile_mfg" value="<%=vehicle_mfg %>" size="25" class="tb"/>
	</td>
</tr> 
<tr>
	<td>
		Vehicle Fuel Tank Capacity
	</td>
	<td>:</td>
	<td>
		<input type="text" name="fuel_capacity" value="<%=fuel_tank_capacity %>" size="25" class="tb"/>
	</td>
</tr>     
<tr>
	<td>
		Fuel Sender Unit
	</td>
	<td>:</td>
	<td>
        <select name="fuel_sender" style="width: 190px;" class="tb">
        <option><%=fuel_sender %></option>
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
		<input type="text" name="max_speed" value="<%=max_speed %>" size="5" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Empty Fuel Voltage
	</td>
	<td>:</td>
	<td>
		<input type="text" name="min_fuel_volt" value="<%=empty_fuel_voltage %>" size="5" class="tb"/>
	</td>
</tr>
<tr>
	<td>
		Full Fuel Voltage
	</td>
	<td>:</td>
	<td>
		<input type="text" name="max_fuel_volt" value="<%=full_fuel_voltage %>" size="5" class="tb"/>
	</td>
</tr>
<tr>	
	<td></td>
	<td colspan="2">
		<input type="submit" name="action1" value="Update" onclick="update();"/>
		<input type="submit" name="action1" value="Delete" onclick="delete1();"/>
	</td>
</tr>
</table>
</td>
</tr>
</table>
                   
</form> 

 </body> 
 </html>