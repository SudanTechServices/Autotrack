
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
	//String endmonth_in_form=enddate_in_form.substring(0, 2);
	//String endyear_in_form=enddate_in_form.substring(6,10);
	//String endhr_in_form=enddate_in_form.substring(11,13);
//String endmin_in_form=enddate_in_form.substring(14,16);
	//String endsec_in_form=enddate_in_form.substring(17,19)+".0";
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
<form name="pdf" method="post" accept-charset="utf-8">
 
 <input class="groovybutton" type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>','<%=vehiclenumber%>');"></input>
 <input class="groovybutton" type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input> 
</form>
<center>
<div class="content_bg"><span class="content_headning">Fuel Grid Report</span></div>

<table border="1" style="background-color:#BDE6FC; font-family:Comic Sans MS,sans-serif; borderColor="black" cellPadding="0" cellSpacing="0" width="100%" height="63">

<tr>
  	  <td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Date</b></center></td>
   	  <td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Time</b></center></td>
	  <td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Fuel voltage</b></center></font></td>
 	  <td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Fuel in liters</b></center></td>
</tr>
<%
String fuel_in_ltr=null;

String am_pm;
String ses_hour;String date;
String fin_hr;String time;
double current_good_fuel_value=0.00;
double empty_fuel_voltage = 0.0;
double full_fuel_voltage=0.0;
double fuel_tank_capacity=0.0;
double calculated_fuel_value = 0.0;
double fuel_in_liters =0.0;

try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet rs = null;
Statement st=null;
st=connection.createStatement();

rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity,vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
if(rs.next())
{
	empty_fuel_voltage=(Double.parseDouble(rs.getString(1)));
	full_fuel_voltage=(Double.parseDouble(rs.getString(2)));
	fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
	vehiclenumber=rs.getString(4);
}
rs = st.executeQuery("SELECT fuel,date_time,engine_status from tracking WHERE fuel = (select max(fuel) from tracking where imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"')");
 while(rs.next())
{
	
	current_good_fuel_value= (Double.parseDouble(rs.getString("fuel")));
	System.out.println(current_good_fuel_value);

	String date_time = rs.getString("date_time");
	System.out.println("DATE IN DB "+date_time);
	String engine_status = rs.getString("engine_status");
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
	System.out.println("Date "+date);
	System.out.println("Time "+time);


calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;	

%>
	<td><center><%= date %></center></td>
	<td><center><%= time %></center></td>
	
	<td><center><%= current_good_fuel_value %></center></td>  
	<td><center><%= fuel_in_liters %></center></td> 
</tr>
<%
}//while

connection.close();
st.close();
rs.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } %>

</table>
</center>

