<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trans Workx</title> 
	
	<link rel="stylesheet" href="../css/reset.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/text.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/form.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/buttons.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/grid.css" type="text/css" media="screen" title="no title" />	
	<link rel="stylesheet" href="../css/layout.css" type="text/css" media="screen" title="no title" />	
	<link rel="stylesheet" href="../css/custom.css" type="text/css" media="screen" title="no title" />	
<script type="text/javascript">


	function search()
	{
		/* var emailid=document.eid.username.value; */
		document.eid.action="/Autotrack/ControllerServlet/emailpassword";
		document.eid.submit();
	}

</script>

</head>
<body">

<%String mode=request.getParameter("mode");
//System.out.println(session.getId());
if(mode==null)
mode="";
else if(mode.equals("invalid"))
mode="Invalid User Name or MailID";

else
mode="";
%>


<div id="header">
		
		<div class="content_pad">
			<h1><a href="#">Trans Workx</a></h1>
			
			<ul id="nav" style="float: right; padding-right: 500px;">
										
				<img alt="" src="../images/login_logo.png">		
			
								
				
	</div> <!-- #masthead -->			</ul>
		</div> <!-- .content_pad -->
		
	</div> <!-- #header -->	
	<div id="content" class="xgrid" style="height: 300px;padding-bottom: 180px">
	<div><h2 style="padding-top:50px">Forget Password</h2></div>
	

<form name="eid" method="post">
<font color="red"><label><%=mode%></label></font>

<table style="height:200px;padding-left:100px;">
<tr>

<td>Enter User Name  </td>
<td><input type="text" name="username"></td>

</tr>
<tr>
<td>Enter Email ID </td>
<td><input type="text" name="emailid"></td>

</tr>
<tr>
<td></td>
<td align="center">
<input type="button" name="sendpwd"  value="SendPassword" class="submit" onclick="search();">
</td>
</tr>
</table>

</form>
</div> <!-- #content -->
	
	<div id="footer" >		
		<div class="content_pad">			
			<p>&copy; 2012 Copyright TransNetworkx. Powered by <a href="#">Digital Astraa Solutions Pvt Ltd</a>.</p>
		</div> <!-- .content_pad -->
	</div> <!-- #footer -->		
	
</div> <!-- #wrapper -->


</body>
</html>