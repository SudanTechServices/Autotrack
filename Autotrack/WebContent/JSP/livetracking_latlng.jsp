<%-- <%@page import="org.apache.naming.java.javaURLContextFactory"%> --%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Date" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>

<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
 
<%
		String IMEI = request.getParameter("imei");

				try {
					    DBTransaction dbtranobj=new DBTransaction();
						Connection connection=dbtranobj.connect();
					
					
					String latitude=null,fuel=null,mile=null,SQL=null,Driver_name=null,engine_status = null;
					ResultSet set = null;
					String longitude=null;
					String speed=null;
					
									
					String GetData = "SELECT latitude_value,longitude_value,mile,fuel,engine_status FROM tracking where imei_no='"+IMEI+"'order by date_time desc limit 1";
					
					Statement mystatement = connection.createStatement();
					set = mystatement.executeQuery(GetData);
					
					while(set.next()){
						
					latitude = set.getString("latitude_value");
					longitude = set.getString("longitude_value");
					speed = set.getString("mile");
					fuel = set.getString("fuel");
					engine_status = set.getString("engine_status");
										
					}//if close
					
					mystatement.close();
					connection.close();
					set.close();
					
					out.println(latitude+","+longitude+","+speed+","+fuel+","+engine_status);
					
					connection.close();
					mystatement.close();
					set.close();
	} catch (SQLException e) { e.printStackTrace();	}
	  catch (ClassNotFoundException e) { e.printStackTrace(); }


%>

