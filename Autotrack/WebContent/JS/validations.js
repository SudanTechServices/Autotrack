function checkNotBlankTB(fname,cname,msg)
{
	var val=eval('document.'+fname+'.'+cname+'.value');
	
	
	if(eval(val==''))
	{
		alert(msg+' cannot be blank')
		eval('document.'+fname+'.'+cname+'.focus()');
		return false;
	}
	return true;
		
	
	
}

function checkNotBlankDD(fname,cname,msg)
{
	
	var val=eval('document.'+fname+'.'+cname+'.options[document.'+fname+'.'+cname+'.selectedIndex].text');
	if(val=='Select')
	{
		alert(msg+' cannot be blank')
		eval('document.'+fname+'.'+cname+'.focus()');
		return false;

	}
	return true;
}

function checkMinLength(fname,cname,msg,length)
{
	var val=eval('document.'+fname+'.'+cname+'.value');
	var len=eval('document.'+fname+'.'+cname+'.value.length');
	
	if(eval(val!='') && eval(parseInt(val.length)<parseInt(length)))
	{
		alert(msg)
		eval('document.'+fname+'.'+cname+'.focus()');
		return false;
	}
	return true;
	
}

function checkExactLength(fname,cname,msg,length)
{
	var val=eval('document.'+fname+'.'+cname+'.value');
	var len=eval('document.'+fname+'.'+cname+'.value.length');
	
	if(eval(val!='') && eval(parseInt(len)!=parseInt(length)))
	{
		alert(msg)
		eval('document.'+fname+'.'+cname+'.focus()');
		return false;
	}
	return true;
	
}


function checkDigitsOnly(fname,cname,msg,validchars)
{
	var val=eval('document.'+fname+'.'+cname+'.value');
		
	if(eval(val!=''))
	{
		if(parseInt(validchars.length)>0)
		{
			var allowedchars='"Digits, ';
			var i=0;	
			while(parseInt(i)<parseInt(validchars.length))
			{
				allowedchars=allowedchars+validchars.charAt(i)+' ';
				i=parseInt(i)+1;
			}
			allowedchars=allowedchars+'"'
			var a=new Array(parseInt(validchars.length)+parseInt(10));
			i=0;	
			while(parseInt(i)<parseInt(10))
			{
				a[i]=i;
				i=parseInt(i)+1;
				
			}
			
			i=0;
			var p=10;
			while(parseInt(i)<parseInt(validchars.length))
			{
				a[p]=validchars.charAt(i);
				i=parseInt(i)+1;
				p=parseInt(p)+1;
				
			}
			i=0;
			while(parseInt(i)<parseInt(val.length))
			{
				if(parseInt(a.toString().indexOf(val.charAt(i)))==parseInt(-1))
				{
					alert(msg+'-Allowed characters are '+allowedchars);
					eval('document.'+fname+'.'+cname+'.focus()');
					return false;
				}
				i=parseInt(i)+1;
			}
			
			
		}
		else
		{
			if(isNaN(val)==true)
			{
				alert(msg);
				eval('document.'+fname+'.'+cname+'.focus()');
				return false
			}
		}
		
		
	}
	return true;
	
}