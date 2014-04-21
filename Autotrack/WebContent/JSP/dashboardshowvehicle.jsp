<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Date" import="java.text.*" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="com.ts.service.dropdown" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>

<META HTTP-EQUIV="REFRESH" CONTENT="30">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>	
    <head>
        <title>Trans Workx Grid</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="description" content="" />
        <meta name="keywords" content=""/>
        <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
        <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
                     
  <script type="text/javascript">
  	function showInfo(key)
  	{
  		var imgname=document.getElementById(key).name;
  		document.SimpleDashboard.action="AJAX_Loading_DashboardInfo.jsp?value="+imgname+"";//it go to controllerservlet and after that it go to LoginService
		document.SimpleDashboard.submit();
  	}
	function inActive()
	{
		document.SimpleDashboard.action="InActiveDashboardInfo.jsp";//it go to controllerservlet and after that it go to LoginService
		document.SimpleDashboard.submit();
	}
 </script>
					
</head>
       
<body onunload="Gunload()">
<div class="content_bg"><span class="content_headning">Dashboard</span></div>

<form name="SimpleDashboard" target="DashboardInfo" method="post">
<table><tr>
<td><img src="../images/active.jpg" alt=""></td>
  <%	
 String IMEI,GetData,value,vehicle_number;
  int fullsize=0;
  Map.Entry me=null;
  HashMap<String,String> offlinevehicle = new HashMap<String,String>();
  TreeMap<String,String> hm=null;
  try{
 	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date date = new Date();
//	System.out.println(dateFormat.format(date));
	Calendar cal = Calendar.getInstance();
	//System.out.println("Current Date Time : " + dateFormat.format(cal.getTime()));
	cal.add(Calendar.MINUTE, -3);
	ResultSet set = null;
	String belongs=(String)session.getAttribute("belongs");
	System.out.println("belongs to ="+belongs);
	if(belongs.equals("owner"))

		GetData = "SELECT R.imei_no,V.vehicle_number FROM recent R,Vehicle_information V where V.imei_no=R.imei_no and date_time > '"+dateFormat.format(cal.getTime())+"' and engine_status ='1'";
	else
		GetData = "select T.imei_no,V.vehicle_number from vehicle_information V,recent T where V.customer_id='"+belongs+"' and V.imei_no=T.imei_no and T.date_time > '"+dateFormat.format(cal.getTime())+"' and engine_status ='1'";
		
		Statement mystatement = connection.createStatement();
	
		set = mystatement.executeQuery(GetData);
	
dropdown dd=new dropdown();     
hm = dd.getName(belongs);


fullsize=hm.size();
System.out.println(hm);

System.out.println("full size="+fullsize);

  while(set.next())
  {
	value=set.getString("imei_no");
	vehicle_number=set.getString("vehicle_number");
		if(value.length()==15 || value.length()==8)
	  	{
			System.out.println(value);  
	
			//Iterator iterator = sets.iterator();
			
		//while(iterator.hasNext()){
		
    	// me = (Map.Entry)iterator.next();
    	 
		// System.out.println("value from hash map "+me.getValue());
		 
    		// if(me.getValue().equals(value))
     	//	{
    			 //String status = (String)me.getValue();
    			
    			System.out.println("size"+--fullsize);
    		 
     %>

<td>
    <div><a href="../JSP/dashboardlivetracking.jsp?IMEI=<%=value%>" target="Content"> <img src="../images/dashboard_active_car.png" alt="../images/dashboard_active_car.png" id="<%=vehicle_number%>" title="<%=vehicle_number%>" name="<%=value%>"  onmouseover="showInfo('<%=vehicle_number%>')" onmouseout="normalImg();" width="64px" height="37px"/></a></div>
    <div><a style="font-size: 9px; font-family: arial;"><%=vehicle_number%></a></div>
</td>
  
<%
			//sets.remove(me.getKey());
		//	System.out.println("size "+sets.size());
			//break;// control will go to take next record from resultset
			hm.remove(vehicle_number);
				}//if end
				//else
				//{
			//		offlinevehicle.put((String)me.getKey(),(String)me.getValue());
					//getvalue is the IMEI number and key is the vehicle number
			//	}
			}//while iterator end
	//	}//if value 15 end
	//}//while resultset
  connection.close();
	mystatement.close();
	set.close();
  }//try
  catch(Exception e){}
%>
</tr>
<%	
	int reminder = fullsize%10;	
	
	//System.out.println("Reminder : "+reminder);
	
	int numberoftimes = fullsize/10;
	//System.out.println("non running vehicle"+offlinevehicle);
	//System.out.println("non running vehicle"+offlinevehicle.size());
//	fullsize=offlinevehicle.size();
//	System.out.println(offlinevehicle);
//	Set setsoffline = offlinevehicle.entrySet(); 
//	Iterator iteratoroffline = setsoffline.iterator();
	//me = (Map.Entry)iteratoroffline.next();
	Set sets = hm.entrySet(); 
	Iterator iterator = sets.iterator();
for(int k=0;k<numberoftimes;k++)
{
	
	//System.out.println("Numberoftimes : "+numberoftimes);

%>

<tr>
<td><img src="../images/inactive.jpg" alt=""></td>
<%	
	
	for(int j=0;j<10;j++)
	{
		fullsize--;
		
		
		if(iterator.hasNext()){
		
    	 me = (Map.Entry)iterator.next();
		
		//System.out.println(fullsize--);
%>
<td>
  	<!-- <div>	
  		<img src="../images/dashboard_inactive_car.png" width="64" height="37" onmouseover="inActive()"/> -->
  		<div>
  			<a href="../JSP/dashboardlivetracking.jsp?IMEI=<%=me.getValue()%>" target="Content"> <img src="../images/dashboard_inactive_car.png" alt="../images/dashboard_active_car.png" id="<%=me.getKey()%>" title="<%=me.getKey()%>" name="<%=me.getValue()%>"  onmouseover="showInfo('<%=me.getKey()%>')" onmouseout="normalImg();" width="64px" height="37px"/></a>
  		</div>
    <div>
    	<a style="font-size: 9px; font-family: arial;"><%=me.getKey()%></a>
    </div>
  <!-- 	</div> -->
</td>
 <% 
		}//hasNext
	 }//While End
 %>
 </tr>
 <% 
 
}//for ends
%>
<tr>
<td><img src="../images/inactive.jpg" alt=""></td>
  <%   

  for(int k = 0;k<reminder;k++){
	  if(iterator.hasNext()){
			 me = (Map.Entry)iterator.next();
  %>
		     
	<td>
		    	
		   <!--  	<div><img src="../images/dashboard_inactive_car.png" width="64px" height="37px" onmouseover="inActive()"/></div>
		  <div><a style="font-size: 19px; font-family: arial;"></a></div> -->
		 <div>
  			<a href="../JSP/dashboardlivetracking.jsp?IMEI=<%=me.getValue()%>" target="Content"> <img src="../images/dashboard_inactive_car.png" alt="../images/dashboard_active_car.png" id="<%=me.getKey()%>" title="<%=me.getKey()%>" name="<%=me.getValue()%>"  onmouseover="showInfo('<%=me.getKey()%>')" onmouseout="normalImg();" width="64px" height="37px"/></a>
  		</div>
   		 <div>
    		<a style="font-size: 9px; font-family: arial;"><%=me.getKey()%></a>
   		 </div>
		  
	</td>
		  
   <%
	  }//hasNext
   } //for ends   %>
</tr>
</table>
        </form>
</body>
</html>