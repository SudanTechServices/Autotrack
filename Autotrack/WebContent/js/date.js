// JavaScript Document
$(document).ready(function() {
var param1 = new Date();
var param2 = param1.getDate() + '/' + (param1.getMonth()+1) + '/' + param1.getFullYear() + ' ' + param1.getHours() + ':' + param1.getMinutes() + ':' + param1.getSeconds();
$('#lbltxt').text(param2)
})