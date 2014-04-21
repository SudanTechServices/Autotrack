package com.ts.dao;
import com.ts.domain.*;
import com.ts.dbtransactionmgr.*;
import com.ts.service.CommonService;

import java.io.IOException;
import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
public class LoginDAO {
	
public boolean validate(UserLogin usrlgnobj)
{
	//ses=request.getSession(false);
	PreparedStatement pstmt = null;
	
	try{
		
		DBTransaction dbtranobj=new DBTransaction();
		Connection con=dbtranobj.connect();
		//Connection con=dbtranobj.connect("jdbc:postgresql://localhost:5432/postgres");
		//PreparedStatement pstmt=con.prepareStatement("select * from login where username=? and password=?");
		pstmt=con.prepareStatement("select * from login_information where user_name=? and password=?");
		pstmt.setString(1, usrlgnobj.getUsername());
		pstmt.setString(2,usrlgnobj.getPassword());
		System.out.println(usrlgnobj.getPassword());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		{
			con.close();
			pstmt.close();
			rs.close();
			return true;
		}
		else{
			return false;
			}
		
		
	}//try
	
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	return false;
	
}


}
