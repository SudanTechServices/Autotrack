package com.ts.dbtransactionmgr;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBTransaction {

	//private String driver="com.mysql.jdbc.Driver";
	//private String url="jdbc:postgresql://182.74.73.29:5432/master_database";
	private String url="jdbc:postgresql://localhost:5432/master_database";
    private String dbuser="postgres";
    private String dbpwd="root";
    Connection dbCon = null;
           
    public String getDbuser() {return this.dbuser;}
    public String getDbpwd() {return this.dbpwd;}
    //public String getDriver() {return this.driver;}
  //  public String getUrl() {return this.url;}
    
    public Connection connect() throws ClassNotFoundException, SQLException,IllegalAccessException,InstantiationException
    {
    	//DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    	Class.forName("org.postgresql.Driver");
        dbCon = DriverManager.getConnection(url, this.getDbuser(), this.getDbpwd());
        return dbCon;
    }
    public void close() throws SQLException 
    {
    	dbCon.close();
    }
   
}