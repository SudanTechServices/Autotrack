package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.RouteInfo;


public class RouteInfoDAO {
	
	
	public void RouteInfoValidate(RouteInfo RouteInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into route values(?,?,?,?)");
			
			pstmt.setString(1,RouteInfoobj.getRoute_no());
			pstmt.setString(2,RouteInfoobj.getSource());
			pstmt.setString(3,RouteInfoobj.getDestination());
			pstmt.setString(4,RouteInfoobj.getVehicle_no());
			
			
			pstmt.executeUpdate();
			
			con.close();
			pstmt.close();
			
				
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		
	}//validate

}
