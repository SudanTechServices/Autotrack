ComboBox=function(a){this.edit=document.getElementById(a);var f=document.getElementById(a).parentNode.getElementsByTagName("DIV");this.dropdownlist=f[0];this.currentitem=null;this.currentitemindex=null;this.visiblecount=0;var d=this;var e=document.getElementById(a).parentNode.getElementsByTagName("SPAN");e[0].onclick=function(){d.edit.focus()};this.edit.onfocus=function(){d.dropdownlist.style.display="block"};this.edit.onblur=function(){setTimeout(function(){d.dropdownlist.style.display="none"},100)};this.listitems=this.dropdownlist.getElementsByTagName("A");for(var c=0;c<this.listitems.length;c++){var b=c;this.listitems[c].onclick=function(){var g=this.innerHTML;g=g.replace(/\<b\>/ig,"");g=g.replace(/\<\/b\>/ig,"");d.edit.value=g;d.dropdownlist.style.display="none";return false};this.listitems[c].onmouseover=function(h){for(var g=0;g<d.listitems.length;g++){if(this==d.listitems[g]){if(d.currentitem){d.currentitem.className=d.currentitem.className.replace(/light/g,"")}d.currentitem=d.listitems[g];d.currentitemindex=g;d.currentitem.className+=" light"}}}}this.edit.onkeydown=function(h){h=h||window.event;if(h.keyCode==38){var i=0;if(d.visiblecount>0){if(d.visiblecount==1){d.currentitemindex=d.listitems.length-1}do{d.currentitemindex--;i++}while(d.currentitemindex>0&&d.listitems[d.currentitemindex].style.display=="none");if(d.currentitemindex<0){d.currentitemindex=d.listitems.length-1}if(d.currentitem){d.currentitem.className=d.currentitem.className.replace(/light/g,"")}d.currentitem=d.listitems[d.currentitemindex];d.currentitem.className+=" light";d.currentitem.scrollIntoView(false)}h.cancelBubble=true;h.preventDefault();h.stopPropagation();return false}else{if(h.keyCode==40){var g=0;if(d.visiblecount>0){do{d.currentitemindex++}while(d.currentitemindex<d.listitems.length&&d.listitems[d.currentitemindex].style.display=="none");if(d.currentitemindex>=d.listitems.length){d.currentitemindex=0}if(d.currentitem){d.currentitem.className=d.currentitem.className.replace(/light/g,"")}d.currentitem=d.listitems[d.currentitemindex];d.currentitem.className+=" light";d.currentitem.scrollIntoView(false)}h.cancelBubble=true;h.preventDefault();h.stopPropagation();return false}}};this.edit.onkeyup=function(l){l=l||window.event;if(l.keyCode==13){if(d.visiblecount!=0){var g=d.currentitem.innerHTML;g=g.replace(/\<b\>/ig,"");g=g.replace(/\<\/b\>/ig,"");d.edit.value=g}d.dropdownlist.style.display="none";l.cancelBubble=true;return false}else{d.dropdownlist.style.display="block";d.visiblecount=0;if(d.edit.value==""){for(var h=0;h<d.listitems.length;h++){d.listitems[h].style.display="block";d.visiblecount++;var k=d.listitems[h].innerHTML;k=k.replace(/\<b\>/ig,"");d.listitems[h].innerHTML=k.replace(/\<\/b\>/ig,"")}}else{var j=new RegExp("("+d.edit.value+")","i");for(var h=0;h<d.listitems.length;h++){var k=d.listitems[h].innerHTML;k=k.replace(/\<b\>/ig,"");k=k.replace(/\<\/b\>/ig,"");if(j.test(k)){d.listitems[h].style.display="block";d.visiblecount++;d.listitems[h].innerHTML=k.replace(j,"<b>$1</b>")}else{d.listitems[h].style.display="none"}}}}}};