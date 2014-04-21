package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.VehicleInfo;



public class VehicleInfoUpdateDAO {
	
	int row=0;
	public int VehicleInfoUpdateValidate(VehicleInfo vehicleinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
			
			PreparedStatement pstmt = null;
			
		//String customer_id=vehicleinfoobj.getCustomer_id();
			String vehicle_number=vehicleinfoobj.getVehicle_no();
		
		//String imei_no=vehicleinfoobj.getImei_no();
		String action=vehicleinfoobj.getAction1();
		
			Connection con=dbtranobj.connect();
			if(action.equalsIgnoreCase("Update"))
			{
			pstmt=con.prepareStatement("update vehicle_information set customer_id=?,customer_name=?,vehicle_number=?,vehicle_type=?,fuel_tank_capacity=?,sim_no=?,imei_no=?,camera_id=?,vehicle_mfg=?,max_speed=?,fuel_sender=?,empty_fuel_voltage=?,full_fuel_voltage=? where vehicle_number='"+vehicle_number+"'");
			
		
			pstmt.setString(1,vehicleinfoobj.getCustomer_id());
			pstmt.setString(2,vehicleinfoobj.getCustomer_name());
			pstmt.setString(3,vehicleinfoobj.getVehicle_no());
			pstmt.setString(4,vehicleinfoobj.getVehicle_type());
			pstmt.setDouble(5,vehicleinfoobj.getFuel_tank());
			pstmt.setString(6,vehicleinfoobj.getSim_no());
			pstmt.setString(7,vehicleinfoobj.getImei_no());
			pstmt.setString(8, vehicleinfoobj.getCamera_id());
			pstmt.setString(9, vehicleinfoobj.getVehicle_mfg());
			pstmt.setInt(10, vehicleinfoobj.getMax_speed());
			pstmt.setString(11, vehicleinfoobj.getFuel_sender());
			pstmt.setDouble(12, vehicleinfoobj.getMin_fuel_volt());
			pstmt.setDouble(13, vehicleinfoobj.getMax_fuel_volt());
			row=pstmt.executeUpdate();
			}
			else if(action.equalsIgnoreCase("Delete"))
			{
				pstmt=con.prepareStatement("delete from vehicle_information where vehicle_number='"+vehicle_number+"'");
				row=pstmt.executeUpdate();
			}
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

