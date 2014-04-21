<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%@page import="java.util.*"%>
    <%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<%
String IMEI = request.getParameter("IMEI");
String[] select = (String[])session.getAttribute("id"); 
String route = request.getParameter("route");

%>
<html>
<title></title>
<head>

<script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" 
            type="text/javascript"></script>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />    
 <script type="text/javascript">
 
	function redirect_to_pdf(IMEI,route)
	{
	    
		document.pdf.action="UDR_Route_PDF.jsp?IMEI="+IMEI+"&route="+route+"";
		document.pdf.submit();
	}
	function redirect_to_excel(IMEI,route)
	{
	   
		document.pdf.action="/Autotrack/UDR_Route_Excel?IMEI="+IMEI+"&route="+route+"";
		document.pdf.submit();
	}
	
	</script>   
 </head>
<body>
<div class="content_bg"><span class="content_headning">Route Report</span></div><br/>
<div style="float:right; height: 24px;">
<form name="pdf" method="post" accept-charset="utf-8"> 
 <input type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=IMEI%>','<%=route%>');"></input>
 <input type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=IMEI%>','<%=route%>');"></input> 
</form>
</div>
<br/>


<div class="report_result"> Route Number : <b><%=route %></b></div>
	<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">

<tr>
<td style="padding: 10px;" class="report_heading" align="center">S.No</td>
<%
if (select != null && select.length != 0) {
	for (int i = 0; i < select.length; i++) {
		if(select[i].equalsIgnoreCase("no_of_locations") || select[i].equalsIgnoreCase("no_of_pickup_points") || select[i].equalsIgnoreCase("total_fare")){
						
		}
		
		else{
%>	
	
	<td style="padding: 10px;" class="report_heading" align="center"><%=select[i].toUpperCase()%></td>
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

rs = st.executeQuery("SELECT * FROM student WHERE route_number='"+route+"' order by enrolment_number");

int count = 1;

while(rs.next()){ 
	
%>
<tr>
<td style="padding : 5px;" class="table_inner_content"><%=count %></td>
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
	<div class="report_result">Number of Students  :  <b><%=rs.getRow() %></b></div>
	
	
	
	<%
	
	
}
}


if (select != null && select.length != 0) {
	
	for (int i = 0; i < select.length; i++) {
		                 
		
		//gives number of locations
		
						if(select[i].equalsIgnoreCase("location")){
							
							rs = st.executeQuery("select count(DISTINCT location) FROM student WHERE route_number='"+route+"'");
							while(rs.next()){
								String no_of_locations = rs.getString(1);
																															
								%>
								
								<div class="report_result">Number of Locations : <b><%=no_of_locations%></b> <br></div>
										
								<%
							}
						}
		
		//gives number of pick points 
		
							if(select[i].equalsIgnoreCase("pick_point")){
							
							rs = st.executeQuery("select count(DISTINCT pick_point) FROM student WHERE route_number='"+route+"'");
							while(rs.next()){
								String no_of_pickpoint = rs.getString(1);
																															
								%>
								
								<div class="report_result">Number of Pick Points : <b><%=no_of_pickpoint%></b> <br></div>
										
								<%
							}
						}
						
		
		//gives total bus fare 
		
							
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


