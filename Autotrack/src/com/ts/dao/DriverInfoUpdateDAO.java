package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.DriverInfo;


public class DriverInfoUpdateDAO {
	
	int row=0;
	public int DriverInfoValidate(DriverInfo DriverInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt = null;
			String action=DriverInfoobj.getAction();
			System.out.println(action);
			String license_number=DriverInfoobj.getLicense_number();
			System.out.println(license_number);

			if(action.equalsIgnoreCase("update"))
			{
				System.out.println("in query");
			pstmt=con.prepareStatement("update driver_info set driver_name=?,gender=?,contact_no=?,address=?,dob=?,doj=?,doi=?,doe=?,vehicle_number=?,shift_number=?,route_number=? where license_number='"+license_number+"';");
			//pstmt.setString(1,DriverInfoobj.getLicense_number());
			pstmt.setString(1,DriverInfoobj.getDriver_name());
			pstmt.setString(2,DriverInfoobj.getSex());
			pstmt.setString(3,DriverInfoobj.getContact_no());
			pstmt.setString(4,DriverInfoobj.getAddress());
			pstmt.setString(5,DriverInfoobj.getDate_of_birth());
			pstmt.setString(6,DriverInfoobj.getDate_of_joining());
			pstmt.setString(7,DriverInfoobj.getDate_of_issue());
			pstmt.setString(8,DriverInfoobj.getDate_of_expiry());
			pstmt.setString(9,DriverInfoobj.getVehicle_number());
			pstmt.setString(10,DriverInfoobj.getShift_number());
			pstmt.setString(11,DriverInfoobj.getRoute_number());
			
			
			
			
			row=pstmt.executeUpdate();
			
			}
			else if(action.equalsIgnoreCase("del"))
			{
				pstmt=con.prepareStatement("delete from driver_info where license_number='" +license_number+"'");
				row=pstmt.executeUpdate();
				
			}
			System.out.println(row);
			
			con.close();
			pstmt.close();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return row;
		
	}//validate

}
