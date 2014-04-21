<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%@page import="java.util.*"%>
    <%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<%
String month_selected = request.getParameter("months").trim();
System.out.println(month_selected);
%>
<html>

<head>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />  

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
 <% String imeinumber = request.getParameter("vehicle_number");
 System.out.println(imeinumber); %>
<script type="text/javascript">
 
	function redirect_to_pdf(imeinumber,month_selected)
	{
	    
		document.pdf.action="Fuel_Monthly_Report_PDF.jsp?imeinumber="+imeinumber+"&month_selected="+month_selected+"";
		document.pdf.submit();
	}
	 function redirect_to_excel(imeinumber,month_selected)
	{
		document.pdf.action="/Autotrack/Fuel_Monthly_Excel?imeinumber="+imeinumber+"&month_selected="+month_selected+"";
		document.pdf.submit();
		
	} 
	</script>  
  </head>

<body>
	<div class="content_bg">
		<span class="content_headning">Fuel Monthly Grid : <%=month_selected %>
		</span>
	</div>
	
<div style="float:right;">
		<form name="pdf" method="post" accept-charset="utf-8"> 
			 <input type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=imeinumber%>','<%=month_selected%>');"></input>
			 <input type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=imeinumber%>','<%=month_selected%>');"></input> 
		</form>
</div>
<table cellspacing="0" cellpadding="2" class="table_content"
		style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
<tr>
			<th class="report_heading">Date</th>
			<th class="report_heading">Fuel voltge</th>
			<th class="report_heading">Fuel in liters</th>		
				
		</tr>
		<tr>
    	  <%
    	 String month = "01";
    	  int count =1;
    	  int mon = 1;
    	  int lastdate=0;
    	   //imeinumber = request.getParameter("vehicle_number");
    	  
    	  
      	  double fuel_tank_capacity = 0.00;
      	 double empty_fuel_voltage = 0.00;
      	 double full_fuel_voltage = 0.00;
       double fuel_from_db=0.00;
    	  double calculated_current_fuel = 0.0;
    	  double current_fuel = 0.00;
    	  String fuel_in_ltr=null;
    	  
    	  String am_pm;
    	  String ses_hour;String date;
    	  String fin_hr;String time;
    	  try{
    	  DBTransaction dbtranobj=new DBTransaction();
    	  Connection connection=dbtranobj.connect();
    	  ResultSet rs = null;
    	  Statement st=null;
    	  st=connection.createStatement();
    	  
    	  rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity FROM vehicle_information WHERE imei_no ='"+imeinumber+"'");
      	  
    	  	while(rs.next()){ 
    	  	  	 
    	  		  empty_fuel_voltage = (Double.parseDouble(rs.getString(1)));
    	  	      full_fuel_voltage = (Double.parseDouble(rs.getString(2)));
    	    	  fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
    	    	  
    	    	  }
    	  
    	 if(month_selected.equalsIgnoreCase("January")){
    		mon = 1;
    		lastdate = 31;
    	 } else if(month_selected.equalsIgnoreCase("February")){
     		mon = 2;
     		lastdate = 29;
     	 } 
    	 else if(month_selected.equalsIgnoreCase("March")){
      		mon = 3;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("April")){
      		mon = 4;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("May")){
      		mon = 5;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("June")){
      		mon = 6;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("July")){
      		mon = 7;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("August")){
      		mon = 8;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("September")){
      		mon = 9;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("October")){
      		mon = 10;
      		lastdate = 31;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("November")){
      		mon = 11;
      		lastdate = 30;
      	 } 
    	 else if(month_selected.equalsIgnoreCase("December")){
       		mon = 12;
       		lastdate = 31;
       	 } 
    	 
    	  	
    	  	
    	  for(count = 1; count<=lastdate; count++){
    		  
    	    System.out.println(count);
    	    System.out.println("month : "+mon);
    	    System.out.println("last date: "+lastdate);
    	    
    	   // String day = mon+"-"+count+"-2012";
    	    String day = count+"-"+mon+"-2012";
    	    
    	  rs = st.executeQuery("SELECT fuel FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+mon+"-"+count+"-2012 09:00:00' and date_time<='"+mon+"-"+count+"-2012 20:00:00' and fuel>'0.00' order by date_time desc limit 1");
    	  
    	  if(rs.next()){ 
    	 
    	  fuel_from_db=(Double.parseDouble(rs.getString("fuel")));
	
	    	  		calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
	  	            current_fuel = (calculated_current_fuel/100)*fuel_tank_capacity;
	  	            current_fuel = Math.round(current_fuel*100.0)/100.0;
	  	            fuel_in_ltr=""+current_fuel+" Ltrs.";
    	  		
    	 
    	  	%><tr>
			<td align="left" class="report_border"><%= day %></td>
			<td align="left" class="report_border"><%= fuel_from_db %></td>
			<td align="left" class="report_border"><%= fuel_in_ltr %></td>
		</tr>

    	  	<%
    	  	
    	  	}
    	  }
    	  connection.close();
    	  st.close();
    	  rs.close();
    	  }catch(SQLException e){ System.err.println(e.getMessage()); } %>
 </table>   	  
</body>
</html>