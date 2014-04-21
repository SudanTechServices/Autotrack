package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.BusRouteInfo;


public class BusRouteInfoDAO {
	
	
	public void busrouteInfoValidate(BusRouteInfo busrouteinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into route_registration values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pstmt.setString(1,busrouteinfoobj.getBus_route_number());
			pstmt.setString(2,busrouteinfoobj.getSource());
			pstmt.setString(3,busrouteinfoobj.getDestination());
			pstmt.setString(4,busrouteinfoobj.getStopping_point_1());
			pstmt.setString(5, busrouteinfoobj.getRate_1());
			pstmt.setString(6, busrouteinfoobj.getStopping_point_2());
			pstmt.setString(7, busrouteinfoobj.getRate_2());
			pstmt.setString(8, busrouteinfoobj.getStopping_point_3());
			pstmt.setString(9, busrouteinfoobj.getRate_3());
			pstmt.setString(10, busrouteinfoobj.getStopping_point_4());
			pstmt.setString(11, busrouteinfoobj.getRate_4());
			pstmt.setString(12, busrouteinfoobj.getStopping_point_5());
			pstmt.setString(13, busrouteinfoobj.getRate_5());
			pstmt.setString(14, busrouteinfoobj.getVehiclenumber());
			
			
			
			pstmt.executeUpdate();
			
			con.close();
			pstmt.close();
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		//return row;
	}//validate

}
