package com.ts.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.UserRegister;

public class UserRegisterDAO {
public boolean register(UserRegister usrrgsobj)
{
	DBTransaction dbtranobj=new DBTransaction();
	try{
	
		Connection con=dbtranobj.connect();
		PreparedStatement pstmt=con.prepareStatement("select * from login_information where user_name=?");
		pstmt.setString(1, usrrgsobj.getUsername());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		{
			rs.close();
			return false;
		}
		else{
			System.out.println("else");
			pstmt=con.prepareStatement("insert into login_information values(?,?,?,?,?,?,?)");
			pstmt.setString(1, usrrgsobj.getUsername());
			pstmt.setString(2, usrrgsobj.getPassword());
			pstmt.setString(3, usrrgsobj.getCompany());
			pstmt.setString(4, usrrgsobj.getEmail());
			pstmt.setString(5, usrrgsobj.getNumber());
			pstmt.setString(6, usrrgsobj.getPrivilage());
			pstmt.setString(7, usrrgsobj.getBelongs());
			
			int row=pstmt.executeUpdate();
			System.out.println(row);
			}
		
		con.close();
		pstmt.close();
			
	}//try
	
	catch(Exception e)
	{
		//System.err.println(e.getMessage());
		e.printStackTrace();
	}
	return true;
	
}//validate

}
