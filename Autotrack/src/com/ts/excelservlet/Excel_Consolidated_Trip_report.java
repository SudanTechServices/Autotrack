package com.ts.excelservlet;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
/*import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.Cell;
import com.ts.dbtranscationmgr.DBTransaction;*/

// google map address packages

import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;				
import org.codehaus.jackson.map.ObjectMapper;
import com.ts.excelservlet.Address_Result;




//@WebServlet("/Excel_Consolidated_Trip_report")
public class Excel_Consolidated_Trip_report extends HttpServlet {
	private static final long serialVersionUID = 1L;   
	String start_latlng =null;
	String halt_latlng =null;
	String Start_Address =null;
	String Halt_Address =null;
	float st_lat =0.0f;
	float ht_lat =0.0f;
	float st_lng=0.0f;
	float ht_lng =0.0f;
	float distance =0.0f;
	
 /*   public Map<String,Object> checkLocExists(Map<String,String> mp,String lati,String langi)
	 {
		   boolean r = false;
	     Map<String,Object> res = new HashMap<String,Object>();
	     double dlat = Double.parseDouble(lati);
	     double dlon = Double.parseDouble(langi);	    
	     DecimalFormat dft = new DecimalFormat("#0.00");
	     String rkey = "";
	     rkey = dft.format(dlat)+"$"+dft.format(dlon);
	      if(mp.containsKey(rkey))
	     {
	         r = true;
	         res.put("eloc", rkey);	         
	     } 
	     
	         res.put("isexist", r);
	     return res;
	     } */
  
    
    
/*	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);				
		DBTransaction dbtranobj=new DBTransaction();	
		 int index=2;		   
		 HSSFWorkbook wb = new HSSFWorkbook();
		 HSSFSheet sheet = wb.createSheet("Consolidated Trip ");
		 OutputStream out = null;   
		 String one_way_last_time=null;
		 String imeinumber = request.getParameter("imeinumber");
		 String one_way_srclat=(String) session.getAttribute("one_way_srclat");
		 String one_way_deslat= (String)session.getAttribute("one_way_deslat");		 
		 int input_halt_time=Integer.parseInt(request.getParameter("inputHaltTime")); 		
		 
try{
		
		String startdate = request.getParameter("startdate");					    	    
		String src_lat=(String) session.getAttribute("one_way_srclat");
		String des_lat= (String)session.getAttribute("one_way_deslat");
	    String des_sub_lat=(String)session.getAttribute("des_lat");
		
		double double_src_lat=Double.parseDouble(src_lat);
		double double_des_lat=Double.parseDouble(des_lat);  
		String Query1 ="";
		
	   //--------------variable declaration ----------------------//		
	 	String starttime="";
	 	String start_lat="";
	 	String lat_subString="";
	 	String  start_lng="";	 	
	 	Date start_time=null;
	 	String am_pm;		 	
	 	String date;
		String fin_hr;
		String time;
		Date min_time = null;
		Date max_time = null;		
		String minimum_time = "";					
		String lat = "";
		String lon = "";					
		int sub_Str_cnt=0;
		int sub_String_cnt=0;
		int offcounter=0,oncounter=0;
		int whilecounter=1;			
		boolean isstopped = false;		
		String mapKey = "";
		String halt_time = "";		
		Map haltTimeMap = new LinkedHashMap();
		List<Float> distance1 = new ArrayList<Float>();	
		HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();
		List<Integer> equalCount=new ArrayList<Integer>();
			
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    Connection con=null;	   
	    Statement st1 =null;
	    Statement st2 =null;
	    ResultSet rs1 =null;
	   
	    String vehicle_number="";
	    con=dbtranobj.connect();			
		st1=con.createStatement();
		st2=con.createStatement();
		rs1=st1.executeQuery("SELECT vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
		 if(rs1.next()){
			 vehicle_number=rs1.getString("vehicle_number");
		 }


	    	response.setContentType("application/vnd.ms-excel");
	    	response.setHeader("Content-Disposition", "attachment; filename=Consolidate_trip_report.xls");
	    	
	    	
	 	   
	 			 //------------Excel Starts here----------------------//
	 			 
	 			
	 			   
	 			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1)); 	//return type int
	 			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
	 			   HSSFRow rowhead = sheet.createRow((short)0);
	 			   
	 			   rowhead.setHeight((short)500);	
	 			   
	 			    //--------------1 st row-----------------//
	 			   
	 			    HSSFCell cell2B = rowhead.createCell(0);  
	 		        cell2B.setCellValue(new HSSFRichTextString("Consolidated Trip Report for " +vehicle_number));  	        
	 		        HSSFCellStyle cellStyle = wb.createCellStyle();
	 		        cellStyle = wb.createCellStyle();  
	 		        HSSFFont hSSFFont = wb.createFont();  
	 		        hSSFFont.setFontName(HSSFFont.FONT_ARIAL);  
	 		        hSSFFont.setFontHeightInPoints((short) 14);  
	 		        hSSFFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
	 		        hSSFFont.setColor(HSSFColor.BLUE.index);  
	 		        cellStyle.setFont(hSSFFont);  
	 		        cell2B.setCellStyle(cellStyle);
	 		       
	 		        
	 		        //--------------------- 2 row --------------------//
	 		        
	 			   HSSFRow rowhead1 = sheet.createRow((short)1);
	 			   rowhead1.setHeight((short)600);
	 			    
	 			   //---------------------2 row and 1 cell ----------//
	 			   
	 			   Cell cell = rowhead1.createCell(0);
	 			   HSSFCellStyle cellStyle1 = wb.createCellStyle();
	 			   cellStyle1 = wb.createCellStyle(); 
	 			   HSSFFont hSSFFont1 = wb.createFont();  
	 		       hSSFFont1.setFontName(HSSFFont.FONT_ARIAL);  
	 		       hSSFFont1.setFontHeightInPoints((short) 12);  
	 		       hSSFFont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
	 		       hSSFFont1.setColor(HSSFColor.BLACK.index); 
	 		       cellStyle1.setFont(hSSFFont1);  
	 		       cell.setCellStyle(cellStyle1); 
	 			   cell.setCellValue("Start Position");
	 			   sheet.setColumnWidth(0, 7000);
	 			   //---------------------2 row and 2 cell ----------//
	 			   
	 			  // rowhead.createCell((short) 0).setCellValue("Date");
	 			   Cell cell1 = rowhead1.createCell(1);
	 			   cell1.setCellStyle(cellStyle1); 
	 			   cell1.setCellValue("Start Time");
	 			   sheet.setColumnWidth(1, 7000);
	 			   
	 			   //---------------------2 row and 2 cell ----------//
	 			   
	 			   Cell cell2 = rowhead1.createCell(2);
	 			   cell2.setCellStyle(cellStyle1); 
	 			   cell2.setCellValue("Halt Position");
	 			   sheet.setColumnWidth(2, 7000);
	 			 
	 			 //---------------------2 row and 3 cell ----------//
	 			   Cell cell3 = rowhead1.createCell(3);
	 			   cell3.setCellStyle(cellStyle1); 
	 			   cell3.setCellValue("Stoped At");
	 			   sheet.setColumnWidth(3, 7000);
	 			   
	 			   //---------------------2 row and 4 cell ----------// 
	 			   Cell cell4 = rowhead1.createCell(4);
	 			   cell4.setCellStyle(cellStyle1); 
	 			   cell4.setCellValue("Halted Time");
	 			   sheet.setColumnWidth(4, 7000);
	 			  
	 			 //---------------------2 row and 5 cell ----------// 
	 			   Cell cell5 = rowhead1.createCell(5);
	 			   cell5.setCellStyle(cellStyle1); 
	 			   cell5.setCellValue("Distance Travelled");
	 			   sheet.setColumnWidth(5, 7000);
	    	
	    
	    	//-----------------Db Coding Starts here -------------------------------//
						 
			 if(double_src_lat < double_des_lat){		   			 	
					Query1="select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time >= (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) and latitude_value >='"+src_lat+"%' and latitude_value <='"+des_lat+"%' order by date_time";
						System.out.println("Query 3 one way src<  des (1): "+Query1);
						 
				   }
			 if(double_src_lat > double_des_lat){
					   Query1=" select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time >= (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) and latitude_value >='"+des_lat+"%' and latitude_value <='"+src_lat+"%' order by date_time";
						System.out.println("Query 3 one way src >  des (2): "+Query1);
			 	}
			 
			 ResultSet rs3 =st2.executeQuery(Query1);			
	   			if(rs3.next()){ //Starting value	   				
					starttime=rs3.getString ("date_time");						   			
					start_lat=rs3.getString("latitude_value");
					start_lng = rs3.getString("longitude_value");
					start_time=df.parse(starttime);	
	   			}
	   			while(rs3.next()){
	   				
	   				String date_time = rs3.getString("date_time");
	   				String lat_value=rs3.getString("latitude_value");		   				
	   				String long_value=rs3.getString("longitude_value");
					String engine_status = rs3.getString("engine_status");
					String date_in_db=date_time.substring(0,10);
					String day=date_in_db.substring(8,10);
					String month=date_in_db.substring(6, 7);
					String year=date_in_db.substring(0,4);
					String hr=date_time.substring(11,13);
					String min=date_time.substring(14,16);
					int hour = Integer.parseInt(hr);
					Date datetime=df.parse(date_time);
				
					//-----------Time Alignment---------------//
					
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
					if(engine_status.equals("0"))
					{
						if(offcounter==0)
						 {
								min_time=datetime;  //off time											
								isstopped=true;	
						 } 
						 
						offcounter++;
						oncounter=0; 
					}
					
					//---------------Flow Starts here----------------//
					
					else if(isstopped && engine_status.equals("1"))
					 {
						 if(oncounter==0)
							{  
								max_time = datetime;   //off to on (stoped at value)									
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
										Date maxi_time = (Date)m.get("max_time");	//Start time											
										long timeDiff = (Math.abs(min_time.getTime() - maxi_time.getTime())/1000)/60;																		
										if( timeDiff > 15 )
										//if( timeDiff >1)
										{								
											Date tmin_time = (Date)m.get("min_time");
																	}
										
									}//second iterate
									
								}//if boolean value is false
								
								else
								{ // off to on difference: 
									long timeDiff = (Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;	
										
									if(timeDiff > input_halt_time)			
									{										
										Map<String,Object> m=new HashMap<String,Object>();							
												//haltCounter++;								
												halt_time = String.format("%d hour(s) %d min(s)",
													 TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime())),
										             TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime()))));																
												
												lat_subString=lat_value.substring(0,4);
																							
													sub_Str_cnt++;
													
													
													
										//----------------Putting all the values in map--------------//																												
														m.put("start_time",start_time);
														m.put("min_time",min_time);	//last time								
														m.put("max_time",max_time);							
														m.put("lat_value",lat_value);
														m.put("long_value",long_value);
														m.put("start_lat",start_lat);
														m.put("start_lng",start_lng);
														m.put("halt_time",halt_time);
														start_lat = lat_value;
														start_lng = long_value;
														start_time = max_time;
														
														
												if(des_sub_lat.equals(lat_subString)){   
											*//** It gives exact location we don't skip exact location 
												so we took next count of this loop.(By this we can get exact location)
												
											*//*																																						
													equalCount.add(sub_Str_cnt+1);
													sub_String_cnt =  equalCount.get(0);																									
												}
												
												List<Map<String,Object>> tmpList = new ArrayList<Map<String,Object>>();
												tmpList.add(m);
												haltTimeMap.put(mapKey,tmpList);													
									       }
								}//off counter
								isstopped=false;
							}//on Conter
							
							oncounter++;
							offcounter=0; 
					 }  //Engine on
					
					} //first while  
	   			
	   			
	   				//----------------Retrive and print the values which is there in halttimeMap---------------//							
				Set keys = haltTimeMap.keySet();		
				Iterator it = keys.iterator();
				while(it.hasNext())
				{								
					String t=(String)it.next();
					
					lat_subString=t.substring(0,4);
					lat_subString= lat_subString.substring(0,4);           										
					  if(sub_String_cnt  == whilecounter ){							
							break;
						}  				 					
					 else{			//------Stop Condition--------//
						
						 List lt = (List)haltTimeMap.get(t); 	
						Iterator litr = lt.iterator();
						
								while(litr.hasNext())
								{	Map hm = (Map)litr.next();																					
								whilecounter++;
								
									if(whilecounter == sub_String_cnt ){  
										halt_time="Stoped";
										hm.put("halt_time",halt_time);
									}										   
									starttime =df.format(hm.get("start_time"));
									minimum_time = df.format(hm.get("min_time"));																																													
									String hal_time = (String) hm.get("halt_time");
									start_latlng=hm.get("start_lat")+","+hm.get("start_lng");		
									halt_latlng =hm.get("lat_value")+","+hm.get("long_value");
									
									
									st_lat = Float.parseFloat((String)hm.get("start_lat"));								
									ht_lat = Float.parseFloat((String)hm.get("lat_value"));
									st_lng = Float.parseFloat((String)hm.get("start_lng"));
									ht_lng= Float.parseFloat((String)hm.get("long_value"));
																									    								   							
									
									//====================Total distance ==============================//																									
									Excel_Consolidated_Trip_report excelObj = new Excel_Consolidated_Trip_report();
									Start_Address = excelObj.getStartAddress(start_latlng);
									Halt_Address  = excelObj.getDestAddress(halt_latlng);								
									distance  = excelObj.getDistance(st_lat,ht_lat,st_lng,ht_lng);									
									distance1.add(distance);
									//-------------- Geo address end---------------// 
									 
									 									 									 
									 HSSFRow row = sheet.createRow((short)index);
									   row.setHeight((short)500);	
									   row.createCell(0).setCellValue(Start_Address);
									   row.createCell(1).setCellValue(starttime);
									   row.createCell(2).setCellValue(Halt_Address);									   
									   row.createCell(3).setCellValue(minimum_time);
									   row.createCell(4).setCellValue(hal_time);
									   row.createCell(5).setCellValue(distance);									   
									   index++;									   								
									System.out.println("output of the excel sheet is  :::::::"+starttime);
									
									//count++;		
				                 }//last while	
								
								float totalDistance =0.0f;
								for(int i =0;i<=distance1.size()-1;i++){
									totalDistance= totalDistance +distance1.get(i);
								}							
								
								HSSFRow row = sheet.createRow((short)index);
								row.setHeight((short)300);
								Cell cell10=	row.createCell(4);
								cell10.setCellValue("Total Distance Travelled");  
								cell10.setCellStyle(cellStyle1);
					 		    
								Cell cell11=row.createCell(5);
								cell11.setCellValue(totalDistance);
								cell11.setCellStyle(cellStyle1);

				            }// if not equal
					
				       }
				 one_way_last_time = minimum_time;
				 st1.close();
				 st2.close();
				 rs1.close();
				 con.close();
		} catch (ClassNotFoundException e) {			
			e.printStackTrace();
		} catch (IllegalAccessException e) {			
			e.printStackTrace();
		} catch (InstantiationException e) {			
			e.printStackTrace();
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
	    
		
	    
	    
	    
//------------------------------------------------------------------------------------------------------------------------//
                          //ONE WAY TRIP REPORT COMPLETED					
//------------------------------------------------------------------------------------------------------------------------//						
	    	  
	    String  startdate =one_way_last_time;
	    String  dest_halt_time=null;
		int newIdx =index+1;
		
		   HSSFCellStyle cellStyle1 = wb.createCellStyle();
		   cellStyle1 = wb.createCellStyle(); 
		   HSSFFont hSSFFont1 = wb.createFont();  
	       hSSFFont1.setFontName(HSSFFont.FONT_ARIAL);  
	       hSSFFont1.setFontHeightInPoints((short) 12);  
	       hSSFFont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
	       hSSFFont1.setColor(HSSFColor.BLACK.index); 
	       cellStyle1.setFont(hSSFFont1);  
		
		HSSFRow R_row = sheet.createRow((short)newIdx );
		R_row .setHeight((short)700);								
		Cell cell12 = R_row.createCell(2);						
		cell12.setCellValue(" **Return way Trip**"); 								
		cell12.setCellStyle(cellStyle1);
		int newindex= newIdx +1;
		   
		HSSFRow R_row1 = sheet.createRow((short)newindex );
		R_row1 .setHeight((short)500);	
		
		Cell cell13 = R_row1.createCell(0);						
		cell13.setCellValue("Start Position");
		cell13.setCellStyle(cellStyle1);
		
		
		Cell cell14 = R_row1.createCell(1);						
		cell14.setCellValue("Start Time ");								
		cell14.setCellStyle(cellStyle1);
		
		
		
		Cell cell15 = R_row1.createCell(2);						
		cell15.setCellValue("Halt Position");								
		cell15.setCellStyle(cellStyle1);
	
		
		
		Cell cell16 = R_row1.createCell(3);						
		cell16.setCellValue("Stoped At");								
		cell16.setCellStyle(cellStyle1);
		
		
		
		
		Cell cell17 = R_row1.createCell(4);						
		cell17.setCellValue("Halted Time");								
		cell17.setCellStyle(cellStyle1);
		
		
		Cell cell18 = R_row1.createCell(5);						
		cell18.setCellValue("Distance Travelled");								
		cell18.setCellStyle(cellStyle1);
		newindex++;
		//------------------------------------Return way coding --------------------------------------//
		
		if(!one_way_deslat .equals(null) && !one_way_srclat .equals(null) ){
			String src_lat=one_way_deslat; 
			String des_lat=one_way_srclat;	
			double double_src_lat=0.0;
		 	double double_des_lat=0.0;
		 	String starttime="";
		 	String start_lat="";
		 	String lat_subString="";
		 	String  start_lng="";		 	
		 	Date start_time=null;
		 	String am_pm;		 	
		 	String date;
			String fin_hr;String time;
			Date min_time = null;Date max_time = null;			
			String minimum_time = "";						
			String lat = "";
			String lon = "";						
			int sub_Str_cnt=0;
			int sub_String_cnt=0;
			int offcounter=0,oncounter=0;
			int whilecounter=1;			
			boolean isstopped = false;		
			String mapKey = "";
			String halt_time = "";			
			List<Float> distance1 = new ArrayList<Float>();	
			Map haltTimeMap = new LinkedHashMap();
			List<Integer> equalCount=new ArrayList<Integer>();
			HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();

			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			  try {
		 			DBTransaction dbtrans = new DBTransaction();
		 			Connection con = dbtrans.connect();
		 			Statement stmt1=  con.createStatement();
		 			double_src_lat=Double.parseDouble(src_lat);
		 			double_des_lat=Double.parseDouble(des_lat);  // have to do comparison 
		 			String des_sub_lat=des_lat.substring(0,4);
		 			
		 			 //      -------------Main Query---------------One way Report//  	
			           String Query3 ="";
			  		   if(double_src_lat < double_des_lat){		   			 	
			   				 Query3="select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time > (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' order by date_time limit 1) and latitude_value >='"+src_lat+"%' and latitude_value <='"+des_lat+"%' order by date_time";
			  		   }
			  		   if(double_src_lat > double_des_lat){
			  				 Query3=" select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time > (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"'  order by date_time limit 1) and latitude_value >='"+des_lat+"%' and latitude_value <='"+src_lat+"%' order by date_time";
			  		   }
			  		   
			   			System.out.println("Query 3 return way: "+Query3);
			   			ResultSet rs3 =stmt1.executeQuery(Query3);
			   			if(rs3.next()){ //Starting value
							starttime=rs3.getString ("date_time");
							start_lat=rs3.getString("latitude_value");
							start_lng = rs3.getString("longitude_value");
							start_time=df.parse(starttime);	
							
							if(starttime !="" ){
					   			Date s_time =df.parse(startdate);
					   			Date e_time =df.parse(starttime);
					   		    dest_halt_time = String.format("%d hour(s) %d min(s)",
					   				                    TimeUnit.MILLISECONDS.toHours(Math.abs(e_time.getTime() - s_time.getTime())),
					 	                                TimeUnit.MILLISECONDS.toMinutes(Math.abs(e_time.getTime() - s_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(e_time.getTime() - s_time.getTime()))));
					 		    System.out.println("Destination Halt time ::::::::::::@@@@@@@@@@@@@@@"+dest_halt_time);
					   			}
			   			}			   			
			 		    
			   			while(rs3.next()){
			   				
			   				String date_time = rs3.getString("date_time");
			   				String lat_value=rs3.getString("latitude_value");		   				
			   				String long_value=rs3.getString("longitude_value");
							String engine_status = rs3.getString("engine_status");
							String date_in_db=date_time.substring(0,10);
							String day=date_in_db.substring(8,10);
							String month=date_in_db.substring(6, 7);
							String year=date_in_db.substring(0,4);
							String hr=date_time.substring(11,13);
							String min=date_time.substring(14,16);
							int hour = Integer.parseInt(hr);
							Date datetime=df.parse(date_time);
						
							//-----------Time Alignment---------------//
							
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
							if(engine_status.equals("0"))
							{
								if(offcounter==0)
								 {
										min_time=datetime;  //off time											
										isstopped=true;	
								 } 
								 
								offcounter++;
								oncounter=0; 
							}
							
							//---------------Flow Starts here----------------//
							
							else if(isstopped && engine_status.equals("1"))
							 {
								 if(oncounter==0)
									{  
										max_time = datetime;   //off to on (stoped at value)									
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
												Date maxi_time = (Date)m.get("max_time");	//Start time											
												long timeDiff = (Math.abs(min_time.getTime() - maxi_time.getTime())/1000)/60;																				
												if( timeDiff > 15 )												
												{								
													Date tmin_time = (Date)m.get("min_time");
																			}
												
											}//second iterate
											
										}//if boolean value is false
										
										else
										{ // off to on difference: 
											long timeDiff = (Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;	
												
											if(timeDiff > input_halt_time)			
											{
												
												
												Map<String,Object> m=new HashMap<String,Object>();																												
														halt_time = String.format("%d hour(s) %d min(s)",
															 TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime())),
												             TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime()))));						
														System.out.println("Halt Time "+halt_time);	
														
														lat_subString=lat_value.substring(0,4);
																									
															sub_Str_cnt++;
															
															
															
												//----------------Putting all the values in map--------------//																		
																m.put("start_time",start_time);
																m.put("min_time",min_time);	//last time								
																m.put("max_time",max_time);							
																m.put("lat_value",lat_value);
																m.put("long_value",long_value);
																m.put("start_lat",start_lat);
																m.put("start_lng",start_lng);
																m.put("halt_time",halt_time);
																start_lat = lat_value;
																start_lng = long_value;
																start_time = max_time;
																
																
														if(des_sub_lat.equals(lat_subString)){   
													*//** It gives exact location we don't skip exact location 
														so we took next count of this loop.(By this we can get exact location)
														
													*//*													
															equalCount.add(sub_Str_cnt+1);
															System.out.println("inside condtion equal count ************ :"+equalCount);															
															sub_String_cnt =  equalCount.get(0); //getting first time count of inside equal condition
														}
														List<Map<String,Object>> tmpList = new ArrayList<Map<String,Object>>();
														tmpList.add(m);
														haltTimeMap.put(mapKey,tmpList);													
											       }
										}//off counter
										isstopped=false;
									}//on Conter
									
									oncounter++;
									offcounter=0; 
							 }  //Engine on
							
							} //first while
								
								
								
						//	----------------Retrive and print the values which is there in halttimeMap---------------//							
							Set keys = haltTimeMap.keySet();		
							Iterator it = keys.iterator();
							while(it.hasNext())
							{								
								String t=(String)it.next();
								lat_subString=t.substring(0,4);
								lat_subString= lat_subString.substring(0,4);           //9								
								  if(sub_String_cnt  == whilecounter ){							
										break;
									}  
							 
								
								 else{	//------Stop Condition--------//
									List lt = (List)haltTimeMap.get(t); 	
									Iterator litr = lt.iterator();
									
											while(litr.hasNext())
											{	Map hm = (Map)litr.next();																					
											whilecounter++;
												if(whilecounter == sub_String_cnt ){  
													halt_time="Stoped";
													hm.put("halt_time",halt_time);
												}	
																								
												starttime =df.format(hm.get("start_time"));
												minimum_time = df.format(hm.get("min_time"));
												System.out.println("Min time :"+minimum_time);												
												
												String hal_time = (String) hm.get("halt_time");
												start_latlng=hm.get("start_lat")+","+hm.get("start_lng");		
												halt_latlng =hm.get("lat_value")+","+hm.get("long_value");
												
												
												st_lat = Float.parseFloat((String)hm.get("start_lat"));								
												ht_lat = Float.parseFloat((String)hm.get("lat_value"));
												st_lng = Float.parseFloat((String)hm.get("start_lng"));
												ht_lng= Float.parseFloat((String)hm.get("long_value"));
												
												Excel_Consolidated_Trip_report excelObj = new Excel_Consolidated_Trip_report();
												Start_Address = excelObj.getStartAddress(start_latlng);
												Halt_Address  = excelObj.getDestAddress(halt_latlng);								
												distance  = excelObj.getDistance(st_lat,ht_lat,st_lng,ht_lng);									
												distance1.add(distance);
													
												
												HSSFRow row = sheet.createRow((short)newindex);
												   row.setHeight((short)500);	
												   row.createCell(0).setCellValue(Start_Address);
												   row.createCell(1).setCellValue(starttime);
												   row.createCell(2).setCellValue(Halt_Address);									   
												   row.createCell(3).setCellValue(minimum_time);
												   row.createCell(4).setCellValue(hal_time);
												   row.createCell(5).setCellValue(distance);
												   newindex++;
												   index++;																																																																		
							                 }//last while
											
											
											float totalDistance =0.0f;
											for(int i =0;i<=distance1.size()-1;i++){
												totalDistance= totalDistance +distance1.get(i);
											}							
											
											HSSFRow row = sheet.createRow((short)newindex);
											row.setHeight((short)300);
											Cell cell10=	row.createCell(4);
											cell10.setCellValue("Total Distance Travelled");  
											cell10.setCellStyle(cellStyle1);
								 		    
											Cell cell11=row.createCell(5);
											cell11.setCellValue(totalDistance);
											cell11.setCellStyle(cellStyle1);
							            }// if not equal
								
							       } //map iterate while	
							newindex++;
							HSSFRow row = sheet.createRow((short)newindex);
							row.setHeight((short)300);
							Cell cell10=	row.createCell(0);
							cell10.setCellValue("Actual Halt Time at Client location ");  
							cell10.setCellStyle(cellStyle1);
				 		    
							Cell cell11=row.createCell(1);
							cell11.setCellValue(dest_halt_time);
							cell11.setCellStyle(cellStyle1);
									
							System.out.println("Same place Halt time "+haltTimeMap);
							out=response.getOutputStream();
							wb.write(out);
							
							con.close();					
							stmt1.close();									
							rs3.close();	
							
							}//try
			  
		   
		   catch(Exception e){
			   e.printStackTrace();
		   }
			  finally{
				   if (out != null)
				    out.close();
				  }
		   
		}
	    
				
	}*/
	
	
			//--------------------------Getting Starting address -----------------------------------//
	
