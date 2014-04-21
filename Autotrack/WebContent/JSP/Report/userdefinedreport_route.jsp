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
<div class="content_bg"><span class="content_headning">Student Route Report</span></div>

<%
//String IMEI = request.getParameter("IMEI");
String[] select = (String[])session.getAttribute("id"); 
String route = request.getParameter("route");

//System.out.println(IMEI);



%>

<table border="1" style="background-color:#BDE6FC; font-family:Comic Sans MS,sans-serif; borderColor="black" cellPadding="0" cellSpacing="0" width="100%" height="63">

<tr>
<%
if (select != null && select.length != 0) {
	for (int i = 0; i < select.length; i++) {
%>
	<td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><b><%=select[i]%></b></center></td>
<%
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

rs = st.executeQuery("SELECT * FROM student WHERE routenumber='"+route+"'");


while(rs.next()){ 
%>
<tr>
<%
	
			if (select != null && select.length != 0) {
				
							for (int i = 0; i < select.length; i++) {
								
							
												%>
										
												<td><center><%=rs.getString(select[i])%></center></td>
										
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


</center>


