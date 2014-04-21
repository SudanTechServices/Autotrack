		<%@page import="java.sql.*"%>
		<%@page import="java.text.DateFormat"%>
		<%@page import="java.text.ParseException"%>
		<%@page import="java.text.SimpleDateFormat"%>
		<%@page import="java.util.Calendar"%>
		<%@page import="java.util.Date"%>
		<%@page import="java.util.concurrent.TimeUnit" %>
		<%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>
		<%-- <%@ page errorPage="errorpage.jsp" %> --%>
		<!-- <META HTTP-EQUIV="REFRESH" CONTENT="50"> -->
		<%
		int count=0;
		String counter;
		int rowcount=0;
		%>
		<html>
		<head>
		 <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
		 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
		
		<script type="text/javascript">
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
			 var lat = lat1;
			    var lon = lang;
			    
		       var search =''+lat+','+lon+'';
		      
		       // ====== Perform the Geocoding ======        
		       geo.getLocations(search, function (result)
		         { 
		       	
		           if (result.Status.code == G_GEO_SUCCESS) {		           
		             for (var i=0; i<result.Placemark.length; i++) {		              
		              var addres=result.Placemark[i].address;
		              document.getElementById("firstlat"+noofid).innerHTML=addres;
		      
		       if(addres=="")
		    	   { 
		    	   document.getElementById("msg"+noofid).innerHTML="Unable to find location";
		    	   }
		       else
		    	   {
		              document.getElementById("msg"+noofid).innerHTML =result.Placemark[i].address;
		    	   }		       
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
		
		function previous(count){
			var counter = parseInt(count);
	//		alert(counter);
		//	alert("previous button");
			//var counter='<%=count-10%>';
			counter=counter-10;
		//	alert(counter);
			//counter=counter-10;
			 document.vehiclesummary.action="../JSP/VehicleSummary.jsp?offset="+counter+"";//it go to controllerservlet and after that it go to LoginService
				document.vehiclesummary.submit();
				
		}
		function next(count){
			var counter = parseInt(count);
		//	alert(counter);
		//	var counter='<%=count+10%>';
		counter=counter+10;
		//	alert(counter);
					
			 document.vehiclesummary.action="../JSP/VehicleSummary.jsp?offset="+counter+"";//it go to controllerservlet and after that it go to LoginService
				document.vehiclesummary.submit();
			
			
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
		<form name="vehiclesummary" method="post" accept-charset="utf-8"> 
		
		
		<div class="content_bg"><span class="content_headning">Vehicle Summary</span></div>
		
		
		 
		  
		
			<table cellspacing="0" cellpadding="4" class="table_content"
				style="width: 98%; background-color: #fff; border: 1px solid #b1b1b1; border-radius:5px; margin:15px;">
				
				<tr>
					<th class="report_heading" style="width:8%;">Vehicle Number</th>
					<th class="report_heading" style="width:10%;">Start Time</th>
					<th class="report_heading" >Start Point</th>
					<th class="report_heading" style="width:10%;">Current Status</th>
					<!-- <th class="report_heading">Current Position</th> -->
					<th class="report_heading" style="width:7%;">Start Fuel(Ltr)</th>			
					<th class="report_heading" style="width:8%;">Current Fuel(Ltr)</th>
					<th class="report_heading" style="width:10%;">Fuel Consumed(Ltr)</th>	
					<th class="report_heading" style="width:10%;">Fuel Summary</th>
					<th class="report_heading" style="width:10%;">Fuel Gauge</th>			
				</tr>
										
		<tr>
		<%
		
		
		counter=request.getParameter("offset");
		System.out.println("counter value="+counter);
		if(counter==null)
		{
			count=0;
			System.out.println("counter="+count+"");
		}
		else
		{
			count=Integer.parseInt(counter);
			System.out.println("else counter="+count+"");
			if(count<0)
				count=0;
			
		}
		Date date=new Date();
		Date date2=new Date();
		int diff,intfuel,intcurrentfuel;
		SimpleDateFormat df=null;
		String imei_no="",firstlat="",firstlong="",currentfuel="",currentlat="",currentlong="",currentengine="",fuelconsumed="";
		int fuelconsume;
		double fuel_tank_capacity;
		int fuelinltr,currentfuelinltr,consumefuelinltr;
		String belongs=(String)session.getAttribute("belongs");
		String vehicle_number,engine_status,mile,fuel,alarm_type,fence;
		String date_time,halt_time,newtime;
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//   Date d1=new Date();
		// System.out.println(d1);
		String datetime=sdf.format(cal.getTime());
		datetime=datetime.concat(" 00:00:00");
	//	System.out.println(datetime);
		
		int noofid=1;
		/* System.out.println(vehiclenumber);
		System.out.println(startdate);
		System.out.println(enddate); */
		
		try{
			DBTransaction dbtranobj=new DBTransaction();
			Connection connection=dbtranobj.connect();
		//Connection conn = null;
		//Class.forName("org.postgresql.Driver").newInstance();
		//conn = DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database","postgres", "postgres");
		ResultSet rs = null;
		Statement st=null;
		st=connection.createStatement();
		//System.out.println("belongs to ="+belongs);
		String SQL;
		
		if(belongs.equals("owner"))
		{
			SQL="SELECT DISTINCT ON (vehicle_information.vehicle_number) vehicle_information.vehicle_number,vehicle_information.fuel_tank_capacity, tracking.imei_no, tracking.date_time,tracking.engine_status,tracking.fuel,tracking.mile,tracking.latitude_value,tracking.longitude_value,recent.engine_status newengine,recent.fuel newfuel,recent.latitude_value newlat,recent.longitude_value newlong,recent.date_time newtime FROM tracking inner join vehicle_information on tracking.imei_no=vehicle_information.imei_no and engine_status='1' and tracking.date_time>'2013-10-04 00:00:00' left join recent on tracking.imei_no=recent.imei_no ORDER BY vehicle_information.vehicle_number, tracking.date_time limit 10 offset "+count+"";
		}
		else
		{
			SQL="SELECT DISTINCT ON (vehicle_information.vehicle_number) vehicle_information.vehicle_number,vehicle_information.fuel_tank_capacity, tracking.imei_no, tracking.date_time,tracking.engine_status,tracking.fuel,tracking.mile,tracking.latitude_value,tracking.longitude_value,recent.engine_status newengine,recent.fuel newfuel,recent.latitude_value newlat,recent.longitude_value newlong,recent.date_time newtime FROM tracking inner join vehicle_information on tracking.imei_no=vehicle_information.imei_no and vehicle_information.customer_id='"+belongs+"' and engine_status='1' and tracking.date_time >'"+datetime+"' left join recent on tracking.imei_no=recent.imei_no ORDER BY vehicle_information.vehicle_number, tracking.date_time limit 10 offset "+count+"";
		}
		rs = st.executeQuery(SQL);
		//rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
		//int count = 1;
		
		while(rs.next()){ 
			
		vehicle_number=rs.getString("vehicle_number");
		fuel_tank_capacity=rs.getDouble("fuel_tank_capacity");
		imei_no=rs.getString("imei_no");
		date_time=rs.getString("date_time");
		firstlat=rs.getString("latitude_value");
		firstlong=rs.getString("longitude_value");
		engine_status=rs.getString("engine_status");
		//mile=rs.getString("mile");
		fuel=rs.getString("fuel");
		
		currentengine=rs.getString("newengine");
		currentfuel=rs.getString("newfuel");
		
		currentlat=rs.getString("newlat");
		currentlong=rs.getString("newlong");
		newtime=rs.getString("newtime");
		//alarm_type=rs.getString("alarm_type");
		
		date_time=date_time.substring(0,16);
		
			if(currentengine.equals("1"))//it will find the eliminate the engine status ON data which is from last more than 5 min
			{
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
			//date= df.parse(date_time);
			date2= df.parse(newtime);
			diff = (int)(Math.abs(date.getTime() - date2.getTime()) / 1000)/60;
			
		//	System.out.println(diff);
				if(diff>5)
					currentengine="0";
			}
		
		fuel=fuel.substring(2);
			if(fuel.length()==1)
				fuel=fuel+"0";
		intfuel=Integer.parseInt(fuel);
		
		currentfuel=currentfuel.substring(2);
			if(currentfuel.length()==1)
				currentfuel=currentfuel+"0";
			intcurrentfuel=Integer.parseInt(currentfuel);
			
		fuelconsume=Integer.parseInt(fuel)-Integer.parseInt(currentfuel);
		  	 
			fuelinltr=(int)(fuel_tank_capacity*intfuel)/100;
			fuel=fuelinltr+"";	
			
			currentfuelinltr=(int)(fuel_tank_capacity*intcurrentfuel)/100;
			currentfuel=currentfuelinltr+"";
			
			consumefuelinltr=(int)(fuel_tank_capacity*fuelconsume)/100;
			fuelconsumed=consumefuelinltr+"";
			
		//fuelconsumed=""+fuelconsume+"";
		
		%>
		<script type="text/javascript">
			
	 get_address(<%=firstlat%>,<%=firstlong%>,<%=noofid%>); 
		 
		</script>
		 
		<td align="center" class="report_border" ><a href="../JSP/dashboardlivetracking.jsp?IMEI=<%=imei_no%>"target="Content"><%=vehicle_number %></a></td>
		<td align="center" class="report_border" style="background: #efefef;"><%=date_time %></td>
		<td align="left" class="report_border"  id="firstlat<%=noofid%>"><%=firstlat+","+firstlong %></td>
		<%if(currentengine.equals("0")) 
		{
			fuelconsumed="NA";
		%>
		<td align="center" class="report_border" style="padding-left: 10px; background: #efefef;">
		<img alt="Engine Off" src="../images/off.png"></td>
		<%
		}
		else
		{
		//	halt_time="Running";
		%>
			<td align="center" class="report_border" style="padding-left: 10px; background: #e1e2e4;">
			<img alt="Engine On" src="../images/on.png"></td>
		<%
		}
		%>
		<%-- <td align="center" class="report_border"><%= currentlat+","+currentlong%></td> --%>
		<td align="center" class="report_border"><%= fuel%></td>
		<td align="center" class="report_border" style="background: #efefef;"><%=currentfuel %></td>
		<td align="center" class="report_border"><%=fuelconsumed %></td>
		<td align="center" class="report_border" style="background: #efefef;"><a href="#" target="Content">Fuel Summary</a></td>
		<td align="center" class="report_border"><a href="../JSP/Report/fuelgauge.jsp?vehicle_number=<%=imei_no%>"target="Content">Fuel Guage</a></td>
		</tr>
		
		<%
		noofid++;
		rowcount++;
	}//while
	//	System.out.println("row count"+rowcount);
			%>
		</table>
				 <table  style="margin:0px 0px 0px 15px;" width="98%">
					 <tr>
						 <%
					 		if(count!=0){
						 %>
						<td style="width:97%"><input type ="image" src="../images/previous.png" value="Previous" style="float:right; " onclick="previous('<%=count%>')"></td>
						<%
							}
					 		else
					 		{
					 	%>
					 	<td style="width:97%"><img src="../images/previousdull.PNG" style="float:right; "></td>
					 	<%
					 		}
						 if(rowcount==10){
						%>
						
						<td><input type ="image" src="../images/next.png" value="Next" style="float:right;" onclick="next('<%=count%>')"></td>
						<%
							}
						 else
						 {
							%>
						<td><img src="../images/nextdull.png"  style="float:right;"></td>
						<%
							}
					 	%>
					</tr>
				</table>
			
			
			<%
		connection.close();
		rs.close();
		st.close();
		}catch(SQLException e){ System.out.println(e.getMessage()); } %>
		
		
			</form>
		</body>
		
		</html>
