package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.StudentInfo;




public class Student_update_del_DAO {
	
	int row=0;
	public int StudentInfoUpdateValidate(StudentInfo studentinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		//String customer_id=vehicleinfoobj.getCustomer_id();
			String enumber= studentinfoobj.getEnrollment_number();
		
		//String imei_no=vehicleinfoobj.getImei_no();
		String action= studentinfoobj.getAction();
		
			Connection con=dbtranobj.connect();
			if(action.equalsIgnoreCase("Update"))
			{
			PreparedStatement pstmt=con.prepareStatement("update student set name=?,gender=?,standard=?,section=?,dob=?,residence_address=?,route_number=?,location=?,pick_point=?,pick_up_timing=?,category=?,parent_name=?,occupation=?,designation=?,office_address=?,contact_number=?,email=?,mother_name=?,mother_occupation=?,mother_designation=?,mother_office_address=?,mother_contact_number=?,mother_email=?,residential_number=?  where enrolment_number='"+enumber+"'");
			
		
			pstmt.setString(1, studentinfoobj.getName());
			pstmt.setString(2, studentinfoobj.getGender());
			pstmt.setString(3, studentinfoobj.getStandard());
			pstmt.setString(4, studentinfoobj.getSection());
			pstmt.setString(5, studentinfoobj.getDob());
			pstmt.setString(6, studentinfoobj.getResidence_address());
			pstmt.setString(7, studentinfoobj.getRoutenumber());
			pstmt.setString(8, studentinfoobj.getLocations());
			pstmt.setString(9, studentinfoobj.getPick_point());
			pstmt.setString(10, studentinfoobj.getPick_up_timing());
			pstmt.setString(11, studentinfoobj.getCategory());
			pstmt.setString(12, studentinfoobj.getParent_name());
			pstmt.setString(13, studentinfoobj.getOccupation());
			pstmt.setString(14, studentinfoobj.getDesignation());
			pstmt.setString(15, studentinfoobj.getOffice_address());
			pstmt.setString(16, studentinfoobj.getContact_number());
			pstmt.setString(17, studentinfoobj.getEmail());
			pstmt.setString(18, studentinfoobj.getMother_name());
			pstmt.setString(19, studentinfoobj.getMother_occupation());
			pstmt.setString(20, studentinfoobj.getMother_designation());
			pstmt.setString(21, studentinfoobj.getMother_office_address());
			pstmt.setString(22, studentinfoobj.getMother_contact_number());
			pstmt.setString(23, studentinfoobj.getMother_email());
			pstmt.setString(24, studentinfoobj.getResidential_number());
			row=pstmt.executeUpdate();
			}
			else if(action.equalsIgnoreCase("Delete"))
			{
				PreparedStatement pstmt=con.prepareStatement("delete from student where enrolment_number='"+enumber+"'");
				
				row=pstmt.executeUpdate();
			}
			System.out.println( "row in DAO "+row);
				
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return row;
		
	}//validate

}


