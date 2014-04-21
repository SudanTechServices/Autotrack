<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%@page import="java.util.*"%>
    <%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<%
String IMEI = request.getParameter("IMEI");
String[] select = (String[])session.getAttribute("id"); 
String date = request.getParameter("date");
System.out.println("DATE "+date);

%>
<html>
<head>
<title></title>
<script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" 
            type="text/javascript"></script>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
<script type="text/javascript">
 
	function redirect_to_pdf(imeinumber,date)
	{
	  		document.pdf.action="UDR_TripSheet_PDF.jsp?IMEI="+imeinumber+"&date="+date+"";
		document.pdf.submit();
	}
	function redirect_to_excel(imeinumber,date)
	{
	    
		document.pdf.action="/Autotrack/UDR_TripSheet_Excel?IMEI="+imeinumber+"&date="+date+"";
		document.pdf.submit();
	}
	
	</script>  
 </head>    
<body>
<div class="content_bg"><span class="content_headning">Route Report</span></div><br/>
<div style="float:right; height: 24px;">
<form name="pdf" method="post" accept-charset="utf-8"> 
 <input type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=IMEI%>','<%=date%>');" ></input>
 <input type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=IMEI%>','<%=date%>');"></input> 
</form>
</div>


<div class="report_result"> Trip Sheet for :  <b><%=date %></b> <br></div>
	<table cellspacing="0" cellpadding="4" class="table_content" 
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
<tr>
<td style="padding: 10px; height: 20px;" class="report_heading" align="center">S.No</td>
<%
if (select != null && select.length != 0) {
	for (int i = 0; i < select.length; i++) {
		if(select[i].equalsIgnoreCase("no_of_locations") || select[i].equalsIgnoreCase("no_of_pickup_points") || select[i].equalsIgnoreCase("total_fare")){
						
		}
		
		else{
%>	
	
	<td  style="padding: 10px;" class="report_heading" align="center"><%=select[i].toUpperCase()%></td>
<%			}
		
   	}
	
} %>
</tr>
<%

try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet rs = null;
Statement st=null;
st=connection.createStatement();
//int x=ResultSet.TYPE_SCROLL_INSENSITIVE;
//System.out.println(x);

rs = st.executeQuery("SELECT * FROM trip_sheet WHERE date='"+date+"' order by sno");

int count = 1;

while(rs.next()){ 
	
%>
<tr>
<td style="padding : 5px;" class="table_inner_content"><center><%=count %></center></td>
<%
count  ++;	
			if (select != null && select.length != 0) {
				
							for (int i = 0; i < select.length; i++) {
								
										if(select[i].equalsIgnoreCase("no_of_locations") || select[i].equalsIgnoreCase("no_of_pickup_points") || select[i].equalsIgnoreCase("total_fare")){
											
											
											
										}
											else{
												%>
										
												<td style="padding : 5px;" class="table_inner_content"><%=rs.getString(select[i])%></td>
												
												<%
												
												}
										
							
											}
											
									}


%>

</tr>

<%
if(rs.isLast()){
	%>
	<%-- <div style="color: red; text-align: left; padding: 5px;">Vehicle Number :  <b style="color: blue"><%=rs.getString("vehicle_number") %></b> 
	| Driver :  <b style="color: blue"><%=rs.getString("driver_name") %></b> 
	| License Number : <b style="color: blue"><%=rs.getString("license_number") %></b>
	</div> --%>
	<div  class="report_result">Number of Records  :  <b><%=rs.getRow() %></b> <br></div>
	
	
	
	<%
	
	
}
}


if (select != null && select.length != 0) {
	
	for (int i = 0; i < select.length; i++) {
		                 
		
		//gives number of locations
		
						if(select[i].equalsIgnoreCase("vehicle_number")){
							
							rs = st.executeQuery("select count(DISTINCT vehicle_number) FROM trip_sheet WHERE date='"+date+"'");
							while(rs.next()){
								String no_of_vehicle = rs.getString(1);
																															
								%>
								
								<div  class="report_result">Number of Distinct Vehicle : <b><%=no_of_vehicle%></b> <br></div>
										
								<%
							}
						}
		
		//gives number of pick points 
		
							if(select[i].equalsIgnoreCase("driver_name")){
							
							rs = st.executeQuery("select count(DISTINCT driver_name) FROM student WHERE date='"+date+"'");
							while(rs.next()){
								String no_of_driver = rs.getString(1);
																															
								%>
								
								<div class="report_result">Number of Drivers : <b><%=no_of_driver%></b> <br></div>
										
								<%
							}
						}
						
		
							
			}
	}
%>



</table>
<%
connection.close();
st.close();
rs.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } %>


</body>

</html>
