<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Welcome to AutoTrack</title>


<link rel="stylesheet" href="../css/style.default.css" type="text/css" />
<link rel="stylesheet" href="../prettify/prettify.css" type="text/css" />
<script type="text/javascript" src="../prettify/prettify.js"></script>
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/custom.js"></script>
<link rel="shortcut icon" href="../images/fav_icon.ico" />
<!--[if lte IE 8]>
<script language="javascript" type="text/javascript" src="../js/excanvas.min.js"></script><![endif]-->


<!--Current Date and Time-->    
<script type="text/javascript" src="../js/current_date.js"></script>

<script type="text/javascript">
function Logout()
{	
	
	self.parent.location="logout.jsp";	
}
function reset()
{
	
	document.dashboard.action="/Autotrack_new/jsp/resetpassword.jsp";
	document.dashboard.submit();
}
</script>

<!-- Form -->
<script type="text/javascript" src="../js/validate.js"></script>
<script type="text/javascript">
window.history.forward();
function noBack() { window.history.forward(); }
<%	String admin = (String)session.getAttribute("user"); 
System.out.println(admin);

%>

	function update()
	{
		var user=document.reset.username.value;
		var newpassword = document.reset.newpassword.value;
		var cpassword = document.reset.cpassword.value;
		if(newpassword == "" || cpassword == ""){
			alert("Password Cannot Be Blank");
		}
		else{
		alert("Your Password is Sussessfully Reseted");
		document.reset.action="/Autotrack_new/ControllerServlet/reset_password_service?username="+user;
		document.reset.submit();
		}
	}

</script>
</head>
<body>
<%

 
 String mode=request.getParameter("mode");
 String mode1=request.getParameter("mode1");
 System.out.println(" Mode 0 = "+mode);
 System.out.println(" Mode 1 = "+mode1);
 
//System.out.println(session.getId());
if(mode==null)
mode=""; 

else if(mode.equals("invalid"))
mode="Invalid Password";

if(mode1==null)
mode1="";

else if(mode1.equalsIgnoreCase("Mismatch"))
mode1="new password and confirm password did not match";

else
{
mode="";
mode1 = "";
}
String mailid=request.getParameter("emailid");

%> 

<!-- <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="refresh();"> -->
<div class="mainwrapper">
	
    <!-- START OF LEFT PANEL -->
    <div class="leftpanel">
    	
       <div class="logopanel">
        	<h1><a href="dashboard.jsp"><img src="../images/pro_logo.png" /></a></h1>
        </div><!--logopanel-->
        <div class="datewidget"><span id="date"></span></div>
    
    	<div class="searchwidget">
        	<form action="livetracking.jsp" method="post">
            	<div class="input-append">
                    <input type="text" class="span2 search-query" placeholder="Search here...">
                    <button type="submit" class="btn"><span class="icon-search"></span></button>
                </div>
            </form>
        </div><!--searchwidget-->
        
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Main Navigation</li>
                <li><a href="dashboard.jsp"><span class="icon-align-justify"></span> Dashboard</a></li>
                <li><a href="summery.jsp"><span class="icon-picture"></span> Summary</a></li>
                <li><a href="quickview.jsp"><span class="icon-th-list"></span> Quick View</a></li>                
                <li><a href="livetracking.jsp"><span class="icon-pencil"></span> Live Tracking by Vehicle </a></li>
                <li><a href="allvehicle_tracking.jsp"><span class="icon-font"></span> All Vehicle Live Tracking</a></li>
                <li class="dropdown"><a href="#"><span class="icon-signal"></span>Reports</a>
                	<ul>
                    	<li><a href="generalreports.jsp"><span class="icon-signal"></span>General Reports</a></li>
                        <li><a href="userdefined.jsp"><span class="icon-signal"></span>User Defined</a></li>
                    </ul>
                	
                </li>
                <li class="dropdown"><a href="#"><span class="icon-briefcase"></span>Management</a>
                	<ul>
                    	<li><a href="user_account.jsp"><span class="icon-briefcase"></span>User Account</a></li>
                        <li><a href="driver_information.jsp"><span class="icon-briefcase"></span>Driver Information</a></li>
                        <li><a href="customer_information.jsp"><span class="icon-briefcase"></span>Customer Information</a></li>
                        <li><a href="vehicle_register.jsp"><span class="icon-briefcase"></span>Vehicle Information</a></li>
                    </ul>
                </li>
                
            </ul>
        </div><!--leftmenu-->
        
        
       
        
    </div><!--mainleft-->
    <!-- END OF LEFT PANEL -->
    
   <!-- START OF RIGHT PANEL -->
    <div class="rightpanel">
    
      <form name="dashboard" method="post">
    	<div class="headerpanel">
        	<a href="" class="showmenu" title="Close Menu"></a>            
                      
            <div class="headerright">            	
                
    			<div class="dropdown userinfo">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#">Welcome <%=session.getAttribute("user")%> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"  onclick="reset();"><span class="icon-wrench"></span>Reset Password</a></li>
                        <li class="divider"></li>
                        <li><a href="" ><span class="icon-off" onclick="Logout();"></span> Sign Out</a></li>
                    </ul>
                </div><!--dropdown-->
    		
            </div><!--headerright-->
            
    	</div><!--headerpanel-->
    	</form>
        <div class="breadcrumbwidget">        	
        	<ul class="breadcrumb">
                <li><a href="dashboard.jsp">Home</a> <span class="divider">/</span></li>
                <li><a href="#">Management</a> <span class="divider">/</span></li>
                <li class="active">User Account</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>Reset Password</h1> <span>This is the new user creation page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">Create User</h4>
                <div class="widgetcontent bordered shadowed">
                
                	<form name="reset" class="stdform" method="post">
                		
                		<P>
                        	<label>User Name</label>
                            <span class="field"><input type="text" name="username" id="username" value="<%=admin%>" disabled="disabled" class="input-xlarge" placeholder="Current Password" /></span>
                        </p>
                        
                        <P>
                        	<label>Current Password</label>
                            <span class="field"><input type="text" name="password" id="password" class="input-xlarge" placeholder="Current Password" /></span>
                            <%=mode%>
                        </p>
                        
                        
                        <p>
                        	<label>New Password</label>
                            <span class="field"><input type="text" name="newpassword" id="newpassword" class="input-xlarge" placeholder="New Password" /></span>
                        </p>
                        
                        <p>
                        	<label>Confirm New Password</label>
                            <span class="field"><input type="text" name="cpassword" id="cpassword" class="input-xlarge" placeholder="Confirm New Password" /></span>
                            <%=mode1%>
                        </p>
                        
                         
                         <p>
                            <span id="msg"></span>
                        </p>                         
                         
                          <p>
                        	
                            <span class="field">
                              <input name="" type="button" value="Submit" onclick="update()"/>                   
                            </span>
                           	
                        </p>                          	
                        
                    	
                    	
                    </form>  
                </div><!--widgetcontent-->                
               
               
            </div><!--contentinner-->
        </div><!--maincontent-->
        
    </div><!--mainright-->
    <!-- END OF RIGHT PANEL -->
    
    <div class="clearfix"></div>
    
   <div class="footer">
    	<div class="footerleft">Auto Track</div>
    	<div class="footerright">&copy; 2014,&nbsp;<a href="www.sudantechservices.com">Sudan Tech Services</a> </div>
    </div><!--footer-->

    
</div><!--mainwrapper-->
</body>
</html>