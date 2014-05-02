package com.ts.excelservlet;

import java.io.IOException;
import java.io.OutputStream;
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
import javax.servlet.http.HttpServlet;
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

import com.ts.dbtransactionmgr.DBTransaction;

@WebServlet("/Excel_Round_Trip_report")
public class Excel_Round_Trip_report extends HttpServlet {
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
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	 public Map<String,Object> checkLocExists(Map<String,String> mp,String lati,String langi)
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
	 } 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession(true);
				
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("Consolidated Trip ");
		OutputStream out = null;  
				
		String startdate = request.getParameter("startdate");
		String imeinumber = request.getParameter("imeinumber");
		String src_lat = request.getParameter("src_lat");	
	    int input_halt =(Integer) session.getAttribute("inputHaltTime");
		
		String src_sub_lat=src_lat.substring(0,4);
		String vehicle_number =null;
		int index=2;	
		
		int ses_splitCount=0;
		int counter =1;
		
		
		try {								 	
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
			String maximum_time = "";
			String lat = "";
			String lon = "";	
			String endTime="";			
			int offcounter=0,oncounter=0;
			int whilecounter=0;	
			int haltCounter =0;
			int haltCounter1=0;
			int halt_min=0;
			boolean isstopped = false;		
			String mapKey = "";
			String halt_time = "";
			String date_time ="";
			Map haltTimeMap = new LinkedHashMap();
			HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();
			List<String> equal_lat_Count=new ArrayList<String>();	
			List<Float> distance1 = new ArrayList<Float>();	
			List<Integer> equal_halt_Count=new ArrayList<Integer>();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			DBTransaction dbtrans = new DBTransaction();
			Connection con = dbtrans.connect();
			Statement st =con.createStatement();
			String sql = "SELECT vehicle_number from vehicle_information where imei_no='"+imeinumber+"' ";
			ResultSet rs =st.executeQuery(sql);
			if(rs.next()){
				vehicle_number = rs.getString("vehicle_number");
			}
			Statement st1 =con.createStatement();
			ResultSet rs1 = null;
			
			response.setContentType("application/vnd.ms-excel");
	    	response.setHeader("Content-Disposition", "attachment; filename=Consolidate_trip_report.xls");
	    	
	    	
	 	   
	 			 //------------Excel Starts here----------------------//
	 			 
	 			
	 			   
	 			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1)); 	//return type int
	 			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
	 			   HSSFRow rowhead = sheet.createRow((short)0);
	 			   
	 			   rowhead.setHeight((short)500);	
	 			   
	 			  //--------------1 st row-----------------//
	 			   
	 			    HSSFCell cell2B = rowhead.createCell(0);  
	 		        cell2B.setCellValue(new HSSFRichTextString("Round Trip Report for " +vehicle_number));  	        
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
			
			
			

			
			String mainLogic = "select latitude_value,longitude_value,tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no ='"+imeinumber+"' and date_time >(select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) order by date_time";
			System.out.println("main logic  query is  :"+mainLogic);
			rs1 = st1.executeQuery(mainLogic);
			
			
			if(rs1.next()){ //Starting value
				starttime=rs1.getString ("date_time");
				//Starttime1=starttime;
				System.out.println("first time is :"+starttime);
				start_lat=rs1.getString("latitude_value");
				start_lng = rs1.getString("longitude_value");
				start_time=df.parse(starttime);	
				}
			
			while(rs1.next()){
   				
   			    date_time = rs1.getString("date_time");
   				String lat_value=rs1.getString("latitude_value");		   				
   				String long_value=rs1.getString("longitude_value");
				String engine_status = rs1.getString("engine_status");
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
					}
					else{ fin_hr = ""+hour; }
					
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
									
								}//second iterate
								
							}//if boolean value is false
							
							else
							{ // off to on difference: 
								long timeDiff = (Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;									
								if(timeDiff > input_halt)			
								{													
									Map<String,Object> m=new HashMap<String,Object>();							
															
											halt_time = String.format("%d hour(s) %d min(s)",
												 TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime())),
									             TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime()))));																													
											lat_subString=lat_value.substring(0,4);																																	
												
											halt_min=Integer.parseInt(String.format("%d",TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime()))));
											
									//----------------Putting all the values in map--------------//		
																									
													m.put("start_time",start_time);
													m.put("min_time",min_time);	//last time								
													m.put("max_time",max_time);							
													m.put("lat_value",lat_value);
													m.put("long_value",long_value);
													m.put("start_lat",start_lat);
													m.put("start_lng",start_lng);
													m.put("halt_time",halt_time);
													m.put("halt_min", halt_min);
													start_lat = lat_value;
													start_lng = long_value;
													start_time = max_time;
													haltCounter++;	
													
													if(src_sub_lat.equals(lat_subString)){  																						
														equal_lat_Count.add(date_time);
														endTime = equal_lat_Count.get(0);  //once condition gets true ,pick out the time and consider as end time.																								
														equal_halt_Count.add(haltCounter);																								       
														haltCounter1 =equal_halt_Count.get(0);   //once condition gets true, pick out the count to compare the iteration																							
												
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
			Set keys = haltTimeMap.keySet();		
			Iterator it = keys.iterator();
			 int breakcondition = 0;						
			while(it.hasNext())
			{								
				String t=(String)it.next();
				
					if(breakcondition  == 1){   //------Stop Condition--------//									
						break;
					}	
					
					 List lt = (List)haltTimeMap.get(t); 	
					Iterator litr = lt.iterator();								
							while(litr.hasNext())
							{	
								Map hm = (Map)litr.next();																					
								whilecounter++;
								System.out.println("Stop condition counter :"+whilecounter);
								System.out.println("Stop condition halt counter1 :"+haltCounter1);
								if(whilecounter == haltCounter1 ){  
									halt_time="Round Trip Completed";
									hm.put("halt_time",halt_time);
								}												  
								starttime =df.format(hm.get("start_time"));
								minimum_time = df.format(hm.get("min_time"));											
								maximum_time = df.format(hm.get("max_time"));																													
								maximum_time = maximum_time.substring(0,19);  // While compiling both date should same. That it is why making substring  
								endTime = endTime.substring(0,19); 		
								halt_min = (Integer)hm.get("halt_min");
								
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
								//--------------  Geo address end ---------------// 
								
								ses_splitCount=(Integer)session.getAttribute("splitCount");
								//---------Highlighting the content ------------//
								if(halt_min>150){
								if(counter == ses_splitCount ){
									HSSFRow row = sheet.createRow((short)index);
									 row.setHeight((short)500);										   
									   row.createCell(0).setCellValue(Start_Address);
									   row.createCell(1).setCellValue(starttime);
									   Cell cel2 = row.createCell(2);
									   cel2.setCellStyle(cellStyle1); //------------Content Style-----------------//
									   cel2.setCellValue(Halt_Address);
									  // row.createCell(2).setCellValue(Halt_Address);									   
									   row.createCell(3).setCellValue(minimum_time);								   
									   //row.createCell(4).setCellValue(hal_time);
									   Cell cel = row.createCell(4);
									   cel.setCellStyle(cellStyle1); //------------Content Style-----------------//
									   cel.setCellValue(hal_time);
									   row.createCell(5).setCellValue(distance);
									   index++;	
									   counter++;
								}
								else{
									HSSFRow row = sheet.createRow((short)index);
									 row.setHeight((short)500);										   
									   row.createCell(0).setCellValue(Start_Address);
									   row.createCell(1).setCellValue(starttime);
									   Cell cel2 = row.createCell(2);
									  // cel2.setCellStyle(cellStyle1); //------------Content Style-----------------//
									   cel2.setCellValue(Halt_Address);
									  // row.createCell(2).setCellValue(Halt_Address);									   
									   row.createCell(3).setCellValue(minimum_time);								   
									   //row.createCell(4).setCellValue(hal_time);
									   Cell cel = row.createCell(4);
									   cel.setCellStyle(cellStyle1); //------------Content Style-----------------//
									   cel.setCellValue(hal_time);
									   row.createCell(5).setCellValue(distance);
									   index++;	
									   counter++;
								}
								}
								else if(halt_min>150){
									HSSFRow row = sheet.createRow((short)index);
									 row.setHeight((short)500);										   
									   row.createCell(0).setCellValue(Start_Address);
									   row.createCell(1).setCellValue(starttime);									 
									   row.createCell(2).setCellValue(Halt_Address);									   
									   row.createCell(3).setCellValue(minimum_time);
									   Cell cel2 = row.createCell(4);
									   cel2.setCellStyle(cellStyle1); //------------Content Style-----------------//
									   cel2.setCellValue(hal_time);
									   //row.createCell(4).setCellValue(hal_time);
									   row.createCell(5).setCellValue(distance);
									   index++;	
									   counter++;									
								}
								else if(counter == ses_splitCount){
									HSSFRow row = sheet.createRow((short)index);
									 row.setHeight((short)500);										   
									   row.createCell(0).setCellValue(Start_Address);
									   row.createCell(1).setCellValue(starttime);
									   Cell cel2 = row.createCell(2);
									   cel2.setCellStyle(cellStyle1); //------------Content Style-----------------//
									   cel2.setCellValue(Halt_Address);
									  // row.createCell(2).setCellValue(Halt_Address);									   
									   row.createCell(3).setCellValue(minimum_time);								   
									   //row.createCell(4).setCellValue(hal_time);
									   Cell cel = row.createCell(4);
									  // cel.setCellStyle(cellStyle1);
									   cel.setCellValue(hal_time);
									   row.createCell(5).setCellValue(distance);
									   index++;	
									   counter++;
								}
								/*if(counter != ses_splitCount){*/
								else{
								   HSSFRow row = sheet.createRow((short)index);
								   row.setHeight((short)500);	
								   //Cell cell0 = row.createCell(0);
								   row.createCell(0).setCellValue(Start_Address);
								   row.createCell(1).setCellValue(starttime);
								   row.createCell(2).setCellValue(Halt_Address);									   
								   row.createCell(3).setCellValue(minimum_time);								   
								   row.createCell(4).setCellValue(hal_time);
								   row.createCell(5).setCellValue(distance);								   
								   index++;	
								   counter++;
								}
								   //System.out.println("counter in excel issss ::::" + counter +"  address is  ::::"+Halt_Address);

								//-------------------------------Printing All the values into one way table-----------------------//								
								
									if( endTime.equals(maximum_time) ){		//if condtion gets match break the operation												
										breakcondition =1;
									}  
									
									
							
								
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
							
							//index++;
							
						
			       } //map iterate while	
				
			HSSFRow row1 = sheet.createRow((short)index+1);
			row1.setHeight((short)300);
			Cell cell12=	row1.createCell(0);
			cell12.setCellValue("Total Spend Time");  
			cell12.setCellStyle(cellStyle1);
 		    
			Cell cell13=row1.createCell(1);
			cell13.setCellValue((String)session.getAttribute("totalSpendTime"));
			cell13.setCellStyle(cellStyle1);
			
			HSSFRow row2 = sheet.createRow((short)index+2);
			row2.setHeight((short)300);
			Cell cell15=	row2.createCell(0);
			cell15.setCellValue("Total Halt Time");  
			cell15.setCellStyle(cellStyle1);
 		    
			Cell cell14=row2.createCell(1);
			cell14.setCellValue((String)session.getAttribute("totalHalt"));
			cell14.setCellStyle(cellStyle1);
			
			HSSFRow row3 = sheet.createRow((short)index+3);
			row3.setHeight((short)300);
			Cell cell16=	row3.createCell(0);
			cell16.setCellValue("Total Travelled Time");  
			cell16.setCellStyle(cellStyle1);
 		    
			Cell cell17=row3.createCell(1);
			cell17.setCellValue((String)session.getAttribute("totalTravelled"));
			cell17.setCellStyle(cellStyle1);
			
			
			out=response.getOutputStream();
			wb.write(out);
			
			con.close();
			rs.close();
			rs1.close();
			st.close();
			st1.close();
			
	

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
		 finally{
			   if (out != null)
			    out.close();
			  }
	}

}
