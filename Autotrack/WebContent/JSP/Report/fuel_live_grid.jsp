<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%@page import="java.util.*"%>
 <%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" 
            type="text/javascript"></script>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" /> 

 
 <%
     String vehiclenumber="";
     String startdate="";
     String enddate="";
     //String imeinumber="";
	String imeinumber = request.getParameter("vehicle_number");
     //System.out.println(imeinumber);
	//String startdate = request.getParameter("start_date");
	//String enddate = request.getParameter("end_date"); 
%>
 <script type="text/javascript">
 
	function redirect_to_pdf(imeinumber)
	{
	   
		document.pdf.action="Fuel_Report_Live_PDF.jsp?imeinumber="+imeinumber+"";
		document.pdf.submit();
	}
	 function redirect_to_excel(imeinumber)
	{
		 	document.pdf.action="/Autotrack/Fuel_Live_Excel?imeinumber="+imeinumber+"";
			document.pdf.submit();
	} 
	</script>  
	</head>
	<body>
	<div class="content_bg"><span class="content_headning">Fuel Live Grid (Last 1 hour)</span></div>
<div style="float: right;">	
	 <form name="pdf" method="post" accept-charset="utf-8">
	  <input type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=imeinumber%>');"></input>
	  <input type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=imeinumber%>');"></input> 
	</form>   
</div>
<table cellspacing="0" cellpadding="2" class="table_content"
		style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
<tr>
			<th class="report_heading">Date</th>
			<th class="report_heading">Time</th>
			<th class="report_heading">Fuel voltge</th>
			<th class="report_heading">Fuel in liters</th>		
				
		</tr>
		<tr>
<%

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar cal = Calendar.getInstance();
cal.add(Calendar.HOUR, -1);
String Current_time = dateFormat.format(cal.getTime());
String strdate = dateFormat.format(new Date());
strdate = strdate.substring(0,10);
 enddate = dateFormat.format(new Date());
 startdate = dateFormat.format(cal.getTime());
   System.out.println(startdate);
   System.out.println(enddate);

String fuel_in_ltr=null;
int count = 0;
imeinumber = request.getParameter("vehicle_number");
//double array_of_fuel[]=new double[10];
//String startdate = timestamp1;
//String enddate = timestamp2;
double fuel_from_db=0.00;
double first_good_fuel_value_double=0.00;
double current_good_fuel_value=0.00;
double empty_fuel_voltage = 0.0;
double full_fuel_voltage=0.0;
double fuel_tank_capacity=0.0;
double calculated_fuel_value = 0.0;
double fuel_in_liters =0.0;
String am_pm;
String ses_hour;String date;
String fin_hr;String time;
int counter=0;
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
	System.out.println("first_good="+first_good_fuel_value_double);
} 
while(rs.next()){ 
String date_time = rs.getString("date_time");
String latitude = rs.getString("latitude_value"); 
String longitude = rs.getString("longitude_value");
fuel_from_db=(Double.parseDouble(rs.getString("fuel")));

String date_in_db=date_time.substring(0,10);
String day=date_in_db.substring(8,10);
String month=date_in_db.substring(5, 7);
String year=date_in_db.substring(0,4);
String hr=date_time.substring(11,13);
String min=date_time.substring(14,16);
int hour = Integer.parseInt(hr);
if( hour > 12){
	am_pm = "PM";
	hour = hour - 12;
	if(hour < 10){
		fin_hr = "0"+hour;
	}else{ fin_hr = ""+hour; }
	time = fin_hr + ":"+min+" "+am_pm;
}
else{ 
	am_pm = "AM";
	if(hour < 10){
		fin_hr = "0"+hour;
	}else{ fin_hr = ""+hour; }
	
	time = fin_hr + " : "+min+" "+am_pm;
}
date=day+"-"+month+"-"+year;
System.out.println("Date "+day+" "+month+" "+year);
System.out.println("Time "+time);
System.out.println("from db"+fuel_from_db);
if(fuel_from_db==0.00)
{
	if(counter==0)
	{
	%>
	<td align="left" class="report_border"><%= date %></td>
	<td align="left" class="report_border"><%= time %></td>
	  
	<td align="left" class="report_border"><%= fuel_from_db %></td>  
	<td align="left" class="report_border">Engine is off</td> 
	</tr>
	<tr>
	<%
	}
	counter++;
	first_good_fuel_value_double= fuel_from_db;//engine is still off
}
else if((fuel_from_db>=full_fuel_voltage) && (fuel_from_db<=empty_fuel_voltage))
	{
		if(first_good_fuel_value_double==0.00)
		{
			
			//first_good_fuel_value_double=fuel_from_db;//it become new voltage after engine start
			current_good_fuel_value=fuel_from_db;
			System.out.println("current_good after engine start="+current_good_fuel_value);
			first_good_fuel_value_double=fuel_from_db;
		}
		//if(fuel_from_db>first_good_fuel_value_double)
		if((fuel_from_db>=current_good_fuel_value) && (fuel_from_db<=current_good_fuel_value+0.10))
		{
			current_good_fuel_value=fuel_from_db;		
			System.out.println("current_good="+current_good_fuel_value);
		//maximum_fuel_value = 0.5;
		calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
		fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
		fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;
		fuel_in_ltr=""+fuel_in_liters+" Ltrs.";
		counter=0;
	%>
	<td align="left" class="report_border"><%= date %></td>
	<td align="left" class="report_border"><%= time %></td>
	  
	<td align="left" class="report_border"><%= current_good_fuel_value %></td>  
	<td align="left" class="report_border"><%= fuel_in_ltr %></td> 
	</tr>
	<%
	}//if +0.10
	}//else if
//count++;
}//while
connection.close();
st.close();
rs.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } %>

</table>
</body>
</html>

