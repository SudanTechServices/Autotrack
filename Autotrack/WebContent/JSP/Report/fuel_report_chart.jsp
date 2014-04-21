<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" import ="com.ts.dbtransactionmgr.DBTransaction"%>

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
    	  String fuel_in_ltr=null;
    	      String hour=null;
    	  int count = 0;
    	  String imeinumber = request.getParameter("vehicle_number");
    	  double array_of_fuel[]=new double[10];
    	  /* String startdate = request.getParameter("start_date");
    	  String enddate = request.getParameter("end_date"); */
    	  
    	  
    	  request.getParameter("start_date");
    		System.out.println(request.getParameter("start_date"));
    		String date_in_form=request.getParameter("start_date").substring(0,19);
    		/* System.out.println("FROM FORM "+date_in_form); */
    		String day_in_form=date_in_form.substring(3,5);
    		/* System.out.println("DAY "+day_in_form); */
    		String month_in_form=date_in_form.substring(0, 2);
    		/* System.out.println("MONTH " +month_in_form); */
    		String year_in_form=date_in_form.substring(6,10);
    		/* System.out.println("YEAR " +year_in_form); */
    		String hr_in_form=date_in_form.substring(11,13);
    		/* System.out.println("HOUR " +hr_in_form); */
    		String min_in_form=date_in_form.substring(14,16);
    		/* System.out.println("MIN " +min_in_form); */
    		String sec_in_form=date_in_form.substring(17,19);
    		/* System.out.println("SEC " +sec_in_form);  */
    		String startdate = year_in_form+"-"+month_in_form+"-"+day_in_form+" "+hr_in_form+":"+min_in_form+":"+sec_in_form;
    		System.out.println("Start DATE "+startdate); 
    		String enddate_in_form=request.getParameter("end_date").substring(0,19);
    		/* System.out.println("IN FORM END "+enddate_in_form); */
    		String endday_in_form=enddate_in_form.substring(3,5);
    		String endmonth_in_form=enddate_in_form.substring(0, 2);
    		String endyear_in_form=enddate_in_form.substring(6,10);
    		String endhr_in_form=enddate_in_form.substring(11,13);
    		String endmin_in_form=enddate_in_form.substring(14,16);
    		String endsec_in_form=enddate_in_form.substring(17,19)+".0";
    		String enddate =  endyear_in_form+"-"+endmonth_in_form+"-"+endday_in_form+" "+endhr_in_form+":"+endmin_in_form+":"+endsec_in_form;
    		 System.out.println("End Date "+enddate);
    	  
    	  
    	  
    	  double fuel_from_db=0.00;
    	  double first_good_fuel_value_double=0.00;
    	  double current_good_fuel_value=0.00;
    	  double calculated_fuel_value = 0.0;
    	  double empty_fuel_voltage = 0.0;
    	  double full_fuel_voltage=0.0;
    	  double fuel_tank_capacity=0.0;
    	  double fuel_in_liters =0.0;
    	  
    	  float plottedtime=0;
    	  
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
    	  rs = st.executeQuery("SELECT tracking.latitude_value,tracking.longitude_value,tracking.fuel,tracking.date_time FROM tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
    	   if(rs.next())
    	  {
    	  	first_good_fuel_value_double= (Double.parseDouble(rs.getString("fuel")));
    	  	current_good_fuel_value= (Double.parseDouble(rs.getString("fuel")));
    	  	//System.out.println("first_good="+first_good_fuel_value_double);
    	  } 
    	  while(rs.next()){ 
    	  String date_time = rs.getString("date_time");
    	  String latitude = rs.getString("latitude_value"); 
    	  String longitude = rs.getString("longitude_value");
    	  fuel_from_db=(Double.parseDouble(rs.getString("fuel")));

    	  String date=date_time.substring(0,10);
    	  String time=date_time.substring(10,19);
    	  hour=time.substring(1,3);
    	  String minute=time.substring(4,6);
    	  String hourminute=hour+"."+minute;
    	 
    	  plottedtime=Float.parseFloat(hourminute);
    	  //double hour_yaxis = Double.parseDouble(hour);
    	 // System.out.println("from db"+fuel_from_db);
    	  
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
    	  			/* System.out.println("Now = "+hour);
    	      	    System.out.println("previous hour = "+prev_time);
    	      	  	System.out.println("Both are different"); */
    	  			
    	  			current_good_fuel_value=fuel_from_db;		
    	  			//System.out.println("current_good="+current_good_fuel_value);
    	  		//maximum_fuel_value = 0.5;
    	  		calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
				fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
    	  		fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;
    	  		//fuel_in_ltr=""+fuel_in_liters+" Ltr.";
    	  			System.out.println(hourminute);
    	  			
    	  	%>
    	  			['',<%=fuel_in_liters%>],
    	  	<%
    	  	
    	  	}//if +0.10
    	  	}//else if
    	  //count++;
    	  //prev_time = hour; 
    	  }//while

connection.close();
st.close();
rs.close();
    	  }catch(SQLException e){ System.err.println(e.getMessage()); } %>

       /*  var data = google.visualization.arrayToDataTable([
          ['', 'Fuel Report'], */
        
          ['',<%=fuel_in_liters%>]
        ]);

        var options = {
                title: 'Fuel in Ltrs.',
              	 
              	  vAxes:[
      						{title:'Fuel in litres',textStyle:{color: 'red', fontName:'italic', fontSize:15}} // Nothing specified for axis 0
      						
      						],
      						hAxes:[
      	      						{title:'Time',textStyle:{color: 'red', fontName:'italic', fontSize:15}} // Nothing specified for axis 0
      	      						
      	      						]
            
                
              };

        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
      </script>
      </head>
      <body>
        <div class="content_bg"><span class="content_headning">Fuel Chart View</span></div>  
        <div id="chart_div" style="width:100%; height: 330px;"></div>
      </body>
    </html>