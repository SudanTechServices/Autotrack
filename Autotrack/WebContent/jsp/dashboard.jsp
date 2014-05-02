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
<script language="java script" type="text/java script" src="../js/excanvas.min.js"></script><![endif]-->


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
</head>
<body>
<div class="mainwrapper">
	
    <!-- START OF LEFT PANEL -->
    <div class="leftpanel">
    	
        <div class="logopanel">
        	<h1><a href="dashboard.jsp"><img src="../images/pro_logo.png" /></a></h1>
        </div><!--logo panel-->
        
        <div class="datewidget"><span id="date"></span></div>
    
    	<div class="searchwidget">
        	<form action="livetracking.jsp" method="post">
            	<div class="input-append">
                    <input type="text" class="span2 search-query" placeholder="Search here...">
                    <button type="submit" class="btn"><span class="icon-search"></span></button>
                </div>
            </form>
        </div><!--search widget-->
        
              
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Main Navigation</li>
                <li class="active"><a href="dashboard.jsp"><span class="icon-align-justify"></span> Dashboard</a></li>
                <li><a href="summary.jsp"><span class="icon-picture"></span> Summary</a></li>
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
                <li class="active">Dashboard</li>
            </ul>
        </div><!--breadcrumbwidget-->
      <div class="pagetitle">
        	<h1>Dashboard</h1> <span>This is a sample description for dashboard page...</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner content-dashboard">           	
                
                <div class="row-fluid">
                	<div class="span8">
                    	<ul class="widgeticons row-fluid">
                        	<li class="one_fifth"><a href=""><img src="../images/gemicon/location.png" alt="" /><span>Dashboard</span></a></li>
                            <li class="one_fifth"><a href="summary.jsp"><img src="../images/gemicon/archive.png" alt="" /><span>Summary</span></a></li>
                            <li class="one_fifth"><a href="quickview.jsp"><img src="../images/gemicon/reports.png" alt="" /><span>Quickview</span></a></li>
                            <li class="one_fifth"><a href="livetracking.jsp"><img src="../images/gemicon/edit.png" alt="" /><span>Live Tracking by Vehicle</span></a></li>
                            <li class="one_fifth"><a href="allvehicle_tracking.jsp"><img src="../images/gemicon/image.png" alt="" /><span>All Vehicle Tracking</span></a></li>                        	
                            <li class="one_fifth"><a href=""><img src="../images/gemicon/calendar.png" alt="" /><span>Reports</span></a></li>
                            <li class="one_fifth"><a href=""><img src="../images/gemicon/users.png" alt="" /><span>Management</span></a></li>
                            
                        </ul>
                        
                        <br />
                        
                        <h4 class="widgettitle">Report Summary</h4>
                        <div class="widgetcontent">
                        	<div id="chartplace2" style="height:300px;"></div>
                        </div><!--widgetcontent-->
                        
                        <h4 class="widgettitle">Recent Articles</h4>
                        <div class="widgetcontent">
                            <div id="tabs">
                                <ul>
                                    <li><a href="#tabs-1"><span class="icon-forward"></span> Alert</a></li>
                                    <li><a href="#tabs-2"><span class="icon-eye-open"></span> Idle</a></li>
                                    <li><a href="#tabs-3"><span class="icon-leaf"></span> Running</a></li>
                                    <li><a href="#tabs-4"><span class="icon-leaf"></span> Not Traceable</a></li>
                                </ul>
                                <div id="tabs-1">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Submitted By</th>
                                                <th>Date Added</th>
                                                <th class="center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><a href=""><strong>Excepteur sint occaecat cupidatat non...</strong></a></td>
                                                <td><a href="">admin</a></td>
                                                <td>Jan 02, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus...</strong></a></td>
                                                <td><a href="">themepixels</a></td>
                                                <td>Jan 02, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus</strong></a></td>
                                                <td><a href="">johndoe</a></td>
                                                <td>Jan 01, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Quis autem vel eum iure reprehenderi...</strong></a></td>
                                                <td><a href="">amanda</a></td>
                                                <td>Jan 01, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Nemo enim ipsam voluptatem quia</strong></a></td>
                                                <td><a href="">mandylane</a></td>
                                                <td>Dec 31, 2012</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="tabs-2">
                                    <table class="table table-bordered">
                                        <thead>
                                        	<tr>
                                                <th>Vehicle Number</th>
                                                <th>Date/Time</th>
                                                <th>Engine Status</th>
                                                <th class="center">Idle Time</th>
                                            </tr>                                            
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><a href=""><strong>Nemo enim ipsam voluptatem quia</strong></a></td>
                                                <td>Jan 04, 2012</td>
                                                <td><a href="">mandylane</a></td>                                                
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Excepteur sint occaecat cupidatat non...</strong></a></td>
                                                <td>Jan 02, 2013</td>
                                                <td><a href="">admin</a></td>                                                
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus...</strong></a></td>
                                                <td>Jan 06, 2013</td>
                                                <td><a href="">themepixels</a></td>                                                
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus</strong></a></td>
                                                <td>Jan 10, 2013</td>
                                                <td><a href="">johndoe</a></td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Quis autem vel eum iure reprehenderi...</strong></a></td>
                                                <td>Jan 11, 2013</td>
                                                <td><a href="">amanda</a></td>                                                
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="tabs-3">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Submitted By</th>
                                                <th>Date Added</th>
                                                <th class="center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><a href=""><strong>Quis autem vel eum iure reprehenderi...</strong></a></td>
                                                <td><a href="">amanda</a></td>
                                                <td>Jan 03, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Nemo enim ipsam voluptatem quia</strong></a></td>
                                                <td><a href="">mandylane</a></td>
                                                <td>Dec 31, 2012</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Excepteur sint occaecat cupidatat non...</strong></a></td>
                                                <td><a href="">admin</a></td>
                                                <td>Jan 02, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus...</strong></a></td>
                                                <td><a href="">themepixels</a></td>
                                                <td>Jan 02, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus</strong></a></td>
                                                <td><a href="">johndoe</a></td>
                                                <td>Jan 01, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                        </tbody>
                                    </table> 
                                </div>
                                <div id="tabs-4">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Submitted By</th>
                                                <th>Date Added</th>
                                                <th class="center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><a href=""><strong>Quis autem vel eum iure reprehenderi...</strong></a></td>
                                                <td><a href="">amanda</a></td>
                                                <td>Jan 03, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Nemo enim ipsam voluptatem quia</strong></a></td>
                                                <td><a href="">mandylane</a></td>
                                                <td>Dec 31, 2012</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Excepteur sint occaecat cupidatat non...</strong></a></td>
                                                <td><a href="">admin</a></td>
                                                <td>Jan 02, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus...</strong></a></td>
                                                <td><a href="">themepixels</a></td>
                                                <td>Jan 02, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                            <tr>
                                                <td><a href=""><strong>Sed ut perspiciatis unde omnis iste natus</strong></a></td>
                                                <td><a href="">johndoe</a></td>
                                                <td>Jan 01, 2013</td>
                                                <td class="center"><a href="" class="btn"><span class="icon-edit"></span> Edit</a></td>
                                            </tr>
                                        </tbody>
                                    </table> 
                                </div>
                            </div><!--#tabs-->
                        </div><!--widgetcontent-->
                        
                        
                    </div><!--span8-->
                    <div class="span4">
                    	<h4 class="widgettitle nomargin">Some Simple Instructions</h4>
                        <div class="widgetcontent bordered">
                        	The Application is used for tracking transport and logistics. It helps by providing seamless data transfer and video feed for post operational analysis and reports and alerts helps in gaining real time visibility.
                        </div><!--widgetcontent-->
                        
                        <h4 class="widgettitle nomargin">Events this month</h4>
                        <div class="widgetcontent">
                        	<div id="calendar" class="widgetcalendar"></div>
                        </div><!--widgetcontent-->
                        
                        <h4 class="widgettitle">Site Impressions</h4>
                        <div class="widgetcontent">
                        	<div id="bargraph2" style="height:200px;"></div>
                        </div><!--widgetcontent-->
                        
                        <h4 class="widgettitle">Recently Added Articles</h4>
                        <div class="widgetcontent">
                        	<div id="accordion" class="accordion">
                                    <h3><a href="#">Mauris mauris ante, blandit et</a></h3>
                                    <div>
                                        <p>
                                        Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer
                                        ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit
                                        amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut
                                        odio. Curabitur malesuada. Vestibulum a velit eu ante scelerisque vulputate.
                                        </p>
                                    </div>
                                    <h3><a href="#">Donec et ante phasellus eu ligula</a></h3>
                                    <div>
                                        <p>
                                        Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
                                        purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
                                        velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
                                        suscipit faucibus urna.
                                        </p>
                                    </div>
                                    <h3><a href="#">Quam ante aliquam nisi</a></h3>
                                    <div>
                                        <p>
                                        Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis.
                                        Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero
                                        ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis
                                        lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui.
                                        </p>
                                        <ul class="margin1020">
                                            <li>List item one</li>
                                            <li>List item two</li>
                                            <li>List item three</li>
                                        </ul>
                                    </div>
                                    <h3><a href="#">Pellentesque habitant morbi</a></h3>
                                    <div>
                                        <p>
                                        Cras dictum. Pellentesque habitant morbi tristique senectus et netus
                                        et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in
                                        faucibus orci luctus et ultrices posuere cubilia Curae; Aenean lacinia
                                        mauris vel est.
                                        </p>
                                        <p>
                                        Suspendisse eu nisl. Nullam ut libero. Integer dignissim consequat lectus.
                                        Class aptent taciti sociosqu ad litora torquent per conubia nostra, per
                                        inceptos himenaeos.
                                        </p>
                        	       </div>
                        	</div><!--#accordion-->
                        </div><!--widgetcontent-->
                    </div><!--span4-->
                </div><!--row-fluid-->
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
<script type="text/javascript">
jQuery(document).ready(function(){
								
		// basic chart
		var flash = [[0, 2], [1, 6], [2,3], [3, 8], [4, 5], [5, 13], [6, 8]];
		var html5 = [[0, 5], [1, 4], [2,4], [3, 1], [4, 9], [5, 10], [6, 13]];
			
		function showTooltip(x, y, contents) {
			jQuery('<div id="tooltip" class="tooltipflot">' + contents + '</div>').css( {
				position: 'absolute',
				display: 'none',
				top: y + 5,
				left: x + 5
			}).appendTo("body").fadeIn(200);
		}
	
			
		var plot = jQuery.plot(jQuery("#chartplace2"),
			   [ { data: flash, label: "Flash(x)", color: "#fb6409"}, { data: html5, label: "HTML5(x)", color: "#096afb"} ], {
				   series: {
					   lines: { show: true, fill: true, fillColor: { colors: [ { opacity: 0.05 }, { opacity: 0.15 } ] } },
					   points: { show: true }
				   },
				   legend: { position: 'nw'},
				   grid: { hoverable: true, clickable: true, borderColor: '#ccc', borderWidth: 1, labelMargin: 10 },
				   yaxis: { min: 0, max: 15 }
				 });
		
		var previousPoint = null;
		jQuery("#chartplace2").bind("plothover", function (event, pos, item) {
			jQuery("#x").text(pos.x.toFixed(2));
			jQuery("#y").text(pos.y.toFixed(2));
			
			if(item) {
				if (previousPoint != item.dataIndex) {
					previousPoint = item.dataIndex;
						
					jQuery("#tooltip").remove();
					var x = item.datapoint[0].toFixed(2),
					y = item.datapoint[1].toFixed(2);
						
					showTooltip(item.pageX, item.pageY,
									item.series.label + " of " + x + " = " + y);
				}
			
			} else {
			   jQuery("#tooltip").remove();
			   previousPoint = null;            
			}
		
		});
		
		jQuery("#chartplace2").bind("plotclick", function (event, pos, item) {
			if (item) {
				jQuery("#clickdata").text("You clicked point " + item.dataIndex + " in " + item.series.label + ".");
				plot.highlight(item.series, item.datapoint);
			}
		});


		// bar graph
		var d2 = [];
		for (var i = 0; i <= 10; i += 1)
			d2.push([i, parseInt(Math.random() * 30)]);
			
		var stack = 0, bars = true, lines = false, steps = false;
		jQuery.plot(jQuery("#bargraph2"), [ d2 ], {
			series: {
				stack: stack,
				lines: { show: lines, fill: true, steps: steps },
				bars: { show: bars, barWidth: 0.6 }
			},
			grid: { hoverable: true, clickable: true, borderColor: '#bbb', borderWidth: 1, labelMargin: 10 },
			colors: ["#06c"]
		});
		
		// calendar
		jQuery('#calendar').datepicker();


});
</script>
</body>
</html>