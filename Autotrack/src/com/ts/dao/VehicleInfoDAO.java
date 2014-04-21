package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.VehicleInfo;

public class VehicleInfoDAO {
	public void vehicleInfoValidate(VehicleInfo vehicleinfoobj)
	{	//UserLogin usrlgnobj=new UserLogin();
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into vehicle_information values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pstmt.setString(1,vehicleinfoobj.getVehicle_no());
			pstmt.setString(2,vehicleinfoobj.getVehicle_type());
			pstmt.setDouble(3,vehicleinfoobj.getFuel_tank());
			pstmt.setString(4,vehicleinfoobj.getSim_no());
			pstmt.setString(5,vehicleinfoobj.getImei_no());
			pstmt.setString(6,vehicleinfoobj.getCamera_id());
			pstmt.setString(7,vehicleinfoobj.getVehicle_mfg());
			pstmt.setInt(8,vehicleinfoobj.getMax_speed());
			pstmt.setString(9,vehicleinfoobj.getFuel_sender());
			pstmt.setDouble(10,vehicleinfoobj.getMin_fuel_volt());
			pstmt.setDouble(11,vehicleinfoobj.getMax_fuel_volt());
			//pstmt.setString(12,vehicleinfoobj.getBelongs());
			pstmt.setString(12,vehicleinfoobj.getCustomer_id());
			pstmt.setString(13,vehicleinfoobj.getCustomer_name());
			
			
			int row=pstmt.executeUpdate();
			System.out.println(row +" no of row updated");
			
			con.close();
			pstmt.close();
				
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		
	}//validate

}
