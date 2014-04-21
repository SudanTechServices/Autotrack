    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.Date" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="java.util.*"%>    
<%@ page import="com.ts.service.dropdown"%> 
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
 
<%

String customer = request.getParameter("customer_id");
System.out.println(customer);
String GetData=null;
int total_no_of_licence=0;
int remain_no_of_licence=0;

int count=0;

			try {
				
					    DBTransaction dbtranobj=new DBTransaction();
						Connection connection=dbtranobj.connect();
						Statement mystatement = connection.createStatement();
					
					ResultSet set = null;
					String longitude=null;
					
					GetData="select no_of_licence from customer_information where customer_id = '"+customer+"'";
					set = mystatement.executeQuery(GetData);
					
					while(set.next()){
						total_no_of_licence=Integer.parseInt(set.getString("no_of_licence"));
					
					}
					
					 GetData = "SELECT vehicle_number FROM vehicle_information where customer_id = '"+customer+"'";
					 set = mystatement.executeQuery(GetData);
				
					 List<String> vehicle=new ArrayList<String>();
					
					while(set.next()){
						
						vehicle.add(set.getString("vehicle_number"));
						count++;
						
					}//if close
					remain_no_of_licence = total_no_of_licence - count;
					
					String output = total_no_of_licence+"!"+remain_no_of_licence+"!"+vehicle;
					//output+="naseer";
					
					
					out.println(output);
					
					
					mystatement.close();
					connection.close();
					set.close();
					
				
					
					
	} catch (SQLException e) { e.printStackTrace();	}
	  catch (ClassNotFoundException e) { e.printStackTrace(); }
	  %>
