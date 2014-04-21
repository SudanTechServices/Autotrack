package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.CustomerInfo;



public class CustomerInfoUpdateDAO {
	
	int row=0;
	public int CustomerInfoUpdateValidate(CustomerInfo customerinfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		String customer_id=customerinfoobj.getCustomer_id();
		String action=customerinfoobj.getAction();
		System.out.println("Customer ID  "+customer_id);
		System.out.println(action);
			Connection con=dbtranobj.connect();
			if(action.equalsIgnoreCase("Update"))
			{
			PreparedStatement pstmt=con.prepareStatement("update customer_information set customer_id=?,name=?,address=?,contact_number=?,contact_person=?,contract_start_date=?,contract_end_date=?,no_of_licence=? where customer_id='"+customer_id+"'");
		
			pstmt.setString(1,customerinfoobj.getCustomer_id());
			pstmt.setString(2,customerinfoobj.getCustomername());
			pstmt.setString(3,customerinfoobj.getCustomer_address());
			pstmt.setString(4,customerinfoobj.getCustomer_number());
			pstmt.setString(5,customerinfoobj.getContact_person());
			pstmt.setString(6,customerinfoobj.getContract_start_date());
			pstmt.setString(7,customerinfoobj.getContract_end_date());
			pstmt.setInt(8, customerinfoobj.getNumber_of_licence());
			row=pstmt.executeUpdate();
			}
			else if(action.equalsIgnoreCase("Delete"))
			{
				PreparedStatement pstmt=con.prepareStatement("delete from customer_information where customer_id='"+customer_id+"'");
				row=pstmt.executeUpdate();
			}
			System.out.println(row);
				
		}//try
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return row;
		
	}//validate

}

