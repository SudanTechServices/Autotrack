
<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<head>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
<%
     String vehiclenumber="";
	String imeinumber = request.getParameter("vehicle_number");
    // System.out.println(imeinumber);
	/* String startdate = request.getParameter("start_date");
	//System.out.println("Start Date:"+startdate);
	String enddate = request.getParameter("end_date");  */
	 String startdate,enddate;
    startdate=request.getParameter("start_date");
    enddate=request.getParameter("end_date");
	
	//request.getParameter("start_date");
	//System.out.println(request.getParameter("start_date"));
	//String date_in_form=request.getParameter("start_date").substring(0,19);
	/* System.out.println("FROM FORM "+date_in_form); */
	//String day_in_form=date_in_form.substring(3,5);
	/* System.out.println("DAY "+day_in_form); */
	//String month_in_form=date_in_form.substring(0, 2);
	/* System.out.println("MONTH " +month_in_form); */
	//String year_in_form=date_in_form.substring(6,10);
	/* System.out.println("YEAR " +year_in_form); */
	//String hr_in_form=date_in_form.substring(11,13);
	/* System.out.println("HOUR " +hr_in_form); */
	//String min_in_form=date_in_form.substring(14,16);
	/* System.out.println("MIN " +min_in_form); */
	//String sec_in_form=date_in_form.substring(17,19);
	/* System.out.println("SEC " +sec_in_form);  */
	//String startdate = year_in_form+"-"+month_in_form+"-"+day_in_form+" "+hr_in_form+":"+min_in_form+":"+sec_in_form;
	System.out.println("Start DATE "+startdate); 
	//String enddate_in_form=request.getParameter("end_date").substring(0,19);
	/* System.out.println("IN FORM END "+enddate_in_form); */
	//String endday_in_form=enddate_in_form.substring(3,5);
	///String endmonth_in_form=enddate_in_form.substring(0, 2);
	//String endyear_in_form=enddate_in_form.substring(6,10);
	//String endhr_in_form=enddate_in_form.substring(11,13);
	//String endmin_in_form=enddate_in_form.substring(14,16);
	///String endsec_in_form=enddate_in_form.substring(17,19)+".0";
	//String enddate =  endyear_in_form+"-"+endmonth_in_form+"-"+endday_in_form+" "+endhr_in_form+":"+endmin_in_form+":"+endsec_in_form;
	 System.out.println("End Date "+enddate);
	
	
%>

 <style type="text/css">

input.groovybutton
{
   font-size:11px;
   font-family:Comic Sans MS,sans-serif;
   font-weight:bold;
   color:#EEFFFF;
   width:102px;
   background-color:#0088DD;
   border-style:solid;
   border-color:#003377;
   border-width:2px;
}

</style>

<script language="javascript">

function goLite(FRM,BTN)
{
   window.document.forms[FRM].elements[BTN].style.color = "#FFFF99";
   window.document.forms[FRM].elements[BTN].style.backgroundColor = "#11AAEE";
}

function goDim(FRM,BTN)
{
   window.document.forms[FRM].elements[BTN].style.color = "#EEFFFF";
   window.document.forms[FRM].elements[BTN].style.backgroundColor = "#0088DD";
}

