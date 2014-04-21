<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<head>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
<%
	String imeinumber = request.getParameter("vehicle_number");
String startdate,enddate;
startdate=request.getParameter("start_date");
	request.getParameter("start_date");
	enddate=request.getParameter("end_date");
	//System.out.println(request.getParameter("start_date"));
	//String datelength=request.getParameter("start_date");
	//int len=datelength.length();
//	System.out.println(len);
	
	//String date_in_form=request.getParameter("start_date").substring(0,17);
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
	//String sec_in_form=date_in_form.substring(17,17);
	/* System.out.println("SEC " +sec_in_form);  */
	//startdate = year_in_form+"-"+month_in_form+"-"+day_in_form+" "+hr_in_form+":"+min_in_form+":"+sec_in_form;
	System.out.println("Start DATE "+startdate); 
	

	//String enddate_in_form=request.getParameter("end_date").substring(0,17);
	/* System.out.println("IN FORM END "+enddate_in_form); */
	//String endday_in_form=enddate_in_form.substring(3,5);
//	String endmonth_in_form=enddate_in_form.substring(0, 2);
	//String endyear_in_form=enddate_in_form.substring(6,10);
	//String endhr_in_form=enddate_in_form.substring(11,13);
	//String endmin_in_form=enddate_in_form.substring(14,16);
	//String endsec_in_form=enddate_in_form.substring(17,17);
	//enddate =  endyear_in_form+"-"+endmonth_in_form+"-"+endday_in_form+" "+endhr_in_form+":"+endmin_in_form+":"+endsec_in_form;
	 System.out.println("End Date "+enddate);  
%>

<!--  <style type="text/css">

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

</style> -->

<script type="text/javascript">

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
		tr:nth-child(even) {background: #eee}
		tr:nth-child(odd) {background: #FFF}
	</style>
 
 </head>
 <script type="text/javascript">
 
	function redirect_to_pdf(startdate,enddate,imeinumber)
	{
	    
		document.pdf.action="Speed_Repot_PDF.jsp?start_date="+startdate+"&end_date="+enddate+"&imeinumber="+imeinumber+"";
		document.pdf.submit();
	}
	 function redirect_to_excel(startdate,enddate,imeinumber)
	{
		document.pdf.action="/Autotrack/ExcelSpeedReport?startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"";
		document.pdf.submit();
	} 
	</script>
	

<!-- Export Buttons Here -->


 <body>
<div class="content_bg"><span class="content_headning">Speed Report</span></div><br/>
<div style="float: right;">
 <form name="pdf" method="post" accept-charset="utf-8"> 
 <input type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
  <input type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input> 
</form>
</div>


	<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">	
		
		<tr>
			<th class="report_heading">Date</th>
			<th class="report_heading">Time</th>
			<th class="report_heading">Speed(km/hr)</th>		
				
		</tr>

<tr>



<%


/* System.out.println(vehiclenumber);
System.out.println(startdate);
System.out.println(enddate); */

String latitude = null;
String longitude = null;
String am_pm;
String ses_hour;String date;
String fin_hr;String time;

try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
//Connection conn = null;
//Class.forName("org.postgresql.Driver").newInstance();
//conn = DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database","postgres", "postgres");
ResultSet rs = null;
Statement st=null;
st=connection.createStatement();
//rs = st.executeQuery("select * from tracking where imei_no='"+imeinumber+"' and  date_time >='"+startdate+"' and date_time <='"+enddate+"' ");
rs = st.executeQuery("SELECT tracking.mile,tracking.date_time FROM tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"' and cast(mile as int)>=60");

//int i=0; 
//int count = 0;
while(rs.next()){ 

String date_time = rs.getString("date_time");
//System.out.println("DATE "+date_time);
//String vehicle_no = rs.getString("vehicle_number");
//String location=rs.getString("mile");
/* String fuel = rs.getString("fuel"); */
String speed=rs.getString("mile");
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
//System.out.println("Date "+day+" "+month+" "+year);
//System.out.println("Time "+time);
float speed_from_db = Float.parseFloat(speed);
double one_mile = 1609.344;


double calculated_speed_value = ((speed_from_db)*(one_mile));
%>



<td align="left" class="report_border"><%= date %></td>
<td align="left" class="report_border"><%= time %></td>
<%--   <td><center><%= latitude %></center></td> 
  <td><center><%= longitude %></center></td>  --%>
<%-- <td><center><%= vehicle_no %></center></td> --%>
<%-- <td><center ><b id="<%=count%>"></b></center></td> --%>
<%-- <td><center><%= calculated_fuel_value %> % </center></td> --%>
<%-- <td><center><%= calculated_fuel_value %></center></td> --%>
<td align="left"  class="report_border"><%= speed %></td>



</tr><%
//System.out.println("Count="+count);
//System.out.println("I="+i);
//count++;


}

connection.close();
st.close();
rs.close();
}catch(SQLException e){ System.out.println(e.getMessage()); } %>

</table>

</body>
</html>
