package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.BusRouteInfo;


public class RouteDeleteDAO {
	
	int row=0;
	public int busrouteUpdateValidate(BusRouteInfo busrouteinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		String busroute=busrouteinfoobj.getBus_route_number();
		System.out.println(busroute);
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("delete from route_registration  where bus_route_number='"+busroute+"'");
		    
			row=pstmt.executeUpdate();
			System.out.println(row);
				
			con.close();
			pstmt.close();
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return row;
		
	}//validate

}
