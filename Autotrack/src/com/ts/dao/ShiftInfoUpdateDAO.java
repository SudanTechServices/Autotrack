package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.ShiftInfo;


public class ShiftInfoUpdateDAO {
	
	int row=0;
	public int ShiftInfoValidate(ShiftInfo shiftInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
			String shift_id=shiftInfoobj.getShift_id();
			System.out.println(shift_id);
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("update shift_info set shift_id=?,start_time=?,end_time=? where shift_id='" +shift_id+"'");
			pstmt.setString(1,shiftInfoobj.getShift_id());
			pstmt.setString(2,shiftInfoobj.getStart_time());
			pstmt.setString(3,shiftInfoobj.getEnd_time());
			
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
