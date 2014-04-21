package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.DriverInfo;
import com.ts.domain.TcssInfo;


public class TcssInfoDAO {
	
	
	public void TcssInfoValidate(TcssInfo TcssInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into tcss_information values(?,?,?,?,?,?,?,?,?,?)");
			
			
			pstmt.setString(1,TcssInfoobj.getName());
			pstmt.setString(2,TcssInfoobj.getGender());
			pstmt.setString(3,TcssInfoobj.getContact_number());
			pstmt.setString(4,TcssInfoobj.getAddress());
			pstmt.setString(5,TcssInfoobj.getDate_of_birth());
			pstmt.setString(6,TcssInfoobj.getDate_of_joining());
			pstmt.setString(7,TcssInfoobj.getYears_of_exp());
			pstmt.setString(8,TcssInfoobj.getVehicle_number());
			pstmt.setString(9,TcssInfoobj.getRoute_number());
			pstmt.setString(10,TcssInfoobj.getTcss_id_number());
			
			
			
			
			
			pstmt.executeUpdate();
			
				
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		
	}//validate

}
