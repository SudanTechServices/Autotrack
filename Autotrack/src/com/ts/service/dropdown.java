package com.ts.service;

import java.sql.Connection;
import java.util.HashMap;
import java.util.TreeMap;
import java.sql.ResultSet;
import java.sql.Statement;

import com.ts.dbtransactionmgr.DBTransaction;

public class dropdown {
			String vehicle_no,imei_no; 
			String vehicle_type;   
			DBTransaction dbtranobj=new DBTransaction();
			//public dropdown(){}   
			String dbquery=null;
			//HttpServletRequest request;
			//HttpSession ses;
			
			public TreeMap<String,String> getName(String belongs)    
			{   
				TreeMap<String,String> vehiclearray=new TreeMap<String,String>();
			//ArrayList<String> imeiarray=new ArrayList<String>();
			try    
			{      
				//HttpSession session = request.getSession(true);
				//System.out.println("i m in dropdown");
				//ses=request.getSession(false);
				//String belongs=(String)ses.getAttribute("belongs");
				//System.out.println("belongs="+belongs);
				Connection con=dbtranobj.connect();
				Statement stmt=con.createStatement();
				if(belongs.equals("owner"))
				{
				 dbquery="select vehicle_number,imei_no from vehicle_information order by vehicle_number";
				}
				else
				{
				 dbquery="select vehicle_number,imei_no from vehicle_information where customer_id='"+belongs+"' order by vehicle_number";
				}
				ResultSet rs=stmt.executeQuery(dbquery);
				
				while(rs.next())
				{
					vehicle_no=rs.getString(1);   
					imei_no=rs.getString(2);
					System.out.println(imei_no+" "+vehicle_no);
					vehiclearray.put(vehicle_no,imei_no);   
				}
			
				System.out.println(vehiclearray);
			  
			//System.out.println(b1);   
			}   
			catch(Exception ex)    
			{   
			ex.printStackTrace();   
			System.err.println("Exception: " + ex.getMessage());   
			}   
			finally  
			{
			}
			return vehiclearray;         
			}
			
			
			public TreeMap<String, String>getVehicleType(String belongs){
				TreeMap<String,String> vechicleType = new TreeMap<String, String>();
				try{
					Connection con=dbtranobj.connect();
					Statement stmt=con.createStatement();
					if(belongs.equals("owner"))
					{
					 dbquery="select vehicle_type,vehicle_number from vehicle_information order by vehicle_number";
					}
					else
					{
					 dbquery="select vehicle_type,vehicle_number from vehicle_information where customer_id='"+belongs+"' order by vehicle_number";
					}
					System.out.println("vehicle information  Query:"+dbquery);
					ResultSet rs=stmt.executeQuery(dbquery);
					
					while(rs.next())
					{
						vehicle_type=rs.getString(1);   
						imei_no=rs.getString(2);
						System.out.println(imei_no+" "+vehicle_type);
						vechicleType.put(vehicle_type,imei_no);   
					}
				
					System.out.println(vechicleType);
				  con.close();
				  stmt.close();
				  rs.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
				return vechicleType ;
				
			}//method
			
	
	}


		   
		
