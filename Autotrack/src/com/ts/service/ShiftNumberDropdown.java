package com.ts.service;
import java.sql.Connection;
import java.util.HashMap;
import java.sql.ResultSet;
import java.sql.Statement;

import com.ts.dbtransactionmgr.DBTransaction;

public class ShiftNumberDropdown {
			String shift_id,start_time;   
			DBTransaction dbtranobj=new DBTransaction();
			//public dropdown(){}   
	   
			public HashMap<String,String> getName()    
			{   
				HashMap<String,String> ShiftIdArray=new HashMap<String,String>();
			//ArrayList<String> imeiarray=new ArrayList<String>();
			try    
			{         
				//System.out.println("i m in dropdown");
				
				Connection con=dbtranobj.connect();
				//String dburl="jdbc:postgresql://localhost:5432/productconfiguration";
				//String dbdriver="org.postgresql.Driver";
			
				//Class.forName("org.postgresql.Driver");
				//Connection con=DriverManager.getConnection(dburl,"postgres","aatman");
				Statement stmt=con.createStatement();
				String dbquery="select shift_id,start_time from shift_info";
				ResultSet rs=stmt.executeQuery(dbquery);
				
				while(rs.next())
				{
					shift_id=rs.getString(1);   
					start_time=rs.getString(2);
					ShiftIdArray.put(shift_id,start_time);   
					
				}
				
			  
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
			return ShiftIdArray;         
			}   
		}
