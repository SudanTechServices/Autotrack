<%@page import="java.sql.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.TimeUnit" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>
<%@ page errorPage="errorpage.jsp" %>
<!-- <META HTTP-EQUIV="REFRESH" CONTENT="50"> -->

<html>
<head>
 <link rel="stylesheet" type="text/css" href="../CSS/style.css" />


 </head>
 <script type="text/javascript">
 
	function redirect_to_pdf(startdate,enddate,imeinumber)
	{
	    //alert('jhgdsfhjsdvgf');
		document.pdf.action="Engine_Report_PDF.jsp?start_date="+startdate+"&end_date="+enddate+"&imeinumber="+imeinumber+"";
		document.pdf.submit();
	}
	 function redirect_to_excel(startdate,enddate,imeinumber)
	{
		document.pdf.action="/Autotrack/Excel_Engine_Status_Report?startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"";
		document.pdf.submit();
	} 
	</script>
	

<!-- Export Buttons Here -->


 <%-- <form name="pdf" method="post" accept-charset="utf-8">
 
 <input class="groovybutton" type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
  <input class="groovybutton" type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input> 
</form> --%>
 
<body>

<div class="content_bg"><span class="content_headning">RFID Status</span></div>

<form name="pdf" method="post" accept-charset="utf-8">
 
  
</form>  
	<table cellspacing="0" cellpadding="2" class="table_content"
		style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
		
		<tr>
			<th class="report_heading">RFID #</th>
			<th class="report_heading">Date/Time</th>
			<th class="report_heading">RFID Status</th>
			<th class="report_heading">Location</th>
			
		</tr>
		
		

<tr>
<%
String imeinumber = request.getParameter("vehicle_number");
String belongs=(String)session.getAttribute("belongs");
String vehicle_number,engine_status="",mile="",fuel="",alarm_type="",fence;
String date_time,halt_time,imei_no,rfid,location,status_byte;


/* System.out.println(vehiclenumber);
System.out.println(startdate);
System.out.println(enddate); */

try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
//Connection conn = null;
//Class.forName("org.postgresql.Driver").newInstance();
//conn = DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database","postgres", "postgres");
ResultSet rs = null;
Statement st=null;
st=connection.createStatement();
System.out.println("belongs to ="+belongs);
String SQL;
if(belongs.equals("owner"))
{
	SQL="select imei_no,status_byte,date_time,rfid,location from tracking where imei_no='"+imeinumber+"' order by date_time";
}
else
{
	SQL="select imei_no,status_byte,date_time,rfid,location from tracking where imei_no='"+imeinumber+"' order by date_time";
}
rs = st.executeQuery(SQL);
//rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");


//int count = 1;

while(rs.next()){ 
rfid=rs.getString("rfid");
date_time=rs.getString("date_time");
imei_no=rs.getString("imei_no");
status_byte=rs.getString("status_byte");
location=rs.getString("location");
//date_time=rs.getString("date_time");
//mile=rs.getString("mile");
//fuel=rs.getString("fuel");
//alarm_type=rs.getString("alarm_type");
date_time=date_time.substring(0,16);
//fuel=fuel.substring(2);
//System.out.println("after substring "+date_time);



		//System.out.println(noofid);
%>
<script type="text/javascript">
	
<%-- get_address(<%=latitude%>,<%=longitude%>,<%=noofid%>); --%>
 
</script>
<%-- <td align="left" class="report_border"><%=vehicle_number %></a></td> --%>
<td align="left" class="report_border"><%=rfid %></td>
<td align="left" class="report_border"><%=date_time %></td>
<td align="left" class="report_border"><%=status_byte %></td>
<td align="left" class="report_border"><%=location %></td>
<%
DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

Date date=new Date();
Date date2=new Date();
//date_time="6/14/2013 11:25";
	date= df.parse(date_time);
//   System.out.println(date);
	  String cur=df.format(date2);
	  date2= df.parse(cur);
	  if(engine_status.equals("1")){
			int diff = (int)(Math.abs(date.getTime() - date2.getTime()) / 1000)/60;
			System.out.println(diff);
			if(diff>3)
					engine_status="0";
	  		}
if(engine_status.equals("0"))
{
	mile="0";
	fuel="0";
	/* DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	Date date=new Date();
	Date date2=new Date();
	//date_time="6/14/2013 11:25";
		date= df.parse(date_time);
	//   System.out.println(date);
		  String cur=df.format(date2);
		  date2= df.parse(cur); */
//		  System.out.println(date2);
	//  System.out.println( new java.util.Date().getTime() - date.getTime());
	 // int diff = (int)(Math.abs(date.getTime() - date2.getTime()) / 1000)/60;
	// System.out.println(diff);
	halt_time = String.format("%d hour(s) %d min(s)", TimeUnit.MILLISECONDS.toHours(Math.abs(date.getTime() - date2.getTime())),
	         TimeUnit.MILLISECONDS.toMinutes(Math.abs(date.getTime() - date2.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(date.getTime() - date2.getTime()))));
	
%>

<%
}
else
{
	halt_time="Running";
%>

<%
}
%>



<%
if(alarm_type.equals("42"))
{
fence="OUT";
}
else
{
fence="IN";
}
%>

<%

%>
	

	
</tr>
<%

}//while
connection.close();
rs.close();
st.close();
}catch(SQLException e){ System.out.println(e.getMessage()); } %>

</table>

</body>
</html>
