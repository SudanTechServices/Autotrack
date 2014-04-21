<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>


      <%
            // declare a connection by using Connection interface 
           
            /*declare a resultSet that works as a table resulted by execute a specified 
			sql query. */
            ResultSet rs = null;

            // Declare statement.
            
           
		    // declare InputStream object to store binary stream of given image.
			InputStream sImage;

            try {
            	
            	DBTransaction dbtranobj=new DBTransaction();
        		Connection connection=dbtranobj.connect();

                

				/* prepareStatement() is used for create statement object that is 
	           used for sending sql statements to the specified database. */
        		String query = "select image from save_image where id=1";
        	    Statement stm = connection.createStatement();
        	    rs = stm.executeQuery(query);
        	    rs.next();
        	    String img = rs.getString("image");
        	    byte[] img2 = new byte[img.length()];
        	    InputStream imgstream = rs.getBinaryStream("image");
        	    int index = imgstream.read(img2, 0, img.length());
        	    stm.close();
        	    response.reset();
        	    response.setContentType("image/jpg");
        	    while ((index = imgstream.read(img2)) > -1) {
                    response.getOutputStream().write(img2);
                }
        	    response.getOutputStream().write(img2,0,img2.length);
        	    response.getOutputStream().flush();
        	    imgstream.close();

connection.close();
stm.close();
rs.close();
		    }
            catch(Exception ex){
				out.println("error :"+ex);
            }
	
         /*   finally {
                // close all the connections.
                rs.close();
                psmnt.close();
                
           }
			 */
     %>
	