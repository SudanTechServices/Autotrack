<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<meta name="description" content="Simple Multi-Item Slider: Category slider with CSS animations" />
		<meta name="keywords" content="jquery plugin, item slider, categories, apple slider, css animation" />
		<meta name="author" content="Codrops" />
		<link rel="shortcut icon" href="../favicon.ico"> 
		<link rel="stylesheet" type="text/css" href="../CSS/stylebanner.css" />
		<script src="../JS/modernizr.custom.63321.js"></script>
	</head>
	<body >
		<div class="container">	
		
			<div class="main">
				<div id="mi-slider" class="mi-slider">
					<ul>
						<li><a href="VehicleSummary.jsp"><img src="../images/summary.jpg" alt="img01"><h4>Summary</h4></a></li>
					</ul>
					<ul>
						<li><a href="../HTML/frame_dashboard.htm"><img src="../images/dashboard.jpg" alt="img05"><h4>Dashboard</h4></a></li>
					</ul>
					<ul>
						<li><a href="QuickView.jsp"><img src="../images/quickview.jpg" alt="img09"><h4>Quick View</h4></a></li>
										</ul>
					<ul>
						<li><a href="../HTML/frame_livetracking.htm"><img src="../images/livetracking.jpg" alt="img12"><h4>Live Tracking</h4></a></li>
					</ul>
                    <ul>
						<li><a href="allvehicletracking.jsp"><img src="../images/allveclivetracking.jpg" alt="img12"><h4>All Vehicle Live Tracking</h4></a></li>
					</ul>
                    <ul>
						<li><a href="../HTML/frame_reports.htm"><img src="../images/generalreport.jpg" alt="img12"><h4>General Reports</h4></a></li>
						<li><a href="./Report/UDR_Select.jsp"><img src="../images/userdefined.jpg" alt="img13"><h4>User Defined</h4></a></li>
					</ul>
					<ul>
						<li><a href="MGMT_userregistration.jsp"><img src="../images/useraccount.jpg" alt="img12"><h4>User Account</h4></a></li>
						<li><a href="MGMT_driverinformation.jsp"><img src="../images/driverinfo.jpg" alt="img13"><h4>Driver Information</h4></a></li>
						<li><a href="MGMT_customerinfo.jsp"><img src="../images/customerinfo.jpg" alt="img12"><h4>Customer Information</h4></a></li>
						<li><a href="MGMT_vehiclereg.jsp"><img src="../images/vehicleinfo.jpg" alt="img13"><h4>Vehicle Information</h4></a></li>
					</ul>
                  
					<nav>
						<a href="#">Summary</a>
						<a href="#">Dashboard</a>
						<a href="#">Quick View</a>
						<a href="#">Live Tracking</a>
                        <a href="#">All Vehicle Live Tracking</a>
                        <a href="#">Reports</a>
                        <a href="#">Management</a>
					</nav>
				</div>
			</div>
		</div>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
		<script src="../JS/jquery.catslider.js"></script>
		<script>
			$(function() {

				$( '#mi-slider' ).catslider();

			});
		</script>
	</body>
</html>