</script>
  
  <style type="text/css">
		tr:nth-child(even) {background: #f9f7f5}
		tr:nth-child(odd) {background: #FFF}
	</style>
 
 </head>
 <script type="text/javascript">
 
	function redirect_to_pdf(startdate,enddate,imeinumber)
	{
	    //alert('jhgdsfhjsdvgf');
		document.pdf.action="Fuel_Report_PDF.jsp?start_date="+startdate+"&end_date="+enddate+"&imeinumber="+imeinumber+"";
		document.pdf.submit();
	}
	function redirect_to_excel(startdate,enddate,imeinumber)
	{
		document.pdf.action="/Autotrack/Fuel_Excel_Report?startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"";
		document.pdf.submit();
	} 
	</script>  

 

 

<div class="content_bg"><span class="content_headning">Fuel Grid Report</span></div><br/>

 <div style="float: right;">
	<form name="pdf"  method="post" accept-charset="utf-8"> 
		 <input class="submit" type="submit" name="action" value="Export To Pdf" tabindex="3" id="export_pdf" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>','<%=vehiclenumber%>');"></input>
		 <input class="submit" type="submit" name="action" value="Export To Excel" tabindex="3" id="export_excel"  onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>  
	
	</form>
</div>

	<table cellspacing="0" cellpadding="4" class="table_content" id="mytable"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
	<tr>
			<th class="report_heading">Date</th>
			<th class="report_heading">Time</th>
			<th class="report_heading">Fuel in liters</th>				
		</tr>

<%
String fuel_in_ltr=null;
String date_time;
int mile=0;
int count = 0;
//String imeinumber = request.getParameter("vehicle_number");
double array_of_fuel[]=new double[10];
//String startdate = request.getParameter("start_date");
//String enddate = request.getParameter("end_date");
double fuel_from_db=0;
double first_good_fuel_value_double=0;
double current_good_fuel_value=0;
//double empty_fuel_voltage = 0.0;
//double full_fuel_voltage=0.0;
int fuel_tank_capacity=0;
//int calculated_fuel_value = 0;
double fuel_in_liters =0;
String am_pm;
String ses_hour;String date;
String fin_hr;String time;
double last_fuel_value_before_engine_stop=0.0;
int counter=0,continuecounter=0,offcounter=0,engine_start=0;
try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet rs = null;
Statement st=null;
st=connection.createStatement();

rs = st.executeQuery("SELECT fuel_tank_capacity FROM vehicle_information WHERE imei_no ='"+imeinumber+"'");
  while(rs.next()){ 
   fuel_tank_capacity=rs.getInt("fuel_tank_capacity");
	  }
  
  
rs = st.executeQuery("SELECT tracking.fuel,tracking.date_time,tracking.mile FROM tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"' order by date_time");
 if(rs.next())
{
	first_good_fuel_value_double= (Double.parseDouble(rs.getString("fuel")));
	current_good_fuel_value= (Double.parseDouble(rs.getString("fuel")));
	System.out.println("first_good="+first_good_fuel_value_double);
} 
while(rs.next()){ 
	
date_time = rs.getString("date_time");
mile=Integer.parseInt(rs.getString("mile"));
//String latitude = rs.getString("latitude_value"); 
//String longitude = rs.getString("longitude_value");
fuel_from_db=(Double.parseDouble(rs.getString("fuel")));
if(fuel_from_db==1.01)
	fuel_from_db=1;
String date_in_db=date_time.substring(0,10);
String day=date_in_db.substring(8,10);
String month=date_in_db.substring(5,7);
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
//System.out.println("Date "+day+" "+month+" "+year);
//System.out.println("Time "+time);
System.out.println("from db"+fuel_from_db);
if(fuel_from_db==0.00)
{
	engine_start=0;
	if(first_good_fuel_value_double==0)
	{
		if(offcounter==0)
		{
		%>
		<tr>
		<td class="report_border"><%= date %></td>
		<td class="report_border"><%= time %></td>
		  
		<%-- <td><center><%= fuel_from_db %></center></td>   --%>
		<td class="report_border">Engine is off</td> 
		</tr>
		<%
		}//offcounter
	}
	else
	{
		if(offcounter==0)
		{
		//calculated_fuel_value = ((first_good_fuel_value_double - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
	//	fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
		fuel_in_liters=(fuel_tank_capacity*(first_good_fuel_value_double*100))/100;
		fuel_in_liters=Math.floor(fuel_in_liters);	
		System.out.println("first " + fuel_in_liters);
		%>
		<tr>
		<td class="report_border"><%= date %></td>
		<td class="report_border"><%= time %></td>
		  
		<%-- <td><center><%= fuel_from_db %></td>   --%>
		<td class="report_border">Engine OFF</td> 
		</tr>
		<%
		}//offcounter
	}
	offcounter++;
	continuecounter=0;
	counter=0;
	first_good_fuel_value_double= fuel_from_db;//engine is still off
}
else// switch off the vehicle and again start the vehicle
{

	if(first_good_fuel_value_double==0.00)
	{
		
		if(!(engine_start>9))//after engine start just remove 5 transcation
		{
			if(mile>10){// skip 5 value where mile greater than 10
				engine_start++;
				System.out.println("skipping");
			}
			continue;
		}
		//engine_start++;
		last_fuel_value_before_engine_stop=current_good_fuel_value;
		System.out.println("last value= "+last_fuel_value_before_engine_stop);
		
		current_good_fuel_value=fuel_from_db;
		//System.out.println("current_good after engine start and theft fuel="+current_good_fuel_value);
		first_good_fuel_value_double=fuel_from_db;
		
		
		
		//if(current_good_fuel_value>(last_fuel_value_before_engine_stop+.01))
			
			
			
	//calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
	//fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
	System.out.println("FTC" +fuel_tank_capacity);
	System.out.println("FGV" +first_good_fuel_value_double);
	fuel_in_liters=(fuel_tank_capacity*(first_good_fuel_value_double*100))/100;
	fuel_in_liters=Math.floor(fuel_in_liters);	
	System.out.println("fifth " + fuel_in_liters);
	//fuel_in_ltr=""+fuel_in_liters+" Ltrs.";
	
	%>
	<tr>
	<td class="report_border"><%= date %></td>
	<td class="report_border"><%= time %></td>
	  
	<%-- <td><center><%= current_good_fuel_value %></center></td>   --%>
	<td class="report_border"><%= fuel_in_liters %></td> 
	</tr>
	<%
	continuecounter++;
	offcounter=0;
	counter=0;
	}
	else{	//first value from database is contain some voltage
		if(continuecounter==0)
		{
			current_good_fuel_value=fuel_from_db;
			//System.out.println("current_good after engine start and theft fuel="+current_good_fuel_value);
			first_good_fuel_value_double=fuel_from_db;
			
		//calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
		//fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
		System.out.println("FTC" +fuel_tank_capacity);
		System.out.println("FGV" +first_good_fuel_value_double);
		fuel_in_liters=(fuel_tank_capacity*(first_good_fuel_value_double*100))/100;
		fuel_in_liters=Math.floor(fuel_in_liters);	
		System.out.println("sixth " + fuel_in_liters);
		//fuel_in_ltr=""+fuel_in_liters+" Ltrs.";
		
		%>
		<tr>
			<td class="report_border"><%= date %></td>
			<td class="report_border"><%= time %></td>
			  
			<%-- <td><center><%= current_good_fuel_value %></center></td>   --%>
			<td class="report_border"><%= fuel_in_liters %></td> 
			</tr>
		<%
		continuecounter++;
		offcounter=0;
		counter=0;
		}
	}
	//if(fuel_from_db>first_good_fuel_value_double)
	/* if((fuel_from_db<=current_good_fuel_value) && (fuel_from_db>=current_good_fuel_value-0.10))
	{
		current_good_fuel_value=fuel_from_db;		
		System.out.println("current_good="+current_good_fuel_value);
	//maximum_fuel_value = 0.5;
	calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
	fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
	fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;	
	fuel_in_ltr=""+fuel_in_liters+" Ltrs.";
	counter=0; */
	
	//}//if +0.10
	}//else if
//count++;
}//while

connection.close();
st.close();
rs.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } %>

</table>


