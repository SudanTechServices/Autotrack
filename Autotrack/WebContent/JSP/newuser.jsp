<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Autotrack - New User</title>
<link rel="stylesheet" href="../CSS/style.css" type="text/css" />

<script type="text/javascript" src="../JS/validate.js"></script>

<script type="text/javascript" >


function refresh()
{
	document.getElementById("rec").disabled = true;
}
	
	function postmail()
	{
		
		//var from = document.mailinfo.from.value;
		//var text = document.mailinfo.text.value;
		//var password=document.mailinfo.password.value;
		if(newuservalidation())
			{
		document.mailinfo.action="/Autotrack/ControllerServlet/NewUser";
		document.mailinfo.submit();
			}
	}
	function login()
	{
		document.mailinfo.action="login.jsp";
		document.mailinfo.submit();
	}

</script>
</head>

<body style="background:url(../images/login_bg.jpg); background-repeat:repeat-x; width:100%;">
<%String mode=request.getParameter("mode");
//System.out.println(session.getId());
if(mode==null)
mode="";
else if(mode.equals("invalid"))
mode="Invalid Username or Password";

else
mode="";
%>
<center>
<div class="wrapper">
<div style="height:60px;"></div>

  <div class="top">&nbsp;</div><br />
  <div style="padding-left:50px;">
  
  <form name="mailinfo" method="post">
    <table cellpadding="0" cellspacing="0" class="newuser_bg">
     
      <tr>
        <td >
        	<table width="100%" cellpadding="3" cellspacing="10" border="0" class="login_cont">
            	<tr>
                	<td colspan="5"></td>
                 </tr>
                 <tr>
                 	<td></td>
                    <td>Mail ID </td>
                    <td>:</td>
                    <td><input type="text" name="to" placeholder="Mail Id" style="height: 25px; width: 220px;" /></td>
                    <td></td>
                  </tr>
                  <tr>
                 	<td></td>
                    <td>Contact No</td>
                    <td>:</td>
                    <td><input type="text" name="cnum" value="" placeholder="Contact Number" style="height: 25px; width: 220px;" /></td>
                    <td></td>
                  </tr>                 
				  <tr>
                 	<td></td>
                    <td valign="top">Comments</td>
                    <td valign="top">:</td>
                    <td><textarea name="text" rows="2" cols="22" placeholder="Comments" style="width: 220px;"></textarea></td>
                    <td></td>
                  </tr>
                                  
                 <tr>
              <td align="center" colspan="5">
              <input type="button" value="" name="send" onclick="postmail();" style="border-style: none; background: url('../images/send_mail.png') no-repeat; width: 137px; height: 45px;" />
               <input type="button" value="" name="" onclick="login();" style="border-style: none; background: url('../images/login_buttom.png') no-repeat; width: 137px; height: 45px;" />
              </td>
            </tr>
                  </table>  
        </td>
      </tr>
      
    </table>
    </form>
  </div>
</div>
</center>

</body>
</html>
