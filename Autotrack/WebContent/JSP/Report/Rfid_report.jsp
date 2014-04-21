<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<head>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
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
 
</script>
	
<%
	String imeinumber = request.getParameter("vehicle_number");

	String startdate = request.getParameter("start_date");
	String enddate = request.getParameter("end_date"); 
%>
<!-- Export Buttons Here -->


<%-- <form name="loginpage" method="post" accept-charset="utf-8">
 <input class="groovybutton" type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>');"></input>
 <input class="groovybutton" type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>');"></input>
</form>
 --%>



<center>

<div class="content_bg"><span class="content_headning">RFID Report</span></div>

<table border="1" style="background-color:#BDE6FC; font-family:Comic Sans MS,sans-serif; borderColor="black" cellPadding="0" cellSpacing="0" width="100%" height="63">


<tr>
  	<td width="200px"; style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Student Name</b></center></td>
	<td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>IDCardNumber</b></center></td>
	<td  style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Status</b></center></td>
	<td width="100px"; style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Date</b></center></td>
	<td width="100px"; style="color:#ffffff; background-color:#0088DD; padding: 10px";><center><b>Time</b></center></td>
	<td width="10px"; style="color:#ffffff; background-color:#0088DD; padding:10px;"><center><b>Route_No</b></center></td>
	<td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b>Pick_Point</b></center></td>
</tr>



<%


/* System.out.println(vehiclenumber);
System.out.println(startdate);
System.out.println(enddate); */

String first_name  = null;
String middle_name  = null;
String last_name= null;
String transport_number=null;
String id_card_number=null;
String bus_route_number=null;
String stopping_limits=null;
String status=null;




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
rs = st.executeQuery("SELECT student_attendance.imei_no,student.first_name,student.middle_name,student.last_name,student.id_card_number,student.bus_route_number,student.stopping_limits,student_attendance.status,student_attendance.date_time FROM public.student,public.student_attendance WHERE student.transport_id_number =student_attendance.rfid and date_time>='"+startdate+"' and date_time<='"+enddate+"' and imei_no='"+imeinumber+"' order by date_time ");


//int i=0; 
//int count = 0;
while(rs.next()){ 
	
String date_time = rs.getString("date_time");
first_name = rs.getString("first_name");
middle_name = rs.getString("middle_name");
last_name = rs.getString("last_name");
String imei=rs.getString("imei_no");

id_card_number = rs.getString("id_card_number");
bus_route_number=rs.getString("bus_route_number");
stopping_limits=rs.getString("stopping_limits");
status=rs.getString("status");

String date=date_time.substring(0,10);
String time=date_time.substring(10,19);
String student_name=first_name+"  "+middle_name+"  "+last_name;
System.out.println(student_name);

%>


<td><center><%= student_name %></center></td>
<td><center><%= id_card_number %></center></td>
<td><center><%= status %></center></td>
<td><center><%= date %></center></td>
<td><center><%= time %></center></td>
 <td><center><%= bus_route_number %></center></td> 
  <td><center><%= stopping_limits %></center></td>  
</tr>
<%



}

connection.close();
st.close();
rs.close();
}catch(SQLException e){ System.out.println(e.getMessage());
} %>

</table>
</center>
