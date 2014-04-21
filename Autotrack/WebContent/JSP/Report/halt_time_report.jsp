<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.Date"%> 
<%@page import="java.util.concurrent.TimeUnit" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.List" %>
<%@page import="java.util.LinkedList" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.LinkedHashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Set" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>

<html>
<head>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
 
 
	
 <%!

 public Map<String,Object> checkLocExists(Map<String,String> mp,String lati,String langi)
 {
     boolean r = false;
     Map<String,Object> res = new HashMap<String,Object>();
     double dlat = Double.parseDouble(lati);
     double dlon = Double.parseDouble(langi);
    System.out.println("Dlat-------------:"+dlat+" dlong-------------:"+dlon);
     DecimalFormat dft = new DecimalFormat("#0.00");
     String rkey = "";
     rkey = dft.format(dlat)+"$"+dft.format(dlon);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     
     rkey = dft.format(dlat+.01)+"$"+dft.format(dlon);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat+.01)+"$"+dft.format(dlon+.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat+.01)+"$"+dft.format(dlon-.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat-.01)+"$"+dft.format(dlon+.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat)+"$"+dft.format(dlon+.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat-.01)+"$"+dft.format(dlon);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat)+"$"+dft.format(dlon-.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat-.01)+"$"+dft.format(dlon-.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat-.01)+"$"+dft.format(dlon+.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     rkey = dft.format(dlat+-.01)+"$"+dft.format(dlon-.01);
     if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
     }
     res.put("isexist", r);
     return res;
 }
 
 %>
<%
	String imeinumber = request.getParameter("vehicle_number");
    System.out.println("IMEI"+imeinumber);
    String startdate,enddate;
    startdate=request.getParameter("start_date");
    enddate=request.getParameter("end_date");
	System.out.println("Start DATE "+startdate); 
	System.out.println("End Date "+enddate);  
	
	int input_halt_time=Integer.parseInt(request.getParameter("halt_timing"));
	
	
	
%>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
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

