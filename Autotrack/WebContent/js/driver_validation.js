function Drivervalidate(){
	
		// Make quick references to our fields
		
		var driver_name = document.DriverInfo.fullname.value;
		
		//var gender = document.DriverInfo.gender.value;
		var contact_no = document.DriverInfo.contact.value;
		var address = document.DriverInfo.address.value;
		var date_of_birth = document.DriverInfo.date.value;
		var date_of_joining = document.DriverInfo.dateofjoin.value;
		var license_number = document.DriverInfo.licensenumber.value;
		var date_of_issue = document.DriverInfo.dateofissue.value;
		var date_of_expiry = document.DriverInfo.dateofexp.value;
	
		var vehicle_number = document.DriverInfo.vehicleno.value;
		
		var shift_number = document.DriverInfo.shift.value;
		
		var route_number = document.DriverInfo.routenumber.value;
	
	
		
		// Check each input in the order that it appears in the form!
		
		if(notEmpty(driver_name, " Please Enter The Name")){
			if(isAlphanumeric(driver_name, 'Please Enter Valid name')){
				if(lengthRestriction(driver_name, 2, 31,'Name Should not be more than 30 characters')){
					
					if(!document.getElementById("male").checked && !document.getElementById("female").checked)
					{alert("Please select the Gender"); return false;}
					
					
					
					
					
					if(notEmpty(contact_no, "Please Enter The Contact Number")){
							if(isContactNumber(contact_no, 'Please Enter Valid Contact Number')){
								if(lengthRestriction(contact_no, 2, 16,'Last Name Should not be more than 15 characters')){
					
									
									if(notEmpty(address, "Please Enter The Address")){
										if(isAlphanumeric(address, 'Please Enter Valid Address')){
											if(lengthRestriction(address, 2, 250,'Address Should not be more than 250 characters')){
												
												if(notEmpty(date_of_birth, "Please Enter The Date Of Birth")){		
													// if(isnum( date_of_birth,"Please enter valid Date Of Birth")){
												      if(lengthRestriction(date_of_birth, 2, 16,'Date of Birth Should be in given format')){
													
												    	  if(notEmpty(date_of_joining, " Please Enter The Date Of Joining")){
												    		 // if(isnum( date_of_joining,"Please enter valid Date Of Joining")){
														        if(lengthRestriction(date_of_joining, 2, 16,'Date of Joining Should be in given format')){
															
															
																	
															            if(notEmpty(license_number, " Please Enter The License Number")){
																			if(isAlphanumeric(license_number, 'Please Enter Valid Licence Number')){
																				if(lengthRestriction(license_number, 2, 31,'Licence Should not be more than 30 characters')){
																					
																					if(notEmpty(date_of_issue, " Please Enter The Date of Issue")){
																						// if(isnum( date_of_issue,"Please enter valid Date of Issue")){
																						    if(lengthRestriction(date_of_issue, 2, 16,'Date of Issue Should be in given format')){
																							
																						    	if(notEmpty(date_of_expiry, " Please Enter The Date_of_expiry")){
																						    		 //if(isnum( date_of_expiry,"Please enter valid Date_of_expiry")){
																								      if(lengthRestriction(date_of_expiry, 2, 16,'Date of Expiry Should be in given format')){
																									// if(compare(date_of_issue,date_of_expiry)){	
																										
																										 
																										 
																										/* if(notEmpty(vehicle_number, " Please Enter The Vehicle Number")){ 
																										     if(lengthRestriction(vehicle_number, 2, 16,'Vehicle Number should not be more than 15 characters')){
																											    
																										    	 if(notEmpty(shift_number, " Please Enter The Shift Number")){ 
																										           if(lengthRestriction(shift_number, 2, 16,'Shift Number should not be more than 10 characters')){
																												*/
																								    	  if( document.DriverInfo.vehicleno.value == "Select" )
																										   {
																										     alert( "Please Enter The Vehicle Number" );
																										     document.DriverInfo.vehicleno.focus();
																										     return false;
																										   }
																										 
																								    	  if( document.DriverInfo.shift.value == "Select" )
																										   {
																										     alert( "Please Enter The Shift Number!" );
																										     document.DriverInfo.shift.focus();
																										     return false;
																										   }
																										 
																											 
																											
																											if(notEmpty(route_number, " Please Enter The Route Number")){
																													
																												 if(isnum( route_number,"Please enter valid Route Number")){
																														if(lengthRestriction(route_number, 2, 16,'Route Number Should not be more than 15 characters')){	
																													return true;
																														}
																												 }
																											}
																								      }
																						    		 }
																						    	}
																						    }
																						 }
																					}
																				}
																			}
															            }
														        }
												    		  }
												    	  }
												      }
													 }
												}
											}
										}
									}
								}
							}
				
return false;
}
								

function notEmpty(elem, helperMsg){
	if(elem.length == 0){
	alert(helperMsg);	
	elem.focus(); // set the focus to this input
	return false;
	}

	return true;
	}


function lengthRestriction(elem, min, max,msg){
	var uInput = elem;
	if(uInput.length >= min && uInput.length <= max){
	return true;
	}else{
	alert(msg);
	elem.focus();
	return false;
	}
	}
   

function isnum(elem, helperMsg)
{
var  amount = /^[0-9]+$/;
if(elem.match(amount)){
return true;
}else{
alert(helperMsg);
elem.focus();
return false;
}
}			
						
								
function isAlphabet(elem, helperMsg){
	
	var alphaExp = /^[a-z A-Z]+$/;
	if(elem.match(alphaExp)){
		
		return true;
	}else{
		alert(helperMsg);
		elem.focus();
		return false;
	}
}	

function isAlphanumeric(elem, helperMsg){
	var alphaExp = /^[0-9 a-zA-Z .]/;
	if(elem.match(alphaExp)){
		return true;
	}else{
		alert(helperMsg);
		elem.focus();
		return false;
	}
}
function isContactNumber(elem, helperMsg){
	var numeric = /^(()?\d{3}())?(-|\s)?\d{3}(-|\s)?\d{4}$/;
	if(elem.match(numeric)){
		return true;
	}else{
		alert(helperMsg);
		elem.focus();
		return false;
	}
}