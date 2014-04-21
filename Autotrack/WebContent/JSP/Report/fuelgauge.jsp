<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Date" import="java.text.*" import="java.util.Calendar"%>
     <%@page import="java.sql.*"%>
     <%@ page import ="java.util.Arrays"%>
    <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
    <%@ page import=" org.apache.commons.math.util.MathUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
   <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
    <script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
      google.load('visualization', '1', {packages:['gauge']});

      google.setOnLoadCallback(drawChart);
      
        
        <%
      //  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      //  Calendar cal = Calendar.getInstance();
      //  String Current_time = dateFormat.format(cal.getTime());
        
        
  	  
  	  String imeinumber = request.getParameter("vehicle_number");
  	  
  	  double fuel_from_db=0.00;
  	  double prev_fuel_from_db=0.00;
  	double	additional_fuel_from_db=0.00;
  	  double fuel_tank_capacity = 0.00;
  	 double empty_fuel_voltage = 0.00;
  	 double full_fuel_voltage = 0.00;
  	// double calculated_current_fuel = 0.00;
  	int current_fuel = 0;
  	//float fuel=.
  	 //int actual_fuel;
  	  
  	  try{
  	  DBTransaction dbtranobj=new DBTransaction();
  	  Connection connection=dbtranobj.connect();
  	  ResultSet rs = null;
  	//ResultSet rs1 = null;
  	  Statement st=null;
  	  st=connection.createStatement();
  	  rs = st.executeQuery("SELECT fuel FROM tracking WHERE imei_no ='"+imeinumber+"' and mile >='10' order by date_time desc limit 25 ");
  		while(rs.next()){ 
  	  	 
    	  fuel_from_db=(Double.parseDouble(rs.getString(1)));
    	//  if(prev_fuel_from_db=fuel_from_db;)
    	  System.out.println("actual fuel "+fuel_from_db);
    	  additional_fuel_from_db+=fuel_from_db;
    	 // System.out.println("additional fuel "+fuel_from_db);
    	 // System.out.println(fuel_from_db);
    	  //prev_fuel_from_db=fuel_from_db;
    	  }
  		fuel_from_db=additional_fuel_from_db/25;//average fuel
  		System.out.println("avg fuel "+fuel_from_db);
    		  
  	   rs = st.executeQuery("SELECT fuel_tank_capacity FROM vehicle_information WHERE imei_no ='"+imeinumber+"'");
  	  
  	while(rs.next()){ 
  	  	 
  		  //empty_fuel_voltage = (Double.parseDouble(rs.getString(1)));
  	     // full_fuel_voltage = (Double.parseDouble(rs.getString(2)));
    	  fuel_tank_capacity=rs.getDouble("fuel_tank_capacity");
    	  }
  		

	connection.close();
	st.close();
	rs.close();
  	  } catch(SQLException e) { 
  		  System.err.println(e.getMessage());
		} 
  	  
  	 /*  if(fuel_from_db>0.00)
  	  {
  		//calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
  	  } */
  	  if(fuel_from_db!=0.00)
  	  {
  	//calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
  	current_fuel = (int)(fuel_from_db*fuel_tank_capacity);
  	System.out.println("before round "+current_fuel);
  	current_fuel=(int)(MathUtils.round(current_fuel, -1));
  	System.out.println("After round "+current_fuel);
 	//System.out.println(MathUtils.round(current_fuel, -1));


  	  }
  	  
  	  else
  		  current_fuel=0;
  	  %>
        
        
        
  	
    function drawChart() {
  	  
      var data = google.visualization.arrayToDataTable([
        ['Label', 'Value'],
        ['Fuel', <%=current_fuel%>]
     ]);

     var maximum = <%=fuel_tank_capacity%>;
     //var redfrm = 0 - 10;
    // var redto = 0 - 20;
    // var yellowfrm = 0 - 20;
    // var yellowto = 0-25;


        var options = {
 	  max:maximum,
          width: 600, height: 300,
          redFrom:0, redTo: 15,
          yellowFrom:15, yellowTo:25,
	 
          minorTicks: 10
        };

        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
  <div class="content_bg"><span class="content_headning">Fuel Gauge</span></div>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
  	<tr><td align="center">
  <div id='chart_div'></div>
  	</td></tr>
  </table>
  </body>
</html>