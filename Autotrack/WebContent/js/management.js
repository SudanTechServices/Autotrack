function customerForm(){
		
		// Make quick references to our fields
		var customerid=document.CustomerInfo.customerid.value;
		
		var customer_name = document.CustomerInfo.customername.value;
		var contact_person = document.CustomerInfo.contactperson.value;
		var contact_number = document.CustomerInfo.contactnumber.value;
		//alert("Inside Validation");
		var date = document.CustomerInfo.date.value;
		var enddate = document.CustomerInfo.enddate.value;
		var nooflicence=document.CustomerInfo.nooflicence.value;
		var customer_address = document.CustomerInfo.address.value;
		
		
		
		// Check each input in the order that it appears in the form!
		  if(notEmpty( customerid, "Please Enter Customer ID")){
		    if(isAlphanumeric(customerid, 'Please enter only numbers & letters for your ID')){
			 if(lengthRestriction(customerid, 1, 40,'ID Should be more than 2 characters')){
				
			if(notEmpty( customer_name, "Please Enter Customer Name")){
			  if(isAlphanumeric(customer_name, 'Please enter only numbers & letters for your name')){
			     if(lengthRestriction(customer_name, 1, 40,'Username length should be below 30 characters')){
				
				 if(notEmpty( contact_person, "Please Enter Contact Person")){
				    if(isAlphabet(contact_person, 'Please enter only numbers & letters for your contact person')){
					   if(lengthRestriction(contact_person, 1, 40,'Person length should be below 40 characters')){
									
						   if(notEmpty( contact_number, "Please Enter Contact number")){
							   if(isnum( contact_number,"Please enter only numbers for your Contact Number")){
					if(lengthRestriction(contact_number, 1, 15,'Contact Number length should be below 15 characters')){
							
						 if(notEmpty( date, "Please Enter Contract Start Date")){
							 
				    		   if(notEmpty( enddate, "Please Enter Contract End Date")){   
				    			
				    		    	 
				    		    	/* if(compare(contract_Start_date,contract_end_date)){*/
				    		    	 if(notEmpty( nooflicence, "Please Enter No Of Lisence ")){
				    		    		 if(isAlphanumeric(nooflicence, "Please enter only numbers & letters for your number of licence")){
				    		    		     if(lengthRestriction(nooflicence, 1, 6,'Number of licence should be less than 6')){   
				    		    		    	 
				    		    		    	 if(notEmpty( customer_address, "Please Enter Address")){
				    		    		    	 if(isAlphanumeric(customer_address, "Please enter only numbers & letters for your Address")){
				    		    						if(lengthRestriction(customer_address, 1, 200,' Address length should be below 30 characters')){
				    		    		    	 
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

function isAlphanumeric(elem,helperMsg)
{
	var TCode =  /^[0-9a-zA-Z ]+$/;

	if(elem.match( TCode ) ) {

		return true;
	}

	else
	{

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