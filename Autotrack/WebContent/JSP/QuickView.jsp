<%@page import="java.sql.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.TimeUnit" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>
<%@ page errorPage="errorpage.jsp" %>
<META HTTP-EQUIV="REFRESH" CONTENT="50">

<html>
<head>
 <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>

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
geo = new GClientGeocoder();
function get_address(lat1,lang,noofid){
	//alert(noofid);
	//alert(lat1);
	//alert(lang);
	 var lat = lat1;
	    var lon = lang;
	    
       var search =''+lat+','+lon+'';
      
       // ====== Perform the Geocoding ======        
       geo.getLocations(search, function (result)
         { 
       	
           if (result.Status.code == G_GEO_SUCCESS) {
           
             for (var i=0; i<result.Placemark.length; i++) {
              /// var p = result.Placemark[i].Point.coordinates;
              // var marker = new GMarker(new GLatLng(p[1],p[0]));
              
              var addres=result.Placemark[i].address;
      
       if(addres=="")
    	   {
    	  // alert('blank');
    	   document.getElementById("msg"+noofid).innerHTML="Unable to find location";
    	   }
       else
    	   {
              document.getElementById("msg"+noofid).innerHTML =result.Placemark[i].address;
    	   }
        //alert("address");
             }
       
           }
           // ====== Decode the error status ======
           else {
             var reason="Code "+result.Status.code;
             if (reasons[result.Status.code]) {
               reason = reasons[result.Status.code];
             } 
             alert('Could not find "'+search+ '" ' + reason);
           }
         }
       );
	
}


</script>
 
 
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

<div class="content_bg"><span class="content_headning">Quick View</span></div>



<form name="pdf" method="post" accept-charset="utf-8">
 
  
</form>  






	<table cellspacing="0" cellpadding="2" class="table_content"
		style="width:98%; background-color: #fff; border: 1px solid #b1b1b1; border-radius:5px; margin:15px;">
		
		<tr>
			<th class="report_heading">Vehicle Number</th>
			<th class="report_heading">Date/Time</th>
			<th class="report_heading">Engine Status</th>
			<th class="report_heading">Speed (km/hr)</th>
			<th class="report_heading">Tank Capacity</th>			
			<th class="report_heading">Current Fuel</th>
			<th class="report_heading">Idle Time</th>			
		</tr>
		
		

<tr>
<%
String belongs=(String)session.getAttribute("belongs");
String vehicle_number,engine_status,mile,fuel,alarm_type,fence;
String date_time,halt_time,imei_no;




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
	SQL="select vehicle_information.vehicle_number,recent.imei_no,recent.alarm_type,recent.engine_status,date_time,recent.latitude_value,recent.longitude_value,recent.mile,recent.fuel from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no order by date_time";
}
else
{
	SQL="select vehicle_information.vehicle_number,recent.imei_no,recent.alarm_type,recent.engine_status,date_time,recent.latitude_value,recent.longitude_value,recent.mile,recent.fuel from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no where vehicle_information.customer_id='"+belongs+"'  order by date_time";
}
rs = st.executeQuery(SQL);
//rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");


//int count = 1;

while(rs.next()){ 
	vehicle_number=rs.getString("vehicle_number");
	imei_no=rs.getString("imei_no");
	engine_status=rs.getString("engine_status");
	date_time=rs.getString("date_time");
	mile=rs.getString("mile");
	fuel=rs.getString("fuel");
	alarm_type=rs.getString("alarm_type");
if(alarm_type==null)
	alarm_type="AA";
date_time=date_time.substring(0,16);
fuel=fuel.substring(2);
//System.out.println("after substring "+date_time);



		//System.out.println(noofid);
%>
<script type="text/javascript">
	
<%-- get_address(<%=latitude%>,<%=longitude%>,<%=noofid%>); --%>
 
</script>
<td align="left" class="report_border" style="background: #efefef;"><a href="../JSP/dashboardlivetracking.jsp?IMEI=<%=imei_no%>"target="Content"><%=vehicle_number %></a></td>
<td align="center" class="report_border"><%=date_time %></td>
<%
if(engine_status.equals("0"))
{
	
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	Date date=new Date();
	Date date2=new Date();
	//date_time="6/14/2013 11:25";
		date= df.parse(date_time);
	//   System.out.println(date);
		  String cur=df.format(date2);
		  date2= df.parse(cur);
//		  System.out.println(date2);
	//  System.out.println( new java.util.Date().getTime() - date.getTime());
	//  int diff = (int)(Math.abs(date.getTime() - date2.getTime()) / 1000)/60;
	// System.out.println(diff);
	halt_time = String.format("%d hour(s) %d min(s)", TimeUnit.MILLISECONDS.toHours(Math.abs(date.getTime() - date2.getTime())),
	         TimeUnit.MILLISECONDS.toMinutes(Math.abs(date.getTime() - date2.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(date.getTime() - date2.getTime()))));
	
%>
<td align="center" class="report_border" style="background: #efefef; padding-left: 10px;"><img alt="Engine Off" title="Engine Off" src="../images/off.png"></td>
<%
}
else
{
	halt_time="Running";
%>
	<td align="center" class="report_border" style="padding-left: 10px; background: #efefef;"><img alt="Engine On" src="../images/on.png" title="Engine On"></td>
<%
}
%>

<td align="center" class="report_border" style="width:8%;"><%=mile %></td>

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

<td align="center" class="report_border" style="width:8%; background: #efefef;"><%=fence %></td>
<td align="center" class="report_border" style="width:8%;"><%=fuel %></td>
<%

%>
	
	<td align="left" class="report_border" style="padding-left:15px; background: #efefef;"><%=halt_time %></td>
	
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
