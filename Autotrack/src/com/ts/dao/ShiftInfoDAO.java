package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.ShiftInfo;


public class ShiftInfoDAO {
	
	
	public void ShiftInfoValidate(ShiftInfo ShiftInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into shift_info values(?,?,?)");
			
			pstmt.setString(1,ShiftInfoobj.getShift_id());
			pstmt.setString(2,ShiftInfoobj.getStart_time());
			pstmt.setString(3,ShiftInfoobj.getEnd_time());
			
			
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
