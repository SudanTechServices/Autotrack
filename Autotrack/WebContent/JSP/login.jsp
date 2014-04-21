<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Welcome to our Autotrack </title>

<link rel="shortcut icon" href="images/fav_icon.ico" />
	
<link rel="stylesheet" href="../CSS/style.css" type="text/css" />
<script type="text/javascript">
 window.history.forward();
function noBack() { window.history.forward(); } 
</script>

<script type="text/javascript">

	function login()
	{

			document.loginpage.action="/Autotrack/ControllerServlet/LoginService";//it go to controllerservlet and after that it go to LoginService
			document.loginpage.submit();
		
	}
	function keySubmit()
	{	
		if(window.event.keyCode==13)
		{
			if(checkNotBlankTB('loginpage','usrname','Username ') && checkNotBlankTB('loginpage','password','Password '))
			{
				document.loginpage.action="/Autotrack/ControllerServlet/LoginService";
				document.loginpage.submit();
			}
		}
	}
	
</script>

</head>
<%
String newuser = request.getParameter("newuser");
String passwordsent = request.getParameter("passwordsent");
String mailid = request.getParameter("mailid");
if(newuser==null){
	newuser = "";
}
else if(newuser.equals("yes")){
	newuser = "Your request sent to Admin Successfully !!";
}

if(passwordsent==null){
	passwordsent = "";
}
else if(passwordsent.equals("yes")){
	passwordsent = "Password sent successfully to "+mailid;
}

String mode=request.getParameter("mode");
System.out.println(session.getId());
if(mode==null)
mode="";
else if(mode.equals("invalid"))
mode="Invalid Username or Password";
else if(mode.equals("out"))
mode="Successfully logged out!!!";
else if(mode.equals("ok"))
mode="Successfully registered";
else
mode="";
%>
<body style="background:url(../images/login_bg.jpg); background-repeat:repeat-x; width:100%;" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
<center>
<div class="wrapper">
<div style="height:20px;"></div>
  <div class="top">&nbsp;</div><br />
  <div style="padding-left:50px;">
  
  <form name="loginpage" method="post">
    <table cellpadding="0" cellspacing="0" class="login_bg">
    	
      <tr>
        <td><table width="100%" cellpadding="2" cellspacing="1" class="login_cont">
            <tr>
            <td colspan="4" align="center">
           		<div style="color: red; padding-top: 25px;"><label><%=mode%></label></div>
           		<div style="color: red; font-size: 12px;"><label><%=passwordsent%></label></div>
            	<div style="color: red; font-size: 12px;"><label><%=newuser%></label></div>
            </td>
            </tr>
            <tr>
              <td align="center" height="20px" colspan="2"></td>
            </tr>
            <tr>
            	<td width="7%"></td>
            	<td>User Name</td>
            	<td>:</td>
            	<td>            	
            		<input type="text" name="usrname" placeholder="User Name" id="txtUname" style="height: 25px; width: 220px;"  onkeypress="keySubmit();" />
               	</td>  
            </tr>
            <tr>
            	<td></td>
            	<td>Password</td>
            	<td>:</td>
            	<td>           		
            		<input type="password" name="password" placeholder="Password" id="txtPwd" style="height: 25px; width: 220px;" onkeypress="keySubmit();" />
            	
            	</td>
            
            </tr>
            
            <tr>
              <td align="center" height="10px" colspan="4"></td>
            </tr>
            <tr>
              <td colspan="4">
              	<table cellpadding="0" cellspacing="0"  border="0">
                	<tr>
                       <td width="10%"></td>
                       <td><img src="../images/forgot_password.png" /></td>
                       <td></td> 
                       <td class="login_contnt" align="left" style="padding-left:10px;"><a href="../JSP/forgetpassword.jsp">Forgot Password</a></td>
                       <td width="20px"></td>
                       <td><img src="../images/new_user.png" /></td>
                       <td></td> 
                       <td class="login_contnt" align="left" style="padding-left:10px;"><a href="../JSP/newuser.jsp">New User</a></td>
                       <td></td>
                      </tr>
                      </table>                          
                       </td>              
            </tr>
            <tr>
              <td align="center" height="10px" colspan="4"></td>
            </tr>
            <tr>
              <td align="center" colspan="4">
              <input type="submit" value="" name="" onclick="login();"  style="border-style: none; background: url('../images/login_buttom.png') no-repeat; width: 137px; height: 45px; cursor: pointer;" />

              </td>
            </tr>
          </table></td>
      </tr>     
    </table></form>
  </div>
</div>
</center>
</body>
</html>
