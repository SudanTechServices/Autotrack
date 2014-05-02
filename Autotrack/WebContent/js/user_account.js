function User(){
	
	var company=document.register.company.value;
	var number=document.register.number.value;
	var email=document.register.email.value;
	var username=document.register.usrname.value;
	var pass=document.register.password.value;
    var cpass=document.register.cpassword.value;
	
	
	
	    if(notEmpty( company, "Please Enter Company Name")){
		 if(isAlphabet( company, 'Please enter only letters in your name')){
		     if(lengthRestriction( company, 1, 25,'Company name length should be below 25 characters')){	
                
		if(notEmpty( number, "Please Enter Contact Number")){
		    		if(isnum( number,"Please enter valid Contact Number")){
		 			  if(lengthRestriction( number, 1, 11,'Contact Number length should be below 12 characters')){
		    	 
    	 
    	if(notEmpty( email, "Please Enter E mail ID")){
    		 
        if(notEmpty( username, "Please Enter User Name")){
    			 if(isAlphabet( username, 'Please enter only letters in your name')){
    					if(lengthRestriction( username, 1, 25,' UserName length should be below 25 characters')){	
    			 
    	if(notEmpty( pass, "Please Enter Password")){
    							if(lengthRestriction( pass, 1, 12,'Password length should be below 12 characters')){		
    						
    				 
        if(notEmpty( cpass, "Please Enter Confirm Password")){
    				        	   if(lengthRestriction( cpass, 1,12,'Too many characters in Confirm Password ')){
    				        		   
    				        		   
    				        			
				                    	if( document.register.privilage.value == "Select" )
										   {
										     alert( "Please Enter The Privilage!" );
										     document.register.privilage.focus();
										     return false;
										   }
										 
    				        		   
    				        		   
    				        		   
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