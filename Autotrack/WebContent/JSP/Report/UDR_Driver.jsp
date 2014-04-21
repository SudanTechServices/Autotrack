<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%@page import="java.util.*"%>
    <%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<%
String vehicle_number = request.getParameter("vehicle_number");
String[] select = (String[])session.getAttribute("id"); 
String driver_name = request.getParameter("driver_name");

%>
<html>
<head>
<title></title>
<script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" 
            type="text/javascript"></script>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />   
<script type="text/javascript">
 
	function redirect_to_pdf(vehicle_number,driver_name)
	{
	    
		document.pdf.action="UDR_Driver_PDF.jsp?vehicle_number="+vehicle_number+"&driver_name="+driver_name+"";
		document.pdf.submit();
	}
	
	 function redirect_to_excel(vehicle_number,driver_name)
		{
			 	document.pdf.action="/Autotrack/UDR_Driver_Excel?vehicle_number="+vehicle_number+"&driver_name="+driver_name+"";
				document.pdf.submit();
		} 
	
	
	</script>  
	
	<style type="text/css">
		tr:nth-child(even) {background: #eee}
		tr:nth-child(odd) {background: #FFF}
	</style>
	
 </head> 
<body>
<div class="content_bg"><span class="content_headning">Driver Report</span></div><br/>
<div style="float:right; height: 24px;">
<form name="pdf" method="post" accept-charset="utf-8"> 
 <input type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=vehicle_number%>','<%=driver_name%>');" ></input>
 <input type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=vehicle_number%>','<%=driver_name%>');"></input> 
</form>
</div><br/>

<div class="report_result"> Driver's Name : <b><%=driver_name %></b></div>

	<table cellspacing="0" cellpadding="4" class="table_content" 
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
<tr>
<%
if (select != null && select.length != 0) {
	for (int i = 0; i < select.length; i++) {
		
%>
	<td style="padding: 10px;" class="report_heading" align="center"><%=select[i].toUpperCase()%></td>
<%			}
		
   	}
	
 %>
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

rs = st.executeQuery("SELECT * FROM driver_info WHERE driver_name='"+driver_name+"' order by driver_name");

while(rs.next()){ 
%>
<tr>
<%
	
			if (select != null && select.length != 0) {
				
							for (int i = 0; i < select.length; i++) {
								%>
										
												<td style="padding : 5px;" class="table_inner_content"><%=rs.getString(select[i])%></td>
								<%
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

</body>
</html>


