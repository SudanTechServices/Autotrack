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

<!-- Form -->
<script type="text/javascript" src="../js/user_account.js"></script>
<script type="text/javascript">
function funsubmit()
{
	
	if(User()){
	
			document.register.action="/Autotrack/ControllerServlet/RegisterService";
			document.register.submit();
			}
		
	}


function check(confrimpassword){
	
	var password = document.getElementById("password").value;
	document.getElementById("pass_strength").innerHTML = "";
	
	if(password == confrimpassword){
		document.getElementById("msg").innerHTML = "<div><label style='color:#008000;'> Password Matched !!</label></div>";
	}else{
		document.getElementById("msg").innerHTML = "<div><label style='color:red;'> Password did not match </label></div>";
	}
	
}

function check_password_strength(password){
	
	document.getElementById("autoSuggestionsList").innerHTML = "";
	
	if(password.length <= 4){
		document.getElementById("pass_strength").innerHTML = "<div><label style='color:#EF0067;'>Password too short(atlest 4 char)</label></div>";
	}else if(password.length > 4){
		document.getElementById("pass_strength").innerHTML = "<div><label style='color:#1C20C0;'>Password is OK</label></div>";
	}
}


</script>

</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="refresh();">
<% 
			String message=request.getParameter("message");
			
			if(message==null)
			{
				message="";
			}
			else if (message.equals("success"))
			{
				message="Successfully registered";
			}
			else if (message.equals("already"))
			{
				message=" This agent ID is already exist!!!";
			}
	%>
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
                <li class="dropdown"><a href="#"><span class="icon-signal"></span> Reports</a>
                	<ul>
                    	<li><a href="generalreports.jsp"><span class="icon-pencil"></span>General Reports</a></li>
                        <li><a href="userdefined.jsp"><span class="icon-pencil"></span>User Defined</a></li>
                    </ul>
                	
                </li>
                <li class="active dropdown"><a href="#"><span class="icon-briefcase"></span>Management</a>
                	<ul>
                    	<li><a href="user_account.jsp"><span class="icon-th-list"></span>User Account</a></li>
                        <li><a href="driver_information.jsp"><span class="icon-th-list"></span>Driver Information</a></li>
                        <li><a href="customer_information.jsp"><span class="icon-th-list"></span>Customer Information</a></li>
                        <li><a href="vehicle_register.jsp"><span class="icon-th-list"></span>Vehicle Information</a></li>
                        <li><a href="trip_sheet.jsp"><span class="icon-th-list"></span>Trip Sheet</a></li>
                        <li><a href="tcss_information.jsp"><span class="icon-th-list"></span>TCSS Information</a></li>
                         <li><a href="sblt_tripsheet.jsp"><span class="icon-th-list"></span>SBLT Trip Sheet</a></li>
                    </ul>
                </li>
                
            </ul>
        </div><!--leftmenu-->
        
        
       
        
    </div><!--mainleft-->
    <!-- END OF LEFT PANEL -->
    
    <!-- START OF RIGHT PANEL -->
    <div class="rightpanel">
    	<div class="headerpanel">
        	<a href="" class="showmenu"></a>
            
            <div class="headerright">
            	<div class="dropdown notification">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="/page.jsp">
                    	<span class="iconsweets-globe iconsweets-white"></span>
                    </a>
                    <ul class="dropdown-menu">
                    	<li class="nav-header">Notifications</li>
                        <li>
                        	<a href="">
                        	<strong>3 people viewed your profile</strong><br />
                            <img src="../images/thumbs/thumb1.png" alt="" />
                            <img src="../images/thumbs/thumb2.png" alt="" />
                            <img src="../images/thumbs/thumb3.png" alt="" />
                            </a>
                        </li>
                       <li><a href=""><span class="icon-envelope"></span> New message from <strong>Saamy GM</strong> <small class="muted"> - 19 hours ago</small></a></li>
                        <li><a href=""><span class="icon-envelope"></span> New message from <strong>VJ Vasu</strong> <small class="muted"> - 2 days ago</small></a></li>
                        <li><a href=""><span class="icon-user"></span> <strong>Thiru</strong> is now following you <small class="muted"> - 2 days ago</small></a></li>
                        <li class="viewmore"><a href="">View More Notifications</a></li>
                    </ul>
                </div><!--dropdown-->
                
    			<div class="dropdown userinfo">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="/page.jsp">Hi, Saamy GM! <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="editprofile.jsp"><span class="icon-edit"></span> Edit Profile</a></li>
                        <li class="divider"></li>
                        <li><a href=""><span class="icon-wrench"></span> Account Settings</a></li>
                        <li><a href=""><span class="icon-eye-open"></span> Privacy Settings</a></li>
                        <li class="divider"></li>
                        <li><a href="index.jsp"><span class="icon-off"></span> Sign Out</a></li>
                    </ul>
                </div><!--dropdown-->
    		
            </div><!--headerright-->
            
    	</div><!--headerpanel-->
        <div class="breadcrumbwidget">        	
        	<ul class="breadcrumb">
                <li><a href="dashboard.jsp">Home</a> <span class="divider">/</span></li>
                <li><a href="#">Management</a> <span class="divider">/</span></li>
                <li class="active">User Account</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>User Account</h1> <span>This is the new user creation page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">Create User</h4>
                <div class="widgetcontent bordered shadowed">
                
                	<form name="register" class="stdform" method="post">
                		
                        <P>
                        	<label>Company Name</label>
                            <span class="field"><input type="text" name="company" id="company" class="input-xlarge" placeholder="Company Name" /></span>
                        </p>
                        
                        <p>
                        	<label>Contact Number</label>
                            <span class="field"><input type="text" name="number" id="number" class="input-xlarge" placeholder="Contact Number" /></span>
                        </p>
                        
                        <p>
                        	<label>E mail Id</label>
                            <span class="field"><input type="text" name="email" id="email" class="input-xlarge" placeholder="E-mail Id" /></span>
                        </p>
                        
                         <p>
                        	<label>User Name</label>
                            <span class="field"><input type="text" name="usrname" id="usrname" onblur="lookup(this.value);" onclick="refresh();" class="input-xlarge" placeholder="User Name" /></span>
                            <span id="autoSuggestionsList"></span>
                        </p>
                        
                         <p>
                        	<label>Password</label>
                            <span class="field"><input type="text" name="password" id="password" onkeyup="check_password_strength(this.value)" class="input-xlarge" placeholder="Password" /></span>
                            <label id="pass_strength"></label>
                        </p>
                        
                       
                         <p>
                        	<label>Confirmed Password</label>
                            <span class="field"><input type="text" name="cpassword" id="cpassword" onkeyup="check(this.value)" onblur="refresh();" class="input-xlarge" placeholder="Conformed Password" /></span>
                         </p>
                         
                          <p>
                        	<label>Privilage</label>
                            <span class="field"><select name="privilage" id="privilage"><option>Select</option><option>Admin</option><option>Owner</option></select></span>
                         </p>
                         
                         <p>
                            <span id="msg"></span>
                        </p>                         
                        
                                                
                        <p class="stdformbutton">
                            <input type="button" value="Save" id="butsub" class="btn btn-success" onclick="funsubmit()">
                            <button type="reset" class="btn">Reset</button>
                        </p>
                                                
                    </form>  
                    <%=message %>
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