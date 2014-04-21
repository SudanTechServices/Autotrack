package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.BusRouteInfo;
import com.ts.domain.StudentInfo;


public class StudentInfoDAO {
	
	int row=0;
	public int studentInfoSave(StudentInfo studentinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into student values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pstmt.setString(1,studentinfoobj.getEnrollment_number());
			pstmt.setString(2,studentinfoobj.getName());
			pstmt.setString(3, studentinfoobj.getGender());
			pstmt.setString(4, studentinfoobj.getStandard());
			pstmt.setString(5, studentinfoobj.getSection());
			pstmt.setString(6, studentinfoobj.getDob());
			pstmt.setString(7, studentinfoobj.getResidence_address());
			pstmt.setString(8, studentinfoobj.getRoutenumber());
			pstmt.setString(9, studentinfoobj.getLocations());
			pstmt.setString(10, studentinfoobj.getPick_point());
			pstmt.setString(11, studentinfoobj.getPick_up_timing());
			pstmt.setString(12, studentinfoobj.getCategory());
			pstmt.setString(13, studentinfoobj.getParent_name());
			pstmt.setString(14, studentinfoobj.getOccupation());
			pstmt.setString(15, studentinfoobj.getDesignation());
			pstmt.setString(16, studentinfoobj.getOffice_address());
			pstmt.setString(17, studentinfoobj.getContact_number());
			pstmt.setString(18, studentinfoobj.getEmail());
			pstmt.setString(19, studentinfoobj.getMother_name());
			pstmt.setString(20, studentinfoobj.getMother_occupation());
			pstmt.setString(21, studentinfoobj.getMother_designation());
			pstmt.setString(22, studentinfoobj.getMother_office_address());
			pstmt.setString(23, studentinfoobj.getMother_contact_number());
			pstmt.setString(24, studentinfoobj.getMother_email());
			pstmt.setString(25, studentinfoobj.getResidential_number());
			
			
			row=pstmt.executeUpdate();
			
				
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		return row;
	}//validate

}
