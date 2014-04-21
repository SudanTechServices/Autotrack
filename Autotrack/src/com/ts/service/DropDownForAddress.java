package com.ts.service;
import java.sql.Connection;
import java.util.TreeMap;
import java.sql.ResultSet;
import java.sql.Statement;

import com.ts.dbtransactionmgr.DBTransaction;
public class DropDownForAddress {
	String address;
	String address_key;
	DBTransaction dbtranobj=new DBTransaction();
	String query=null;
	public TreeMap<String,String> getName()    
	{   
		TreeMap<String,String> addressArray=new TreeMap<String,String>();
		try    
		{      
			Connection con=dbtranobj.connect();
			Statement stmt=con.createStatement();
			
				query="select address from address";
			
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next())
			{
				address=rs.getString(1);   
				address_key=rs.getString(1);
				System.out.println("addrss is: " +address+"  lat is :" +address_key);
				addressArray.put(address,address_key); 
					
			}
			con.close();
			stmt.close();
			rs.close();
			
		}   
		catch(Exception ex)    
		{   
		ex.printStackTrace();   
		System.err.println("Exception: " + ex.getMessage());   
		}   
		finally  
		{
			
		}
		
		return addressArray;	
	}
}
