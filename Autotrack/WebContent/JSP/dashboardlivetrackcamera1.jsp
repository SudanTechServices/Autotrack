<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Camera1</title>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<% String IMEI=(String)session.getAttribute("IMEI");
					IMEI=IMEI.concat("-cam1");
					System.out.println("IMEI "+IMEI);
%>
<script type="text/javascript">
function showframe(){
	try
{	

	document.getElementById("frame").innerHTML = '<iframe src="http://182.72.167.37:8080/cmsgps/monitor/demo/<%=IMEI%>.html" type="application/x-shockwave-flash" allowfullscreen="false" allowScriptAccess="always" width="325" height="225" scrolling="auto" name="iframe"></iframe>';
}catch(Exception){
	alert('d');
}
}

</script>
</head>
<body>
<center>
<!-- <div class="content_bg"><span class="content_headning">Camera 1</span></div> -->
<!-- <div><a href="http://admin:123456@transnetworkx.i-dvr.net/m1.html"><img alt="../images/webcam.jpg" src="../images/webcam.jpg" height="100px" width="100px"></a></div> -->
<div id="frame" style="padding: 15px"><a href="#" onclick="showframe();"><img alt="../images/webcam.jpg" src="../images/webcam.jpg" height="100px" width="100px"></a></div>
<label>Camera1</label>
</center>
</body>
</html>