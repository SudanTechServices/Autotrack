	
	
	function customerFormValidator(){
		
		// Make quick references to our fields
		var customer_id=document.CustomerInfo.customer_id.value;
		
		var customer_name = document.CustomerInfo.customer_name.value;
		
		var customer_address = document.CustomerInfo.customer_address.value;
		
		var contact_number = document.CustomerInfo.contact_number.value;
		
		var contact_person = document.CustomerInfo.contact_person.value;
		//alert("Inside Validation");
		//var contract_Start_date = document.CustomerInfo.contract_Start_date.value;
		//var contract_end_date = document.CustomerInfo.contract_End_date.value;
		var no_of_licence=document.CustomerInfo.number_of_licence.value;
		
		
		
		// Check each input in the order that it appears in the form!
		if(isAlphanumeric(customer_id, 'Please enter only letters for your ID')){
			if(lengthRestriction(customer_id, 2, 40,'ID Should be more than 2 characters')){
		if(isAlphanumeric(customer_name, 'Please enter only letters for your name')){
			if(lengthRestriction(customer_name, 2, 40,'Username Should be more than 2 characters')){
				
			if(isAlphanumeric(customer_address, "Only  Numbers and Letters for Address")){
				if(lengthRestriction(customer_address, 2, 200,'Too many characters')){
					
				if(isContactNumber(contact_number, "Please enter a valid contact number")){
					if(lengthRestriction(contact_number, 2, 15,'Enter Valid Contact Number')){
							
				if(isAlphabet(contact_person, 'Please enter only alphabets for your contact person')){
				   if(lengthRestriction(contact_person, 2, 40,'Too many characters')){
								
				      /* if(isDate(contract_Start_date)){
				    	   if(lengthRestriction(contract_Start_date, 8, 10,'Please enter a valid Date Format')){
				    		   
				    	   if(isDate(contract_end_date)){
				    		     if(lengthRestriction(contract_end_date, 8, 10,'Please enter a valid Date Format')){
				    		    	 
	*/			    		    	/* if(compare(contract_Start_date,contract_end_date)){*/
				    		    		 if(isAlphanumeric(no_of_licence, "Please enter number of licence")){
				    		    				if(lengthRestriction(no_of_licence, 1, 6,'Number of licence should be less than 6')){   
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
	/*}}}	}}*/
		
	return false;
		
	}
	
	
	
	
	function registerFormValidator(){
		// Make quick references to our fields	
		var company = document.stdform.company.value;		
		var number = document.stdform.number.value;
		var email = document.stdform.email.value;
		var user_name = document.stdform.usrname.value;		
		var password = document.stdform.password.value;		
		
		
		
		
		
		// Check each input in the order that it appears in the form!
		if(isAlphabet(company, 'Please enter only letters for your company name'))
		{				
			
		    if(lengthRestriction(company, 1, 100,'Too many characters for company name'))
		    {
		    		
		if(isContactNumber(number, "Please enter a valid contact number"))
			
			{
				if(lengthRestriction(number, 6, 15,'Enter Valid Contact Number'))
				{
					
					if(emailValidator(email,'Please enter a valid email id'))
						{						
					    	
							if(isAlphabet(user_name, 'Please enter only letters for your name'))
								{
									if(lengthRestriction(user_name, 1, 20,'Too many characters'))
									{
										
										if(isAlphanumeric(password, "Only  Numbers and Letters for Address"))
										{
											if(lengthRestriction(password, 3, 10,'Password should be Min 3 and Max 10'))
												{	    									   
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
		
	return false;
		
	}
	
	function ShiftInfoValidator(){
		// Make quick references to our fields
		
		var shift_id = document.ShiftInfo.shift_id.value;
		
		
		// Check each input in the order that it appears in the form!
		if(notEmpty(shift_id, "Enter Shift Id")){
			if(isAlphanumeric(shift_id, 'Please Enter Valid Shift ID')){
				if(lengthRestriction(shift_id, 2, 10,'Shift Id Should not be more than 10 characters')){
					return true;
				}
			}
		}
		
	return false;
	
	}
	
	function RouteInfoValidator(){
		// Make quick references to our fields
		
		var route_no = document.RouteInfo.route_no.value;
		var source = document.RouteInfo.source.value;
		var destination = document.RouteInfo.destination.value;
		var vehicle_no = document.RouteInfo.vehicle_no.value;
		
		
		
		// Check each input in the order that it appears in the form!
		if(notEmpty(route_no, "Enter Route Number")){
			if(isAlphanumeric(route_no, 'Please Enter Valid Route Number')){
				if(lengthRestriction(route_no, 2, 5,'Route Number Should not be more than 5 characters')){
					if(notEmpty(source, "Enter Source Address")){
						if(isAlphanumeric(source, 'Please Enter Valid Source Address')){
							if(lengthRestriction(source, 2, 15,'Source Address Should not be more than 15 characters')){
								if(notEmpty(destination, "Enter destination Address")){
									if(isAlphanumeric(destination, 'Please Enter Valid destination Address')){
										if(lengthRestriction(destination, 2, 15,'destination Address Should not be more than 15 characters')){
											if(lengthRestriction(vehicle_no, 2, 15,'Enter Valid Vehicle Number')){
												
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
	return false;
	
	}
	
	function DriverInfoValidator(){
		
		// Make quick references to our fields
		
		var driver_name = document.DriverInfo.driver_name.value;
		var gender = document.DriverInfo.gender.value;
		var contact_no = document.DriverInfo.contact_no.value;
		var address = document.DriverInfo.address.value;
		var date_of_birth = document.DriverInfo.date_of_birth.value;
		var date_of_joining = document.DriverInfo.date_of_joining.value;
		var license_number = document.DriverInfo.license_number.value;
		var date_of_issue = document.DriverInfo.date_of_issue.value;
		var date_of_expiry = document.DriverInfo.date_of_expiry.value;
	
		var vehicle_number = document.DriverInfo.vehicle_number.value;
		
		var shift_number = document.DriverInfo.shift_number.value;
		
		var route_number = document.DriverInfo.Route_number.value;
	
	
		
		// Check each input in the order that it appears in the form!
		
		if(notEmpty(driver_name, "Enter Name")){
			if(isAlphanumeric(driver_name, 'Please Enter Valid name')){
				if(lengthRestriction(driver_name, 2, 31,'Name Should not be more than 10 characters')){
					
						
								
									if(isContactNumber(contact_no, 'Please Enter Valid Contact Number')){
										if(lengthRestriction(contact_no, 2, 16,'Last Name Should not be more than 10 characters')){
											
											if(isAlphanumeric(address, 'Please Enter Valid Address')){
												if(lengthRestriction(address, 2, 251,'Address Should not be more than 50 characters')){
													
											if(isDate(date_of_birth)){
												if(lengthRestriction(date_of_birth, 2, 16,'Date of Birth Should be in given format')){
													
													if(isDate(date_of_joining)){
														if(lengthRestriction(date_of_joining, 2, 16,'Date of Birth Should be in given format')){
															
															
																	
																			
																			if(isAlphanumeric(license_number, 'Please Enter Valid Licence Number')){
																				if(lengthRestriction(license_number, 2, 31,'Licence Should not be more than 20 characters')){
																					
																					if(isDate(date_of_issue)){
																						if(lengthRestriction(date_of_issue, 2, 16,'Date of Issue Should be in given format')){
																							
																							if(isDate(date_of_expiry)){
																								if(lengthRestriction(date_of_expiry, 2, 16,'Date of Expiry Should be in given format')){
																									 if(compare(date_of_issue,date_of_expiry)){	
																										 
																										 if(lengthRestriction(vehicle_number, 2, 16,'Vehicle Number should not be more than 15 characters')){
																											 
																										if(lengthRestriction(shift_number, 2, 16,'Shift Number should not be more than 10 characters')){
																												
																											
																												
																													
																													if(isAlphanumeric(route_number, 'Please Enter Route Number')){
																														if(lengthRestriction(route_number, 2, 16,'Route Number Should not be more than 15 characters')){	
																													return true;
				}
			}
		
																									
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
												}
											}
										}
									}}}	
	return false;
	
	}
	
	
	
	function TcssInfoValidator(){
		
		// Make quick references to our fields
		
		var tcss_id_number = document.TcssInfo.tcss_id_number.value;
		
		var name = document.TcssInfo.tcss_name.value;
			
		var contact_no = document.TcssInfo.contact_no.value;
		
		var address = document.TcssInfo.address.value;
		var year_of_exp = document.TcssInfo.experience.value;
	    var vehicle_number = document.TcssInfo.vehicle_number.value;
		var route_number = document.TcssInfo.Route_number.value;
	
	
		
		// Check each input in the order that it appears in the form!
		
		if(notEmpty(tcss_id_number, "Enter the Id Number")){
			if(lengthRestriction(tcss_id_number, 1, 15,'ID Number Should not be more than 15 characters')){
			if(isAlphanumeric(name, 'Please Enter Valid name')){
				if(lengthRestriction(name, 1, 30,'Name Should not be more than 30 characters')){
										
								
									if(isContactNumber(contact_no, 'Please Enter Valid Contact Number')){
										if(lengthRestriction(contact_no, 1, 15,'Last Name Should not be more than 15 characters')){
											
											if(isAlphanumeric(address, 'Please Enter Valid Address')){
												if(lengthRestriction(address, 2, 250,'Address Should not be more than 250 characters')){
													
											/*if(isDate(date_of_birth)){
												if(lengthRestriction(date_of_birth, 2, 15,'Date of Birth Should be in given format')){*/
													
													/*if(notEmpty(date_of_joining,"Enter Date Of Joining")){
														if(lengthRestriction(date_of_joining, 2, 15,'Date of Joining Should be in given format')){*/
														
																			
												                         if(isAlphanumeric(year_of_exp, 'Please Enter Valid Years of Experience')){
																				if(lengthRestriction(year_of_exp, 2, 10,'Experience Should not be more than 10 characters')){
																				
																				if(lengthRestriction(vehicle_number, 2, 15,'Enter The Vehicle Number')){
																											
																					if(isAlphanumeric(route_number, 'Please Enter Route Number')){
																														if(lengthRestriction(route_number, 2, 15,'Route Number Should not be more than 15 characters')){	
																													return true;
				}
			}
		
																									
																									/*}}*/
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function StudentregistrationFormValidator()
	{    
		
		var enrolment_number = document.StudentInfo.enrolment_number.value;
		
		var name = document.StudentInfo.name.value;
		
		//var gender = document.StudentInfo.gender.value;
		var standard = document.StudentInfo.standard.value;
		
		var section = document.StudentInfo.section.value;
		
		//var dob= document.StudentInfo.dob.value;
		
		var address = document.StudentInfo.address.value;
	
		var routenumber = document.StudentInfo.routenumber.value;
		
		var location = document.StudentInfo.location.value;
		
		var pick_point = document.StudentInfo.pick_point.value;
		
		var pickuptiming = document.StudentInfo.pickuptiming.value;
		
		var category= document.StudentInfo.category.value;
		
		var parentname = document.StudentInfo.parentname.value;
		
		var occupation = document.StudentInfo.occupation.value;
		var designation = document.StudentInfo.designation.value;
		var office_address = document.StudentInfo.office_address.value;
		var contact_number = document.StudentInfo.contact_number.value;
		var email = document.StudentInfo.email.value;
		var mother_name = document.StudentInfo.mother_name.value;
		var mother_occupation = document.StudentInfo.mother_occupation.value;
		var mother_designation = document.StudentInfo.mother_designation.value;
		var mother_office_address = document.StudentInfo.mother_office_address.value;
		var mother_contact_number = document.StudentInfo.mother_contact_number.value;
		var mother_email = document.StudentInfo.mother_email.value;
		var residential_number = document.StudentInfo.residential_number.value;
		
		
		
		if(notEmpty(name, "Enter Student Name")){
		if(isAlphanumeric(name, 'Please Enter Valid Name')){
			if(lengthRestriction(name,0, 61,'Name Should not be more than 10 characters')){
		
				if(isAlphanumeric(address, 'Please Enter the Address')){
					if(lengthRestriction(address,0, 251,'Address Should not be more than 5 characters')){
			
			if(isAlphanumeric(enrolment_number, 'Please Enter Valid Enrollment Number')){
				if(lengthRestriction(enrolment_number, 2, 11,'Enrollment Number Should not be more than 10 characters')){
					
						
								
							
								if(isAlphanumeric(standard, 'Please Enter The Class')){
									if(lengthRestriction(standard,0, 7,'Class Should not be more than 15 characters')){
										
										if(isAlphanumeric(section, 'Please Enter The Section')){
											if(lengthRestriction(section,0, 4,'Section Should not be more than 15 characters')){
											
										
										/*	if(isDate(dob)){
												if(lengthRestriction(dob, 2, 11,'Date of Birth Should be in given format')){*/
													
												if(isAlphanumeric(pick_point, 'Please Enter Valid Pick Point')){
													if(lengthRestriction(pick_point,0, 101,'Pick Point Should not be more than 15 characters')){
														
														if(isAlphanumeric(pickuptiming, 'Please Enter the Pickup Timing')){
															if(lengthRestriction(pickuptiming,0, 11,'Pickup Timing Should not be more than 15 characters')){
															
															if(isAlphanumeric(routenumber, 'Please Enter Valid Route Number')){
																if(lengthRestriction(routenumber,0, 11,'Route Number Should not be more than 3 characters')){
																	
																	if(isAlphanumeric(location, 'Please Enter Valid Location')){
																		if(lengthRestriction(location,0, 101,'Location Should not be more than 15 characters')){
																			
															                       if(isAlphanumeric(category, 'Please Enter Valid Category')){
																					  if(lengthRestriction(category,0, 5,'Category Should not be more than 15 characters')){
																						  
																						  if(isContactNumber(residential_number, 'Please Enter the Residential Number')){
																								if(lengthRestriction(residential_number,0, 31,'Residential Number Should not be more than 15 characters')){
																						  
																									
																									if(isAlphanumeric(parentname, 'Please Enter Parent Name')){
																										if(lengthRestriction(parentname,0, 61,'Parent Name Should not be more than 15 characters')){
																											
																											if(isAlphanumeric(occupation, 'Please Enter the Occupation')){
																												if(lengthRestriction(occupation,0, 51,'Occupation Should not be more than 15 characters')){
																													
																													if(isAlphanumeric(designation, 'Please Enter the designation')){
																														if(lengthRestriction(designation,0, 51,'Designation Should not be more than 15 characters')){
																															
																															if(isAlphanumeric(office_address, 'Please Enter the Office Address')){
																																if(lengthRestriction(office_address,0, 251,'Office Address Should not be more than 15 characters')){
																																	
																																	if(isContactNumber(contact_number, 'Please Enter the Contact Number')){
																																		if(lengthRestriction(contact_number,0, 31,'Contact Number Should not be more than 15 characters')){
																																			
																																			if(emailValidator(email, 'Please Enter Valid Email ID')){
																																				if(lengthRestriction(email,0, 51,'Email ID Should not be more than 15 characters')){
																																					
																																					if(isAlphanumeric(mother_name, 'Please Enter the Mother Name')){
																																						if(lengthRestriction(mother_name,0, 61,'Mother Name Should not be more than 15 characters')){
																																							
																																							if(isAlphanumeric(mother_occupation, 'Please Enter the Occupation')){
																																								if(lengthRestriction(mother_occupation,0, 51,'Occupation Should not be more than 15 characters')){
																																									
																																									if(isAlphanumeric(mother_designation, 'Please Enter the Designation')){
																																										if(lengthRestriction(mother_designation,0, 61,'Designation Should not be more than 15 characters')){
																																											
																																											if(isAlphanumeric(mother_office_address, 'Please Enter the Office Address')){
																																												if(lengthRestriction(mother_office_address,0, 251,'Office Address Should not be more than 15 characters')){
																																													
																																													if(isContactNumber(mother_contact_number, 'Please Enter Valid Conatct Number')){
																																														if(lengthRestriction(mother_contact_number,0, 31,'Contact Number Should not be more than 15 characters')){
																																															
																																															if(isAlphanumeric(mother_email, 'Please Enter Valid Email ID')){
																																																if(emailValidator(mother_email,0, 51,'Email ID Should not be more than 15 characters')){
																																																	
																																																	
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
																									return true ;
																								}
																	}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
		return false;
	}
	
	function routeregistrationvalidation()
	{    
		var route_number = document.BusRouteInfo.route_number.value;		
		var Source= document.BusRouteInfo.source.value;
		var Destination = document.BusRouteInfo.destination.value;
		var Pickup_Point_1 = document.BusRouteInfo.limit1.value;
		var Rate_1 = document.BusRouteInfo.rate1.value;
		var Pickup_Point_2 = document.BusRouteInfo.limit2.value;
		var Rate_2 = document.BusRouteInfo.rate2.value;
		var Pickup_Point_3 = document.BusRouteInfo.limit3.value;
		var Rate_3= document.BusRouteInfo.rate3.value;
		var Pickup_Point_4 = document.BusRouteInfo.limit4.value;
		var Rate_4 = document.BusRouteInfo.rate4.value;
		var Pickup_Point_5 = document.BusRouteInfo.limit5.value;
		var Rate_5 = document.BusRouteInfo.rate5.value;
		
		if(notEmpty(route_number, "Enter Route Number")){
			if(isAlphanumeric(route_number, 'Please Enter Valid Route Number')){
				if(lengthRestriction(route_number, 2, 15,'Route Number Should not be more than 10 characters')){
					
						if(isAlphanumeric(Source, 'Please Enter Valid Source')){
							if(lengthRestriction(Source,0, 10,'Source Should not be more than 10 characters')){
								
							
								if(isAlphanumeric(Destination, 'Please Enter Valid Destination')){
									if(lengthRestriction(Destination,0, 15,'Destination Should not be more than 15 characters')){
										
										/*if(isNumeric(age, 'Please Enter Valid age')){*/
											
										
											if(isAlphanumeric(Pickup_Point_1, 'Please Enter Pickup Point1')){
												if(lengthRestriction(Pickup_Point_1, 2, 15,'Pickup point Should not be more than 15 characters')){
													
													if(isNumeric(Rate_1, 'Please Enter the rate1 in numbers')){
														if(lengthRestriction(Rate_1,0, 5,'rate Should not be more than 5 characters')){
															
															if(isAlphanumeric(Pickup_Point_2, 'Please Enter Pickup Point2')){
																if(lengthRestriction(Pickup_Point_2,0, 15,'Pickup point Should not be more than 15 characters')){
																	
																	if(isNumeric(Rate_2, 'Please Enter the Rate2 in numbers')){
																		if(lengthRestriction(Rate_2,0, 5,'Rate Should not be more than 5 characters')){
																			
																			if(isAlphanumeric(Pickup_Point_3, 'Please Enter Pickup Point3')){
																				if(lengthRestriction(Pickup_Point_3,0, 15,'Pickup point Should not be more than 15 characters')){
																					
																					if(isNumeric(Rate_3, 'Please Enter the Rate3 in numbers')){
																						if(lengthRestriction(Rate_3,0, 5,'Rate Should not be more than 5 characters')){
																							
																							if(isAlphanumeric(Pickup_Point_4, 'Please Enter Pickup Point4')){
																								if(lengthRestriction(Pickup_Point_4,0, 15,'Pickup point Should not be more than 15 characters')){
																									
																									if(isNumeric(Rate_4, 'Please Enter the Rate4 in numbers')){
																										if(lengthRestriction(Rate_4,0, 5,'Rate Should not be more than 5 characters')){
																											
																											if(isAlphanumeric(Pickup_Point_5, 'Please Enter Pickup Point5')){
																												if(lengthRestriction(Pickup_Point_5,0, 15,'Pickup point Should not be more than 15 characters')){
																										
																											if(isNumeric(Rate_5, 'Please Enter the Rate5 in numbers')){
																												if(lengthRestriction(Rate_5,0, 5,'Rate Should not be more than 5 characters')){
																										
																				                                      return true ;
		}
		}}}}}}}}}}}}}}}}}}}}}}}}}}
		return false;
		
		
		}
	
	function newuservalidation()
	{
	  var from=document.mailinfo.to.value;
	  var contact_number=document.mailinfo.cnum.value;
	  if(emailValidator(from,'Enter Valid Mail ID')){
	    if(isContactNumber(contact_number,'Enter Valid Contact Number')){
	    	return true;
	    }
	  }
	  return false;
	
	}
	
	function forgotpasswordvalidation()
	{
	  var user=document.forgotpassword.username.value;
	  var emailid=document.forgotpassword.emailid.value;
	  if(isAlphanumeric(user,'Enter Valid User ID')){
	    if(emailValidator(emailid,'Enter Valid Mail ID')){
	        return true;
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
	
	function lengthRestriction(elem, min, max,msg){
		//alert(elem);
		var uInput = elem;
		//alert(uInput);
		if(uInput.length >= min && uInput.length <= max){
			return true;
		}
		else{
			alert(msg);
			elem.focus();
			return false;
		}
	}
	
	function madeSelection(elem, helperMsg){
		if(elem.value == "Please Choose"){
			alert(helperMsg);
			//elem.focus();
			return false;
		}else{
			return true;
		}
	}
	
	function emailValidator(elem, helperMsg){
		var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
		if(elem.match(emailExp)){
			return true;
		}else{
			alert(helperMsg);
			elem.focus();
			return false;
		}
	}
	
	function isDateFormat(elem, helperMsg){
		var alphaExp = /^[0-9 // ]/;
		if(elem.match(alphaExp)){
			return true;
		}else{
			alert(helperMsg);
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
	
	
	var dtCh= "/";
	var minYear=1900;
	var maxYear=2100;
	function isInteger(s){
		var i;
	    for (i = 0; i < s.length; i++){   
	        // Check that current character is number.
	        var c = s.charAt(i);
	        if (((c < "0") || (c > "9"))) return false;
	    }
	    // All characters are numbers.
	    return true;
	}
	
	function stripCharsInBag(s, bag){
		var i;
	    var returnString = "";
	    // Search through string's characters one by one.
	    // If character is not in bag, append to returnString.
	    for (i = 0; i < s.length; i++){   
	        var c = s.charAt(i);
	        if (bag.indexOf(c) == -1) returnString += c;
	    }
	    return returnString;
	}
	
	function daysInFebruary (year){
		// February has 29 days in any year evenly divisible by four,
	    // EXCEPT for centurial years which are not also divisible by 400.
	    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
	}
	function DaysArray(n) {
		for (var i = 1; i <= n; i++) {
			this[i] = 31;
			if (i==4 || i==6 || i==9 || i==11)
			{
				this[i] = 30;
				}
			if (i==2)
			{
				this[i] = 29;
				}
	   } 
	   return this;
	}
	
	function isDate(dtStr){
		var daysInMonth = DaysArray(12);
		var pos1=dtStr.indexOf(dtCh);
		var pos2=dtStr.indexOf(dtCh,pos1+1);
		var strMonth=dtStr.substring(0,pos1);
		var strDay=dtStr.substring(pos1+1,pos2);
		var strYear=dtStr.substring(pos2+1);
		strYr=strYear;
		if (strDay.charAt(0)=="0" && strDay.length>1)
			strDay=strDay.substring(1);
		if (strMonth.charAt(0)=="0" && strMonth.length>1) 
			strMonth=strMonth.substring(1);
		for (var i = 1; i <= 3; i++) {
			if (strYr.charAt(0)=="0" && strYr.length>1) 
				strYr=strYr.substring(1);
		}
		month=parseInt(strMonth);
		day=parseInt(strDay);
		year=parseInt(strYr);
		if (pos1==-1 || pos2==-1){
			alert("Enter The  Date ");
			return false;
		}
		if (strMonth.length<1 || month<1 || month>12){
			alert("Please enter a valid month");
			return false;
		}
		if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
			alert("Please enter a valid day");
			return false;
		}
		if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
			alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear);
			return false;
		}
		if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
			alert("Please enter a valid date");
			return false;
		}
	return true;
	}
	
	function compare(start,end)
	{
		
	    var string_start    =   start.split("/");
	    var date_start      =   string_start[0];
	    var month_start     =   string_start[1];
	    var year_start      =   string_start[2];
	    var curdate         =   new Date(year_start, month_start, date_start);
	
	
	    var end_start       =   end.split("/");
	    var date_end        =   end_start[0];
	    var month_end       =   end_start[1];
	    var year_end        =   end_start[2];
	    var enddate         =   new Date(year_end, month_end, date_end);
	
	    if(enddate<curdate) {
	    	alert(" Start Date Should not be greater than End Date ");
	        return false;
	    } else {
	    	
	        return true;
	    }
	}
	
	function notnull(){
		var start= document.speedreport.start_date.value;
		var end =document.speedreport.end_date.value;
		if(start.length!=0 && end.length!=0 ){
			
			return true;
		}
		else{
			alert("Please Enter Start and End date");
			return false;
		}
	}
	
	function reportVaildaion(){	
		var start= document.speedreport.start_date.value;
		var end =document.speedreport.end_date.value;
		var halt = document.speedreport.halt_timing.value;	
		if(start.length==0 && end.length==0 ){
			alert("Please Enter the Start and End date");
			return false;
		}
		if(halt.length==0 ){
			alert("Please Enter the Halt time");
			return false;
		}
		else{
			
			return  true;
		}
	}
	
	function UDR_validation(){	
		var date= document.consolidate_report.cons_date.value;
		var time= document.consolidate_report.inputHaltTime.value;		
		if(date.length == 0 ){
			alert("Please Enter The Date");
			return false;
		}
		else if(time.length == 0){
			alert("Please Enter The Halt Time");
			return false;
		}
		else{
			return true;
		}
	}
	
	
	function round_Trip_validation(){	
		var date= document.Round_trip_report.round_trip_date.value;
		var time= document.Round_trip_report.halt_time.value;		
		if(date.length == 0 ){
			alert("Please Enter The Date");
			return false;
		}
		else if(time.length == 0){
			alert("Please Enter The Halt Time");
			return false;
		}
		else{
			return true;
		}
	}
	
	
	function sbltValidation(){	
		var date= document.Sblt_trip_sheet.sblt_trip_date.value;
		var vehicleNo= document.Sblt_trip_sheet.vehicle_number.value;		
		if(date.length == 0 ){
			alert("Please select The Date");
			return false;
		}
		else if(vehicleNo.length == 0){
			alert("Please select vehicle Number");
			return false;
		}
		else{
			return true;
		}
	}
	
	function tripSheet(){
		
		var dateTime = document.transTripSheet.date_time.value;	
		var client = document.transTripSheet.client.value;
		var boarding = document.transTripSheet.boarding.value;
		var orderBy =document.transTripSheet.order.value;
		var driver =document.transTripSheet.driverName.value;
		var openingKm =document.transTripSheet.openingKm.value;
		var closingKm =document.transTripSheet.ClosingKm.value;		
		var openingDate =document.transTripSheet.opening.value;
		var closeDate =document.transTripSheet.close.value;
		
		var hire = document.transTripSheet.hire.value;		
		var hireP= document.transTripSheet.hireP.value;		
		var e_hour = document.transTripSheet.e_hour.value;		
		var e_hourP = document.transTripSheet.e_hourP.value;		
		var running_km = document.transTripSheet.running_km.value;		
		var running_kmP = document.transTripSheet.running_kmP.value;		
		var excess_km = document.transTripSheet.excess_km.value;		
		var excess_kmP = document.transTripSheet.excess_kmP.value;		
		
		var betta = document.transTripSheet.betta.value;		
		var bettaP = document.transTripSheet.bettaP.value;		
		var permit = document.transTripSheet.permit.value;		
		var permitP = document.transTripSheet.permitP.value;
		
		var night_halt = document.transTripSheet.night_halt.value;
		var night_haltP = document.transTripSheet.night_haltP.value;
		var hillsCharge = document.transTripSheet.hillsCharge.value;
		var hillsChargeP = document.transTripSheet.hillsChargeP.value;
		var parking = document.transTripSheet.parking.value;
		var parkingP = document.transTripSheet.parkingP.value;
		
		if(notEmpty(dateTime, "Enter Date Time")){
			if(notEmpty(client,"Enter the Client Name")){
					if(notEmpty(boarding,"Enter The Boarding Point")){
						if(notEmpty(driver,"Enter the Driver name")){
							if(isAlphabet(driver,"Driver Name should be in Alphabetic")){
								if(notEmpty(orderBy,"Enter ordered person name")){
									if(isAlphabet(orderBy,"Ordered person name Should be in Alphabetic")){
										if(notEmpty(openingKm,"Enter Opening km")){
											if(isNumeric(openingKm,"openKM should be in Numeric")){
												if(notEmpty(closingKm,"Enter Closing KM")){
													if(isNumeric(closingKm,"ClosingKM shoule be in Numeric")){
														if(notEmpty(openingDate,"Select Opening Date and Time")){
															if(notEmpty(closeDate,"Select Close Date and Time")){
																
																if(isNumeric(hire,"Hire Charge should be in Numeric")){
																	if(isNumeric(hireP,"Hire Paise Charge should be in Numeric")){
																		if(isNumeric(e_hour,"Excess hour should be in Numeric")){
																			if(isNumeric(e_hourP,"Excess hour Paise Charge should be in Numeric")){
																				if(isNumeric(running_km,"Running KM Charge should be in Numeric")){
																					if(isNumeric(running_kmP,"Running KM Paise Charge should be in Numeric")){
																						if(isNumeric(excess_km,"Excess km Charge should be in Numeric")){
																							if(isNumeric(excess_kmP,"Excess km Paise Charge should be in Numeric")){
																								if(isNumeric(betta,"Driver Betta should be in Numeric")){
																									if(isNumeric(bettaP,"Driver Betta Paise Charge should be in Numeric")){
																										if(isNumeric(permit,"Permit Charge should be in Numeric")){
																											if(isNumeric(permitP,"Permit Paise Charge should be in Numeric")){
																												if(isNumeric(night_halt,"Night Halt Charge should be in Numeric")){
																													if(isNumeric(night_haltP,"Night Halt Paise Charge should be in Numeric")){
																														if(isNumeric(hillsCharge,"Hills Charge should be in Numeric")){
																															if(isNumeric(hillsChargeP,"Hills Paise Charge should be in Numeric")){
																																if(isNumeric(parking,"Parking Charge should be in Numeric")){
																																	if(isNumeric(parkingP,"Parking Paise Charge should be in Numeric")){
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
	
	
	
	
	
/*function tripSheet1(){
		
		var dateTime = document.trans_trip_Sheet1.date_time.value;	
		var client = document.trans_trip_Sheet1.client.value;
		var boarding = document.trans_trip_Sheet1.boarding.value;
		var orderBy =document.trans_trip_Sheet1.order.value;
		var driverName =document.trans_trip_Sheet1.driverName.value;
		var openingDate = document.trans_trip_Sheet1.opening.value;
		var closingDate =document.trans_trip_Sheet1.close.value;
		
		if( dateTime.length == 0){
			alert("Please Choose the Date and Time");
			return false;
		}
		 if(client.length == 0 ){
			alert("Please Enter the Client Name");			
			return false;
		}
		 if(boarding.length == 0){
			alert("Please Enter the Boarding point");			
			return false;
		}
		
	 if(orderBy.length == 0){
			alert("Please mention the ordered person name");		
			return false;
		}
		if(driverName.length == 0){
			alert("Please Enter the Driver Name");
		
			return false;
		}
		
	 if(openingDate.length == 0){
			alert("Please Enter Opening Date and Time ");
			
		}
	 if(closingDate.length == 0){
			alert("Please Enter Closing Date and Time ");
			return false;
		}
		else{
			return true;
		}

	}
	*/
	
	function updateVali(){
		var al =  document.transTripSheet.date_time.value;	
		if(document.transTripSheet.date_time.disabled){
			alert("No Fields are Edited");
		return false;
		}
		else{			
			return true;
		}
	}
	
	
	/*
	function updateValidation(){		
		if(document.trans_trip_Sheet_report.date_time.disabled){
			alert("please Enable all the fields");
		return false;
		}
		else{
			return true;
		}
	}
	
	*/
	
	
	
