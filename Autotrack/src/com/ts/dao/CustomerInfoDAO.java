package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.CustomerInfo;


public class CustomerInfoDAO {
	
	
	public void customerInfoValidate(CustomerInfo customerinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		
			Connection con=dbtranobj.connect();
			PreparedStatement pstmt=con.prepareStatement("insert into customer_information values(?,?,?,?,?,?,?,?)");
			
			pstmt.setString(1,customerinfoobj.getCustomername());
			pstmt.setString(2,customerinfoobj.getCustomer_address());
			pstmt.setString(3,customerinfoobj.getCustomer_number());
			pstmt.setString(4,customerinfoobj.getContact_person());
			pstmt.setString(5,customerinfoobj.getContract_start_date());
			pstmt.setString(6,customerinfoobj.getContract_end_date());
			
			pstmt.setString(7,customerinfoobj.getCustomer_id());
			pstmt.setInt(8,customerinfoobj.getNumber_of_licence());
			pstmt.executeUpdate();
			
				
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		
	}//validate

}
