<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    	    <%@page import ="java.io.IOException"  %>
		    <%@page import ="java.io.OutputStream"  %>
		    <%@page import ="java.sql.Connection"  %>
		    <%@page import ="java.sql.ResultSet"  %>
		    <%@page import ="java.sql.SQLException"  %>
		    <%@page import ="java.sql.Statement"  %>
		    <%@page import ="java.text.DateFormat"  %>
		    <%@page import ="java.text.DecimalFormat"  %>
		    <%@page import ="java.text.ParseException"  %>
		    <%@page import ="java.text.SimpleDateFormat"  %>
		    <%@page import ="java.util.Date"  %>
		    <%@page import ="java.util.HashMap"  %>
		    <%@page import ="java.util.Iterator"  %>
		    <%@page import ="java.util.LinkedHashMap"  %>
		    <%@page import ="java.util.List"  %>
		    <%@page import ="java.util.ArrayList"  %>
		    <%@page import ="java.util.Map"  %>
		    <%@page import ="java.util.Set"  %>
		    <%@page import ="java.util.concurrent.TimeUnit"  %>
		    <%@page import ="javax.servlet.ServletException" %>		   
		    <%@page import ="javax.servlet.http.HttpServlet"  %>
		    <%@page import ="javax.servlet.http.HttpServletRequest "  %>
		    <%@page import ="javax.servlet.http.HttpServletResponse "  %>
		    <%@page import ="javax.servlet.http.HttpSession "  %>
		    
		    
		    <%@page import ="com.lowagie.text.Document "  %>
		    <%@page import ="com.lowagie.text.DocumentException "  %>
		    <%@page import ="com.lowagie.text.Element "  %>
		    <%@page import ="com.lowagie.text.Font "  %>
		    <%@page import ="com.lowagie.text.HeaderFooter "  %>
		    <%@page import ="com.lowagie.text.Image "  %>
		    <%@page import ="com.lowagie.text.PageSize "  %>
		    <%@page import ="com.lowagie.text.Paragraph "  %>
		    <%@page import ="com.lowagie.text.Phrase "  %>
		    <%@page import ="com.lowagie.text.Rectangle "  %>
		    <%@page import ="com.lowagie.text.pdf.PdfPCell "  %>
		    <%@page import ="com.lowagie.text.pdf.PdfPTable "  %>
		    <%@page import ="com.lowagie.text.pdf.PdfWriter "  %>
		    <%@page import ="com.ts.dbtransactionmgr.DBTransaction"  %>
		    <%@page import =" com.ts.excelservlet.Excel_Consolidated_Trip_report"  %>


    
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Consoldated TripReport PDF</title>
		</head>
		<body>
		
		<%!
		
		String start_latlng =null;
		String halt_latlng =null;
		String Start_Address =null;
		String Halt_Address =null;
		float st_lat =0.0f;
		float ht_lat =0.0f;
		float st_lng=0.0f;
		float ht_lng =0.0f;
		float distance =0.0f;
		String totalDist=null;
		
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
		
		
		%>
		
		<%
		 response.setContentType("application/pdf");
		 String filename="ConsolidatedReport.pdf";
		 response.setHeader("Content-Disposition", "attachment;filename=" + filename);
		 
		 String imeinumber = request.getParameter("imeinumber");
		 String one_way_srclat=(String) session.getAttribute("one_way_srclat");
		 String one_way_deslat= (String)session.getAttribute("one_way_deslat");		 
		 int input_halt_time=Integer.parseInt(request.getParameter("inputHaltTime")); 	
		 DBTransaction dbtranobj=new DBTransaction();	
		 int index=2;		   		
		 String one_way_last_time=null;
		 float[] widths ={6,3,6,3,3,2 };
		 PdfPTable table=new PdfPTable(widths);
		    
		  float[] widths1 ={6,3,6,3,3,2 };
		  PdfPTable Secondtable=new PdfPTable(widths1);
		  PdfPCell cell1;
		 
		  //PdfPCell cell2;
		  Document document=new Document(PageSize.A4,20,10,64,44);
		  
		    Font myContentStyle=new Font();
		    myContentStyle.setStyle("bold");
		    myContentStyle.setColor(0, 143, 235);
		    myContentStyle.setSize(12);
		    myContentStyle.isBold();	
		    
		    
		    
		    Font heading_style=new Font();
	   	 	heading_style.setStyle("bold");
	   	 	heading_style.setFamily("TIMES_ROMAN");
	 		heading_style.setSize(10);
	 		Font no_data_style=new Font();
	    	//no_data_style.setStyle("bold");
	    	no_data_style.setFamily("TIMES_ROMAN");
	    	no_data_style.setSize(10);
	    	no_data_style.setColor(255, 0, 0);
	    	Font data_style=new Font();
	    	data_style.setFamily("TIMES_ROMAN");
	    	data_style.setSize(10);
		    Connection con=null;	   
		    Statement st1 =null;
		    Statement st2 =null;
		    ResultSet rs1 =null;
		    ResultSet rs2 =null;
		    ResultSet rs3=null;
		    Statement stmt1=null;
		    
		  
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
		
			   
			    String vehicle_number="";
			    con=dbtranobj.connect();			
				st1=con.createStatement();
				st2=con.createStatement();
				rs1=st1.executeQuery("SELECT vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
				 if(rs1.next()){
					 vehicle_number=rs1.getString("vehicle_number");
				 }

				
				    PdfWriter writer=PdfWriter.getInstance(document,response.getOutputStream());
				    
				    Font style=new Font();
					style.setStyle("bold");
					//style.setColor(0, 143, 235);
					style.setSize(7);
					style.isBold();
					
					HeaderFooter header = new HeaderFooter(new Phrase("Autotrack"), false);
			     	HeaderFooter footer1 = new HeaderFooter(new Phrase("Powered By TransnetworkX                                                                                              ",style),true); 
			        footer1.setAlignment(Element.ALIGN_JUSTIFIED);
			        footer1.setBorder(Rectangle.NO_BORDER);
			     	header.setBorder(Rectangle.NO_BORDER);
			     	header.setAlignment(Element.ALIGN_CENTER); 
			     	document.setHeader(header);
			     	document.setFooter(footer1); 
			     	
			     	
			     	document.open();
			     	
			     	
			     	Image image = Image.getInstance("E:/workspace/Autotrack/WebContent/images/PDF_Logo.jpg");
			     	image.setAlignment(Element.ALIGN_JUSTIFIED_ALL); 
				    image.setAbsolutePosition(80f, 820f); 
				    document.add(image);
				   			    
				    //Table column metioning
				    
				    
				    Paragraph paragraph1=new Paragraph("Consolidated Trip Report for : "+vehicle_number+"",myContentStyle);
			        paragraph1.setSpacingAfter(10);
			    	paragraph1.setIndentationLeft(54);
			    	document.add(paragraph1);	
			    	
			    	table.addCell(new Paragraph("Start Position",heading_style));
				    table.addCell(new Paragraph("Start Time",heading_style));
				    table.addCell(new Paragraph("Halt Position",heading_style));
				    table.addCell(new Paragraph("Stoped At",heading_style));
				    table.addCell(new Paragraph("Halter Time",heading_style));
				    table.addCell(new Paragraph("KM",heading_style));
				    
				    table.setHeaderRows(1);
			    	
			 			
			    	
			    
			    	//-----------------Db Coding Starts here -------------------------------//
								 
					 if(double_src_lat < double_des_lat){		   			 	
							Query1="select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time >= (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) and latitude_value >='"+src_lat+"%' and latitude_value <='"+des_lat+"%' order by date_time";
								System.out.println("Query 3 one way src<  des (1): "+Query1);
								 
						   }
					 if(double_src_lat > double_des_lat){
							   Query1=" select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time >= (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) and latitude_value >='"+des_lat+"%' and latitude_value <='"+src_lat+"%' order by date_time";
								System.out.println("Query 3 one way src >  des (2): "+Query1);
					 	}
					 
					 rs2 =st2.executeQuery(Query1);			
			   			if(rs2.next()){ //Starting value	   				
							starttime=rs2.getString ("date_time");						   			
							start_lat=rs2.getString("latitude_value");
							start_lng = rs2.getString("longitude_value");
							start_time=df.parse(starttime);	
			   			}
			   			while(rs2.next()){
			   				
			   				String date_time = rs2.getString("date_time");
			   				String lat_value=rs2.getString("latitude_value");		   				
			   				String long_value=rs2.getString("longitude_value");
							String engine_status = rs2.getString("engine_status");
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
										lat = lat_value;
										lon = long_value;								
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
													/** It gives exact location we don't skip exact location 
														so we took next count of this loop.(By this we can get exact location)
														
													*/																																						
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
											
											String dist = String.valueOf(distance);
											//-------------- Geo address end---------------// 
											 
											table.addCell(new Paragraph(Start_Address,data_style));
											table.addCell(new Paragraph(starttime,data_style));
											table.addCell(new Paragraph(Halt_Address,data_style));
											table.addCell(new Paragraph(minimum_time,data_style));
										    table.addCell(new Paragraph(hal_time,data_style)); 
										    table.addCell(new Paragraph(dist,data_style));
											 									 									 
											
						                 }//last while	
										
										float totalDistance =0.0f;
										for(int i =0;i<=distance1.size()-1;i++){
											totalDistance= totalDistance +distance1.get(i);
										}							
									   totalDist =String.valueOf(totalDistance);
									  
										
						            }// if not equal
							
							  
						    
				   }
						    System.out.println("Total distance of 213132131323132   :"+totalDist);
						    cell1 = new PdfPCell(new Paragraph("Total Distance Travelled",heading_style));
						    cell1.setBorder(Rectangle.NO_BORDER);
						    cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
						    cell1.setColspan(5);
						    Secondtable.addCell(cell1);
						    
						    cell1 = new PdfPCell(new Paragraph(totalDist,heading_style));
						    cell1.setBorder(Rectangle.NO_BORDER);
						    cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	   									   									
						    Secondtable.addCell(cell1);   	   
						    
							float[] widths2 ={6,3,6,3,3,2 };
							PdfPTable Thirdtable=new PdfPTable(widths2);
							
							PdfPCell cell2 = new PdfPCell();						
							cell2 = new PdfPCell(new Paragraph("------Return Way Trip------",heading_style));							
							cell2.setBorder(Rectangle.NO_BORDER);							
							cell2.setHorizontalAlignment(Element.ALIGN_CENTER);							
							cell2.setColspan(6);	
							cell2.setPadding(15);
							Thirdtable.addCell(cell2);
							
							
							PdfPTable Fourthtable=new PdfPTable(widths2);																	
							Fourthtable.addCell(new Paragraph("Start Position",heading_style));
							Fourthtable.addCell(new Paragraph("Start Time",heading_style));
							Fourthtable.addCell(new Paragraph("Halt Position",heading_style));
							Fourthtable.addCell(new Paragraph("Stoped At",heading_style));
							Fourthtable.addCell(new Paragraph("Halter Time",heading_style));
							Fourthtable.addCell(new Paragraph("KM",heading_style));
						    
							
							
						    document.add(table);						   
						    document.add(Secondtable);						    
						    document.add(Thirdtable);
						    document.add(Fourthtable);
						 one_way_last_time = minimum_time;
						   
						 
						 
				} 
		 catch (ClassNotFoundException e) {			
					e.printStackTrace();
				} catch (IllegalAccessException e) {			
					e.printStackTrace();
				} catch (InstantiationException e) {			
					e.printStackTrace();
				} catch (SQLException e) {			
					e.printStackTrace();
				} catch (ParseException e) {
					
					e.printStackTrace();
				} catch (DocumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
		
		 //--------------------------Return way trip code Starts--------------------------------//
		 
 		 
		   String  startdate =one_way_last_time;
		    String  dest_halt_time=null;
			//int newIdx =index+1;
			String totalDis =null;
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
				
				PdfPTable fifthtable = new PdfPTable(widths1);
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				  try {
			 			DBTransaction dbtrans = new DBTransaction();
			 			//Connection con = dbtrans.connect();
			 			stmt1=  con.createStatement();
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
				   		    rs3 =stmt1.executeQuery(Query3);
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
											lat = lat_value;
											lon = long_value;										
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
														/** It gives exact location we don't skip exact location 
															so we took next count of this loop.(By this we can get exact location)
															
														*/													
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
													
													
													String dist = String.valueOf(distance);
													
													fifthtable.addCell(new Paragraph(Start_Address,data_style));
													fifthtable.addCell(new Paragraph(starttime,data_style));
													fifthtable.addCell(new Paragraph(Halt_Address,data_style));
													fifthtable.addCell(new Paragraph(minimum_time,data_style));
													fifthtable.addCell(new Paragraph(hal_time,data_style)); 
													fifthtable.addCell(new Paragraph(dist,data_style));
													
													   index++;																																																																		
								                 }//last while
												
												
												float totalDistance =0.0f;
												for(int i =0;i<=distance1.size()-1;i++){
													totalDistance= totalDistance +distance1.get(i);
												}							
												 totalDis = String.valueOf(totalDistance);
												
								            }// if not equal
									
								       } //map iterate while
								
								PdfPTable six_table = new PdfPTable(widths1);
								
							    cell1 = new PdfPCell(new Paragraph("Total Distance Travelled",heading_style));
							    cell1.setBorder(Rectangle.NO_BORDER);
							    cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
							    cell1.setColspan(5);
							    six_table.addCell(cell1);
							    
							    cell1 = new PdfPCell(new Paragraph(totalDis,heading_style));
							    cell1.setBorder(Rectangle.NO_BORDER);
							    cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	   									   									
							    six_table.addCell(cell1);   	
																
							   
							    
							    PdfPTable seven_table = new PdfPTable(1);		

							    cell1 = new PdfPCell(new Paragraph("Actuall Halt Time At Client location:"+dest_halt_time,heading_style));
							    cell1.setBorder(Rectangle.NO_BORDER);
							    cell1.setPadding(5);
							    cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	   									   									
							    seven_table.addCell(cell1); 
							  
							    
							    document.add(fifthtable);
							    document.add(six_table);
							    document.add(seven_table);
							    document.close();																			
								
								}//try
				  
				catch(IOException e){
					e.printStackTrace();
				} catch (SQLException e) {					
					e.printStackTrace();
				
				} catch (ParseException e) {
					e.printStackTrace();
				} catch (DocumentException e) {					
					e.printStackTrace();
				}
				finally{
					if(con!=null){
						 st1.close();
						 st2.close();
						 rs1.close();
						 rs2.close();
						 con.close();
						 stmt1.close();									
						 rs3.close();						 
					}
				}
				
			}
		
		%>
		
		
		</body>
		</html>