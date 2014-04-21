<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
    <%@page import="java.util.*"%>
    <%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      
      function drawChart() {
    	  var data = google.visualization.arrayToDataTable([
    	      ['', 'Fuel In Litres'],
    	      ['',0],
    	  <%
    	  
    	  String month_selected = request.getParameter("months").trim();
    	     System.out.println(month_selected);
    	
    	
    	  String month = "01";
    	  int count =1;
    	  int mon = 1;
    	  int lastdate=0;
    	  String imeinumber = request.getParameter("vehicle_number");
    	  
    	  
      	  double fuel_tank_capacity = 0.00;
      	 double empty_fuel_voltage = 0.00;
      	 double full_fuel_voltage = 0.00;
       double fuel_from_db=0.00;
    	  double calculated_current_fuel = 0.0;
    	  double current_fuel = 0.00;
    	  
    	  
    	  
    	  try{
    	  DBTransaction dbtranobj=new DBTransaction();
    	  Connection connection=dbtranobj.connect();
    	  ResultSet rs = null;
    	  Statement st=null;
    	  st=connection.createStatement();
    	  
    	  rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity FROM vehicle_information WHERE imei_no ='"+imeinumber+"'");
      	  
    	  	while(rs.next()){ 
    	  	  	 
    	  		  empty_fuel_voltage = (Double.parseDouble(rs.getString(1)));
    	  	      full_fuel_voltage = (Double.parseDouble(rs.getString(2)));
    	    	  fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
    	    	  
    	    	  }
    	  
    	 if(month_selected.equalsIgnoreCase("January")){
    		mon = 1;
    		lastdate = 31;
    	 } else if(month_selected.equalsIgnoreCase("February")){
     		mon = 2;
     		lastdate = 29;
     	 } 
    	 else if(month_selected.equalsIgnoreCase("March")){
      		mon = 3;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("April")){
      		mon = 4;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("May")){
      		mon = 5;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("June")){
      		mon = 6;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("July")){
      		mon = 7;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("August")){
      		mon = 8;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("September")){
      		mon = 9;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("October")){
      		mon = 10;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("November")){
      		mon = 11;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("December")){
       		mon = 12;
       		lastdate = 31;
       	 } 
    	 
    	  	
    	  	
    	  for(count = 1; count<=lastdate; count++){
    		  
    	    System.out.println(count);
    	    System.out.println("month : "+mon);
    	    System.out.println("last date: "+lastdate);
    	    
    	  rs = st.executeQuery("SELECT fuel FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+mon+"-"+count+"-2012 09:00:00' and date_time<='"+mon+"-"+count+"-2012 20:00:00' and fuel>'0.00' order by date_time desc limit 1");
    	  
    	  if(rs.next()){ 
    	 
    	  fuel_from_db=(Double.parseDouble(rs.getString("fuel")));
	
	    	  		calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
	  	            current_fuel = (calculated_current_fuel/100)*fuel_tank_capacity;
	  	            current_fuel = Math.round(current_fuel*100.0)/100.0;
    	  		
    	 
    	  	%>
    	  			['<%=count%>',<%=current_fuel%>],
    	  	<%
    	  	
    	  	}
    	  }
    	  connection.close();
    	  st.close();
    	  rs.close();
    	  }catch(SQLException e){ System.err.println(e.getMessage()); } %>

       /*  var data = google.visualization.arrayToDataTable([
          ['', 'Fuel Report'], */
          /* ['',  1000],
          ['',  1170],
          ['',  660], */
          ['',<%=current_fuel%>]
        ]);

        var options = {
          title: 'Monthly Report : <%=month_selected%>',
        	 
        	  vAxes:[
						{title:'Fuel in litres',textStyle:{color: 'red', fontName:'italic', fontSize:15}} // Nothing specified for axis 0
						
						],
        hAxes:[
				{title:'Day',textStyle:{color: 'blue'}}, // Nothing specified for axis 0
				
				]
        
          
        };

       var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
   </head>
  
  <body>

  	<div class="content_bg"><span class="content_headning">Fuel Monthly Chart</span></div>
  	 	 	<table cellpadding="0" cellspacing="0" border="0" width="100%"
		align="center">
		<tr>
			<td align="center">
				    <div id="chart_div" style="width: 100%; height:325px;"></div>c
			</td>
		</tr>
	</table>

 
  </body>
</html>