	public String getStartAddress(String start_latlng) throws IOException{
		Address_GoogleResponse res1 = new Excel_Consolidated_Trip_report().convertFromLatLong(start_latlng);																		
		 while(true){
			  if(res1.getStatus().equals("OK"))
			  {			  
				  for(Address_Result result : res1.getResults())
				  {
					  Start_Address=result.getFormatted_address();					 
					  break;
				  }break;
			  }
			  else
			  {
			   System.out.println(res1.getStatus());
			  }
			  } //while   	
    	return Start_Address;
    }
    
			//--------------------------Getting Halt address -----------------------------------//
	
	public String getDestAddress(String halt_latlng) throws IOException{
		Address_GoogleResponse res2 = new Excel_Consolidated_Trip_report().convertFromLatLong(halt_latlng);									 
		 while(true){
			  if(res2.getStatus().equals("OK"))
			  {			  
				  for(Address_Result result : res2.getResults())
				  {
					  Halt_Address=result.getFormatted_address();					 
					  break;
				  }break;
			  }
			  else
			  {
			   System.out.println(res2.getStatus());
			  }
			  }//while
		return Halt_Address;
	}
	
	
	//--------------------------Getting Distance -----------------------------------//
	public float getDistance(float st_lat,float ht_lat,float st_lng,float ht_lng){
		double earthRadius = 3958.75;	
		
	    double dLat = Math.toRadians(st_lat-ht_lat);
	    double dLng = Math.toRadians(st_lng-ht_lng);
	    double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
	               Math.cos(Math.toRadians(st_lat)) * Math.cos(Math.toRadians(ht_lat)) *
	               Math.sin(dLng/2) * Math.sin(dLng/2);
	    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
	    double dist = earthRadius * c;								    
	    int meterConversion = 1825; //exact scale.
	     distance= new Float(dist * meterConversion).floatValue();
	    distance =distance/1000;
	    distance =Math.round(distance);
		return distance;
	}

	
	
	private Address_GoogleResponse convertFromLatLong(String latlng) throws IOException {
		final String URL = "http://maps.googleapis.com/maps/api/geocode/json";
		 URL url = new URL(URL + "?latlng="+ URLEncoder.encode(latlng, "UTF-8") + "&sensor=false");		 
		  URLConnection conn = url.openConnection();
		  InputStream in = conn.getInputStream() ;
		 
		  ObjectMapper mapper = new ObjectMapper();
		  Address_GoogleResponse go_response = (Address_GoogleResponse)mapper.readValue(in,Address_GoogleResponse.class);
		  in.close();
		  return go_response;
	}

}
