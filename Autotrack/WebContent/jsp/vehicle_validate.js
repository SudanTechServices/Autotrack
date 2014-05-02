function vehicleFormValidator(){
	// Make quick references to our fields
	
	var customer_id=document.VehicleInfo.customer_id.value;
	
	var vehicle_number = document.VehicleInfo.vehicle_number.value;
	
	var customer_name=document.VehicleInfo.customer_name.value;
	
	var mobile_no = document.VehicleInfo.sim_no.value;
	
	var IMEI_no = document.VehicleInfo.IMEI_no.value;
	
	var camera_id = document.VehicleInfo.camera_id.value; //We didn't use this
	
	var vehicle_type = document.VehicleInfo.vehicle_type.value;
	
	var vehicle_mfg = document.VehicleInfo.vehicle_mfg.value;
	
	var fuel_capacity = document.VehicleInfo.fuel_tank_capacity.value;
	
	var max_speed = document.VehicleInfo.max_speed.value;
	
	var min_fuel_volt = document.VehicleInfo.empty_fuel_voltage.value;
	
	var max_fuel_volt = document.VehicleInfo.full_fuel_voltage.value;
	
	// Check each input in the order that it appears in the form!
	//Customer_ID

	if(isAlphanumeric(customer_id, "Please enter a Valid Customer ID ")){
	    if(lengthRestriction(customer_id, 2, 15,'Enter Valid Customer ID of 15 Numbers')){
	//Vehicle Number
	    	
			if(isAlphanumeric(vehicle_number, "Please enter a Correct Vehicle Registration number ")){
				    if(lengthRestriction(vehicle_number, 2, 15,'Enter Valid Vehicle Number of 10 Characters')){
				    	
	//Customer_Name
				    	
			if(isAlphanumeric(customer_name, "Please enter a Valid Customer Name ")){
				    if(lengthRestriction(customer_name, 2, 15,'Enter Valid Customer Name of 15 Numbers')){
	//Mobile Number
			if(isContactNumber(mobile_no, "Please enter a valid Mobile number")){
					if(lengthRestriction(mobile_no, 2, 13,'Enter Valid Mobile Number')){
	//IMEI Number		
			if(isNumeric(IMEI_no, "Please enter a valid IMEI number")){
					if(lengthRestriction(IMEI_no, 1, 16,'Enter Valid IMEI Number ')){
	
	//Camera Id					
			if(isAlphanumeric(camera_id, "Please enter a Valid Camera ID ")){
					if(lengthRestriction(camera_id, 4, 15,'Enter Valid Camera ID of 15 Numbers')){
						
	
	//Vehicle Type		
			if(isAlphanumeric(vehicle_type, "Please enter a valid Vehicle Type")){
				    if(lengthRestriction(vehicle_type, 2, 40,'Enter Within 10 characters')){  
	//Vehicle Manufacturer				
			if(isAlphanumeric(vehicle_mfg, "Please enter a valid Vehicle MFG")){
					if(lengthRestriction(vehicle_mfg, 2, 40,'Enter Within 10 characters')){  		
					
	//Fuel tank capacity
			if(isNumeric(fuel_capacity, "Please enter a Fuel tank capacity in litres (numbers)")){
					if(lengthRestriction(fuel_capacity,0, 4,'Enter within 4 digits')){
				
	//max speed
					if(isNumeric(max_speed, 'Please enter only letters for your max speed')){
						if(lengthRestriction(max_speed, 0, 3,'Please enter target within 3 character')){
							
							if(isNumeric(min_fuel_volt, 'Please enter only digits for your empty fuel volatage')){
								if(lengthRestriction(min_fuel_volt, 0, 4,'Please enter Empty fuel voltage within 4 digit')){

									if(isNumeric(max_fuel_volt, 'Please enter only digits for your full fuel volatage')){
										if(lengthRestriction(max_fuel_volt, 0, 4,'Please enter full fuel voltage within 4 digit')){
											
										
									return true;
									  }
							}}
						}}
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
}}}}}	}}
			
	
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

function lengthRestriction(elem, min, max,msg){
	//alert(elem);
	var uInput = elem;
	//alert(uInput);
	if(uInput.length >= min && uInput.length <= max){
		return true;
	}else{
		alert(msg);
		elem.focus();
		return false;
	}
}

function isNumeric(elem, helperMsg){
	var numericExpression = /^[0-9 .]/;
	if(elem.match(numericExpression)){
		return true;
	}else{
		alert(helperMsg);
		elem.focus();
		return false;
	}
}




