package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.DriverInfo;
import java.lang.*;

public class DriverInfoDAO {
	
	
	public void DriverInfoValidate(DriverInfo DriverInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into driver_info values(?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pstmt.setString(1,DriverInfoobj.getDriver_name());
			pstmt.setString(2,DriverInfoobj.getSex());
			pstmt.setString(3,DriverInfoobj.getContact_no());
			pstmt.setString(4,DriverInfoobj.getAddress());
			pstmt.setString(5,DriverInfoobj.getDate_of_birth());
			pstmt.setString(6,DriverInfoobj.getDate_of_joining());
			pstmt.setString(7,DriverInfoobj.getLicense_number());
			pstmt.setString(8,DriverInfoobj.getDate_of_issue());
			pstmt.setString(9,DriverInfoobj.getDate_of_expiry());
			pstmt.setString(10,DriverInfoobj.getVehicle_number());
			pstmt.setString(11,DriverInfoobj.getShift_number());
			pstmt.setString(12,DriverInfoobj.getRoute_number());
			
			
			
			
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
