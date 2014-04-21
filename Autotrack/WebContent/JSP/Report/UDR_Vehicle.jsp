<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%@page import="java.util.*"%>
    <%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" 
            type="text/javascript"></script>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />    
<center>
<div class="content_bg"><span class="content_headning">Vehicle Report</span></div>

<%
String vehicle_number = request.getParameter("vehicle_number");
String[] select = (String[])session.getAttribute("id"); 
//String route = request.getParameter("route");

%>
<div style="color: red; text-align: left; padding: 5px;"> Vehicle Number :  <b style="color: blue"><%=vehicle_number %></b></div>
	<table cellspacing="0" cellpadding="4" class="table_content" 
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">

<tr>
<%
if (select != null && select.length != 0) {
	for (int i = 0; i < select.length; i++) {
		if(select[i].equalsIgnoreCase("customer_name")){
			%>
			<td style="color:#ffffff; background-color:#0088DD; padding: 10px;"><center>OWNED_BY</center></td>
		<%
		}else{
%>
	<td style="color:#ffffff; background-color:#0088DD; padding: 10px;"><center><%=select[i].toUpperCase()%></center></td>
<%
		}
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

rs = st.executeQuery("SELECT * FROM public.vehicle_information,public.driver_info WHERE vehicle_information.vehicle_number = driver_info.vehicle_number AND vehicle_information.vehicle_number='"+vehicle_number+"'");

while(rs.next()){ 
%>
<tr>
<%
	
			if (select != null && select.length != 0) {
				
							for (int i = 0; i < select.length; i++) {
								
												if(select[i].equalsIgnoreCase("fuel_tank_capacity")){
													%>										
													<td style="padding : 5px;"><%=rs.getString(select[i])%> litres</td>
													<%	
												}else{
												%>										
												<td style="padding : 5px;"><%=rs.getString(select[i])%></td>
												<%
												}
											}
											
									}


%>

</tr>

<%

}

%>



</table>
<%
connection.close();
st.close();
rs.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } %>


</center>