function tabletest()
{
	var cells = new Array();
            
			$('#myTable tbody tr ').each(function(idex){

				var v = $(this).find(".latlan").val();			
				if(v)
				{
					if(idex >11 && idex<=22){
						alert("Printing "+idex+"th row Click OK After one Second");
					}
					if(idex >22 && idex<=33){
						alert("Printing "+idex+"th row Click OK After one Second");
					} if(idex >33 && idex<=44){
						alert("Printing "+idex+"th row Click OK After one Second");
					}
					if(idex >44 && idex<=55){
						alert("Printing "+idex+"th row Click OK After one Second");
					} 
					if(idex >55 && idex<=66){
						alert("Printing "+idex+"th row Click OK After one Second");
					}
					if(idex >66 && idex<=75){
						alert("Printing "+idex+"th row Click OK After one Second");
					}
				 var geo = new GClientGeocoder();
				// ====== Perform the Geocoding ======        
				geo.getLocations(v, function (result)
				  { 										
					if (result.Status.code == G_GEO_SUCCESS) {						 
					  for (var i=0; i<result.Placemark.length; i++) {
					 document.getElementById("msg"+idex).innerHTML =result.Placemark[i].address;												
					 
					  }
				
					}
					// ====== Decode the error status ======
					else {
					  var reasons="Code "+result.Status.code;
					 if (reasons = "Code 620"){
						 document.getElementById("msg" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
				}
					  if (reasons[result.Status.code]) {
						reasons = reasons[result.Status.code];
					  } 
					  document.getElementById("msg" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
					}
				  }
				);
				
                
				}
			
					

            });
            console.log(cells);
}



  </script>
 
  <style type="text/css">
		tr:nth-child(even) {background: #f9f7f5}
		tr:nth-child(odd) {background: #FFF}
	</style>
 </head>
  <script type="text/javascript">
 
	function redirect_to_pdf(startdate,enddate,imeinumber)
	{
	
	    var xmlStr = "<root>";
	    $('#mytable tbody tr').each(function() {
	       
	        if (!this.rowIndex) return; // skip first row
	       // alert("Thisss"+this);
	        xmlStr += "<record>"+
	                  "<place>"+this.cells[0].innerHTML+"</place>"+
	                  "<mintime>"+this.cells[1].innerHTML+"</mintime>"+
	                  "<maxtime>"+this.cells[2].innerHTML+"</maxtime>"+
	                  "<halttime>"+this.cells[3].innerHTML+"</halttime>"+
	                  "</record>";
	    });
	    
		xmlStr +="</root>"
	   // alert("xmlstr"+ xmlStr);
	
		 document.pdf.action="halt_time_report_xml.jsp?xmlstr="+xmlStr+"&startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"";	 	
		document.pdf.submit(); 
	}
	function redirect_to_excel(startdate,enddate,imeinumber)
	{
		//alert("Start date is ::"+startdate);
		 var xmlStr = "<root>";
		    $('#mytable tbody tr').each(function() {
		       
		        if (!this.rowIndex) return; // skip first row
		        xmlStr += "<record>"+
		                  "<place>"+this.cells[0].innerHTML+"</place>"+
		                  "<mintime>"+this.cells[1].innerHTML+"</mintime>"+
		                  "<maxtime>"+this.cells[2].innerHTML+"</maxtime>"+
		                  "<halttime>"+this.cells[3].innerHTML+"</halttime>"+
		                  "</record>";
		    });
			xmlStr +="</root>"
		/*     alert( "xmlStr  asa  "+xmlStr); */
			
			document.pdf.action="halt_time_report_xml_excel.jsp?xmlstr="+xmlStr+"&startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"";
			document.pdf.submit(); 
	} 
	</script> 
	

<!-- Export Buttons Here -->


 <%-- <form name="pdf" method="post" accept-charset="utf-8">
 
 <input class="groovybutton" type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
  <input class="groovybutton" type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input> 
</form> --%>
 
<body onload="tabletest()">
<!-- <label id="msg"></label> -->
<div class="content_bg"><span class="content_headning">Halt Time Report</span></div><br/>

<div style="float: right;">
	<form name="pdf"  method="post" accept-charset="utf-8"> 
		 <input class="submit" type="submit" name="action" value="Export To Pdf" tabindex="3" id="export_pdf" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
		 <input class="submit" type="submit" name="action" value="Export To Excel" tabindex="3" id="export_excel"  onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>  
	
	</form>
</div>		
		
	<table cellspacing="0" cellpadding="4" class="table_content" id="mytable"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
		
		<tr>
			<th class="report_heading">Place</th>
			<th class="report_heading">Stopped at</th>
			<th class="report_heading">Stopped till</th>
			<th class="report_heading">Halt Time</th>						
		</tr>

<%


		int offcounter=0,oncounter=0;
		String latitude = null;
		String longitude = null;
		String am_pm;int counter = 0;
		String ses_hour;String date;
		String fin_hr;String time;
		Date min_time = null;Date max_time = null;
		String diff = "";
		String min_diff= "";
		String minimum_time = "";
		String maximum_time = "";
		int minute_diff = 0;
		int count = 1;
		String latitude_value = "";
		String longitude_value = "";
		String lat = "";
		String lon = "";
		Date prev_time = null;
		Date current_time = null;
		String mapKey = "";
		String halt_time = "";
		String previous_time = "";
		String crnt_time = "";
		boolean isstopped = false;
		List halt_time_list = new LinkedList(); 
		Map haltTimeMap = new LinkedHashMap();
		HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();
		
		try{
			DBTransaction dbtranobj=new DBTransaction();
			Connection connection=dbtranobj.connect();
		ResultSet rs = null;
		Statement st=null;
		st=connection.createStatement();
		rs = st.executeQuery("SELECT latitude_value,longitude_value,tracking.engine_status,tracking.date_time FROM tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//int count = 1;
		int datacnt = 1;
		if(rs.next()){
			
		}
		else{
			%>
			<script type="text/javascript">
			document.getElementById("mytable").style.display='none';		
			document.getElementById("export_pdf").style.display='none';
			document.getElementById("export_excel").style.display='none';
			</script>
				<h1><font color="red"><center>No Data Found </center></font></h1>
		<%
		}
		while(rs.next()){ 
		
		String date_time = rs.getString("date_time");
		String lat_value=rs.getString("latitude_value");
		String long_value=rs.getString("longitude_value");
		String engine_status = rs.getString("engine_status");
		String date_in_db=date_time.substring(0,10);
		String day=date_in_db.substring(8,10);
		String month=date_in_db.substring(6, 7);
		String year=date_in_db.substring(0,4);
		String hr=date_time.substring(11,13);
		String min=date_time.substring(14,16);
		int hour = Integer.parseInt(hr);
		Date datetime=df.parse(date_time);
		if( hour > 12){
			am_pm = "PM";
			hour = hour - 12;
			if(hour < 10){
				fin_hr = "0"+hour;
			}else{ fin_hr = ""+hour; }
			time = fin_hr + ":"+min+" "+am_pm;
		}
		else{ 
			am_pm = "AM";
			if(hour < 10){
				fin_hr = "0"+hour;
			}else{ fin_hr = ""+hour; }
			
			time = fin_hr + " : "+min+" "+am_pm;
		}
		date=day+"-"+month+"-"+year;
		System.out.println("LAT VALUE "+lat_value);
		System.out.println("LONG VALUE "+long_value);
		
		int lat_length = lat_value.indexOf(".");
		
		int lat_len = lat_value.length() - lat_length - 1;			
		
		int long_length = long_value.indexOf(".");
		
		int long_len = long_value.length() - long_length - 1;
				
		if(lat_len <= 2 )
		{
			lat_value += "00";
		}
		if(long_len <= 2)
		{
			long_value += "00";
		}
		
		 latitude_value = lat_value.substring(0,5);
		longitude_value = long_value.substring(0,5);		
		if(engine_status.equals("0"))
		{					
			if(offcounter==0)
			 {
					 
					min_time=datetime;  //Stoped at
		
					isstopped=true;	
			 } 
			 
			offcounter++;
			oncounter=0; 
		}
	else if(isstopped && engine_status.equals("1"))
 	{
		if(oncounter==0)
			{  
			max_time = datetime;   //Stoped still			
			lat = lat_value.substring(0,5);
			lon = long_value.substring(0,5);
			mapKey = lat +"$"+lon;
			Map<String,Object> cr = checkLocExists(haltTimeMap, lat, lon);
			 boolean rt = (Boolean)cr.get("isexist");			
			if(rt)
			{
				
				String ky = (String)cr.get("eloc");
				List<Map<String,Object>> tmpList = (List)haltTimeMap.get(ky);
				Iterator<Map<String,Object>> titr = tmpList.iterator();
				while(titr.hasNext())
				{
					Map<String,Object> m = titr.next();
					Date maxi_time = (Date)m.get("max_time");
					
					long timeDiff = Math.abs(min_time.getTime() - maxi_time.getTime());	
					
					int timeDiff1 = (int)(Math.abs(min_time.getTime() - maxi_time.getTime())/1000)/60;
					min_diff=String.format("%d", TimeUnit.MILLISECONDS.toMinutes(timeDiff) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(timeDiff))); 					
					int mini_diff=Integer.parseInt(min_diff); 					
					
					System.out.println("min time idddddddddddddddd :"+min_time +"  -" +maxi_time);
					System.out.println("MINUTE DDDDDDDDDDDDDDDDDFFFFFFFFFFFFFCCCCCCCCCCCCCCCCC "+timeDiff);
					System.out.println("MINUTE DDDDDDDDDDDDDDDDDFFFFFFFFFFFFFcbvcbcvbvc "+timeDiff1);
					
					/* if( timeDiff > 60000 ) */
					if( timeDiff > 1)
					{					
						Date tmin_time = (Date)m.get("min_time");
						long timeDiffer = Math.abs(max_time.getTime() - tmin_time.getTime());
						int timeDiffer1 = (int)(Math.abs(max_time.getTime() - tmin_time.getTime())/1000)/60;
						if(df.format(tmin_time).substring(0, 10).equals(df.format(max_time).substring(0, 10)))
						{							
							if(timeDiffer1 > input_halt_time)																
							{
							halt_time = String.format("%d hour(s) %d min(s)", TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - tmin_time.getTime())),
				                TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - tmin_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - tmin_time.getTime()))));												
						        m.put("max_time",max_time); 
						        m.put("halt_time",halt_time); 
						
							}
						}
						else
						{
						System.out.println("WRONG DATE");
						}
					}
					
				}
				
			}
			else
			{				
				long timeDiff = Math.abs(min_time.getTime() - max_time.getTime());		
				int timeDiff1 = (int)(Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;		
				if(timeDiff1 > input_halt_time )
				{
					
					long timeDiffer = Math.abs(min_time.getTime() - max_time.getTime());
					int timeDiffer1 =(int) (Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;
					System.out.println("MINIMUM with TIME"+df.format(min_time).substring(0, 10));
					System.out.println("MAXIMUM with TIME "+df.format(max_time).substring(0, 10));
					System.out.println("Days "+df.format(min_time.getDate()).equals(df.format(max_time.getDate())));
					if(df.format(min_time).substring(0, 10).equals(df.format(max_time).substring(0, 10)))
						
					{
						if(timeDiffer1 > input_halt_time)						
						{
							halt_time = String.format("%d hour(s) %d min(s)", TimeUnit.MILLISECONDS.toHours(Math.abs(min_time.getTime() - max_time.getTime())),
					                TimeUnit.MILLISECONDS.toMinutes(Math.abs(min_time.getTime() - max_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(min_time.getTime() - max_time.getTime()))));						
							System.out.println("Halt Time "+halt_time);
							Map<String,Object> m=new HashMap<String,Object>();
							m.put("min_time",min_time);
							m.put("max_time",max_time);
							
							m.put("lat_value",lat_value);
							m.put("long_value",long_value);
							m.put("halt_time",halt_time);							
							List<Map<String,Object>> tmpList = new ArrayList<Map<String,Object>>();
							tmpList.add(m);
							haltTimeMap.put(mapKey,tmpList);
						}
						
					}
				}
				
			}
			
			
			isstopped=false;
		}
		
		oncounter++;
		offcounter=0; 
 } 
for(Object m:halt_time_list)
{

	Map y=(Map)m;
	 
}


if(counter == 0)
{
	
}
%>

<%
if(!(diff.equals("")) && (minute_diff > 5))	
{
%>
<!-- <tbody>
<tr>

<td></td>
<td></td>
<td></td>
</tr>
</tbody> -->
<%
}
}
Set keys = haltTimeMap.keySet();
System.out.println("LAT LONG "+keys);
Iterator it = keys.iterator();
while(it.hasNext())
{
	
	String t=(String)it.next();
	List lt = (List)haltTimeMap.get(t); 
	
	Iterator litr = lt.iterator();
	//System.out.println("WORKING");
	while(litr.hasNext())
	{
		Map hm = (Map)litr.next();
		minimum_time = df.format(hm.get("min_time"));
		maximum_time = df.format(hm.get("max_time"));
		 %>
			<tbody>
			<tr>
			<%-- <td align="left" class="report_border" > <%=lat_value %> , <%= long_value %></td> --%>
			<td  align="left" class="report_border"  id="msg<%=count %>" style="width: 50%;  background: #f9f7f5;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>  
			<td align="left" class="report_border" style="width: 16%;"> <%= minimum_time %></td>
			<td align="left" class="report_border" style="width: 16%; background: #f9f7f5;"><%= maximum_time %></td>
			<td align="left" class="report_border" style="padding-left: 10px; width:18%;"><%= hm.get("halt_time") %></td>
			</tr>
			</tbody>
			<%
		count++;
			
	}
}
System.out.println("Same place Halt time "+haltTimeMap);
connection.close();
rs.close();
st.close();
}catch(SQLException e){ 
	System.out.println(e.getMessage());
	} %>

</table> 
</form>
<!-- <button onclick="tabletest()">Click</button>  -->
</body>
</html>
