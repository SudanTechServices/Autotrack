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
    	     ['Time', 'Fuel'],
    	  <%

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar cal = Calendar.getInstance();
cal.add(Calendar.HOUR, -1);
String Current_time = dateFormat.format(cal.getTime());
String strdate = dateFormat.format(new Date());
strdate = strdate.substring(0,10);
String enddate = dateFormat.format(new Date());
String startdate = dateFormat.format(cal.getTime());
   System.out.println(startdate);
   System.out.println(enddate);
    	  
    	  String fuel_in_ltr=null;
    	  int count = 0;
    	  String imeinumber = request.getParameter("vehicle_number");
    	  
    	 // double array_of_fuel[]=new double[10];
    	
    	  double fuel_from_db=0.00;
    	  double first_good_fuel_value_double=0.00;
    	  double current_good_fuel_value=0.00;
    	  double empty_fuel_voltage=0.0;
    	  double full_fuel_voltage=0.0;
    	  double fuel_tank_capacity=0.0;
    	  double calculated_fuel_value = 0.0;
    	  double fuel_in_liters =0.0;
    	  float plottedtime=0;
    	  String hoursmins=null;
    	  try{
    	  DBTransaction dbtranobj=new DBTransaction();
    	  Connection connection=dbtranobj.connect();
    	  ResultSet rs = null;
    	  Statement st=null;
    	  st=connection.createStatement();
    	  rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity from vehicle_information where imei_no='"+imeinumber+"'");
    	  if(rs.next())
    	  {
    	  	empty_fuel_voltage=(Double.parseDouble(rs.getString(1)));
    	  	full_fuel_voltage=(Double.parseDouble(rs.getString(2)));
    	  	fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
    	  	
    	  }
    	  rs = st.executeQuery("SELECT fuel,date_time FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
    	   if(rs.next())
    	  {
    	  	first_good_fuel_value_double= (Double.parseDouble(rs.getString("fuel")));
    	  	current_good_fuel_value= (Double.parseDouble(rs.getString("fuel")));
    	  	System.out.println("first_good="+first_good_fuel_value_double);
    	  } 
    	  while(rs.next()){ 
    	  String date_time = rs.getString("date_time");
    	 // String latitude = rs.getString("latitude_value"); 
    	  //String longitude = rs.getString("longitude_value");
    	  fuel_from_db=(Double.parseDouble(rs.getString("fuel")));

    	 String date1=date_time.substring(0,10);
    	  String time=date_time.substring(10,19);
    	  hoursmins = time.substring(0,6);
    	  //System.out.println("from db"+fuel_from_db);
    	 // System.out.println(hoursmins);
    	    String hour=time.substring(1,3);
    	  String minute=time.substring(4,6);
    	  String hourminute=hour+"."+minute;
    	 
    	  plottedtime=Float.parseFloat(hourminute);
    	 
    	  
    	  if(fuel_from_db==0.00)
    	  {
    	  	first_good_fuel_value_double= fuel_from_db;//engine is still off
    	  }
    	  else if((fuel_from_db>=full_fuel_voltage) && (fuel_from_db<=empty_fuel_voltage))
    	  	{
    	  		if(first_good_fuel_value_double==0.00)
    	  		{
    	  			
    	  			//first_good_fuel_value_double=fuel_from_db;//it become new voltage after engine start
    	  			current_good_fuel_value=fuel_from_db;
    	  			//System.out.println("current_good after engine start="+current_good_fuel_value);
    	  			first_good_fuel_value_double=fuel_from_db;
    	  		}
    	  		//if(fuel_from_db>first_good_fuel_value_double)
    	  		if((fuel_from_db>=current_good_fuel_value) && (fuel_from_db<=current_good_fuel_value+0.10))
    	  		{
    	  			current_good_fuel_value=fuel_from_db;		
    	  			//System.out.println("current_good="+current_good_fuel_value);
    	  		//maximum_fuel_value = 0.5;
    	  		calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
    	  		fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
    	  		fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;
    	  		//fuel_in_ltr=""+fuel_in_liters+" Ltr.";
    	  	%>
    	  			[<%=plottedtime%>,<%=fuel_in_liters%>],
    	  	<%
    	  	}//if +0.10
    	  	}//else if
    	  //count++;
    	  }//while
    	  connection.close();
    	  st.close();
    	  rs.close();
    	  }catch(SQLException e){ System.err.println(e.getMessage()); } %>

       /*  var data = google.visualization.arrayToDataTable([
          ['', 'Fuel Report'], */
          /* ['',  1000],
          ['',  1170],
          ['',  660], */
          [<%=plottedtime%>,<%=fuel_in_liters%>]
        ]);

        var options = {
          title: 'Fuel in Ltrs.',
        	 
        	  vAxes:[
						{title:'Fuel in litres',textStyle:{color: 'red', fontName:'italic', fontSize:15}} // Nothing specified for axis 0
						
						],
        hAxes:[
				{title:'Time',textStyle:{color: 'blue'}}, // Nothing specified for axis 0
				
				]
        
          
        };

        
        
        
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
    </head>
  <body>
	<div class="content_bg">
		<span class="content_headning">Fuel Live Report (Last 1 Hour)</span>
	</div>
	<table cellpadding="0" cellspacing="0" border="0" width="100%"
		align="center">
		<tr>
			<td align="center">
				<div id="chart_div" style="width: 100%; height: 325px;"></div>
			</td>
		</tr>
	</table>


</body>
</html>