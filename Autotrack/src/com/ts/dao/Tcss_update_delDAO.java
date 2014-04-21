package com.ts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ts.dbtransactionmgr.DBTransaction;

import com.ts.domain.TcssInfo;




public class Tcss_update_delDAO {
	
	int row=0;
	public int TcssInfoValidate(TcssInfo TcssInfoobj)
	{	
		DBTransaction dbtranobj=new DBTransaction();
		try{
		//String customer_id=vehicleinfoobj.getCustomer_id();
			String tcss_id_number= TcssInfoobj.getTcss_id_number();
		
		//String imei_no=vehicleinfoobj.getImei_no();
		String action= TcssInfoobj.getAction();
		System.out.println("Action"+action);
			Connection con=dbtranobj.connect();
			if(action.equalsIgnoreCase("Update"))
			{
			PreparedStatement pstmt=con.prepareStatement("update tcss_information set name=?,gender=?,contact_number=?,address=?,dob=?,doj=?,experience=?,vehicle_number=?,route_number=?,id_number=? where id_number='"+tcss_id_number+"'");
			
		
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
			
			row=pstmt.executeUpdate();
			}
			else if(action.equalsIgnoreCase("Delete"))
			{
				PreparedStatement pstmt=con.prepareStatement("delete from tcss_information where id_number='"+tcss_id_number+"'");
				
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



