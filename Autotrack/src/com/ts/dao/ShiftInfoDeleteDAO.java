package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.ShiftInfo;


public class ShiftInfoDeleteDAO {
	
	int row=0;
	public int ShiftInfoValidate(ShiftInfo shiftInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
			String shift_id=shiftInfoobj.getShift_id();
			System.out.println(shift_id);
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("delete from shift_info where shift_id='" +shift_id+"'");
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
