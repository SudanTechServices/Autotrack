package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.TripSheetInfo;



public class TripSheetInfoUpdateDAO {
	
	int row=0;
	public int TripSheetInfoUpdateValidate(TripSheetInfo tripsheetinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		//String customer_id=tripsheetinfoobj.getCustomer_id();
			
			int serial=tripsheetinfoobj.getSno();
		
		//String imei_no=tripsheetinfoobj.getImei_no();
	
			Connection con=dbtranobj.connect();
		
			PreparedStatement pstmt=con.prepareStatement("update trip_sheet set sno=?,vehicle_number=?,route_number=?,date=?,days=?,start_km=?,close_km=?,run_km=?,present_children=?,vehicle_outtime=?,vehicle_intime=?,driver_name=?,tcss_name=? where sno='"+serial+"'");
			
			pstmt.setInt(1,tripsheetinfoobj.getSno());
			pstmt.setString(2,tripsheetinfoobj.getVehicle_number());
			pstmt.setString(3,tripsheetinfoobj.getRoute_number());
			pstmt.setString(4,tripsheetinfoobj.getDate());
			pstmt.setString(5,tripsheetinfoobj.getDays());
			pstmt.setString(6,tripsheetinfoobj.getStart_km());
			pstmt.setString(7,tripsheetinfoobj.getClose_km());
			pstmt.setString(8, tripsheetinfoobj.getRun_km());
			pstmt.setString(9, tripsheetinfoobj.getPresent_children());
			pstmt.setString(10, tripsheetinfoobj.getVehicle_outtime());
			pstmt.setString(11, tripsheetinfoobj.getVehicle_intime());
			pstmt.setString(12, tripsheetinfoobj.getDriver_name());
			pstmt.setString(13, tripsheetinfoobj.getTcss_name());
			row=pstmt.executeUpdate();
			
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

