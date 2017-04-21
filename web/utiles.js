
	function popup(popup_url,name,popup_width,popup_height) {
	 	var tmp = window.open(popup_url,name,'resizable=no,menubar=no,location=no,toolbar=no,status=yes,scrollbars=yes,directories=no,width='+popup_width+',height='+popup_height);
	}

	function mostrar(symbol,nombre,name,peso,numero,wiki) { 
	   if (!mostrado) {	
			mostrado = true;
			document.elementData.elementName.value = nombre;
			document.elementData.editedText.value = readTextElement(nombre);
			$("#textPopup").html("<p>"+
							"<b>Elemento:</b>&nbsp;"+nombre+" "+
							"(en inglés:&nbsp;"+name+")<br/>"+
							"<b>S&iacute;mbolo:</b>&nbsp;"+symbol+" "+
							"<b>Peso at&oacute;mico:</b>&nbsp;"+peso+" "+
							"<b>N&uacute;mero at&oacute;mico:</b>&nbsp;"+numero+"<br/>"+
							"<a href='javascript:openWiki(\""+wiki+"\")'>Wikipedia</a>"+
							"</p>"							);
			$("#pop").fadeIn('slow');
	   }	
	} 

	function popupText(text) {
		$("#textPopup").html(text);
		$("#pop").fadeIn('slow');
		mostrado = true;
    }

	function openWiki(url) {
   	    document.getElementById("wikiBody").src = url;
		$("#wiki").fadeIn('slow');
	}

	function cerrarWiki() { 
		$("#wiki").fadeOut('slow'); 
	}

	function cerrarMisNotas() { 
		$("#misNotas").fadeOut('slow'); 
	}

	function verMisNotas() { 
		misNotasText = "";
		for (i = 0;i < textos.length; i++) {
			textoElemento = textos[i];
			misNotasText = misNotasText + "<b>"+textoElemento[0]+"</b><br/>"+textoElemento[1]+"<br/><br/>";				
		}
		$("#textMisNotas").html(misNotasText);
		$("#misNotas").fadeIn('slow'); 
	}



	function cerrar() { 
		$("#pop").fadeOut('slow'); 
		mostrado = false;
		if (document.elementData.editedText.value != '') {
			writeTextElement(document.elementData.elementName.value,document.elementData.editedText.value);
		}
	}

	function readTextElement(element) {
		for(var i=0; i<textos.length; i++){
			textoElemento = textos[i];
	        if(textoElemento[0] == element) {
				return textoElemento[1];
            }
        }
		return '';
	}	

	function writeTextElement(element,text) {
		existe = false;
		for(var i=0; i<textos.length; i++){
			textoElemento = textos[i];
	        if(textoElemento[0] == element) {
				existe = true;
				textoElemento[1] = text;
            }
        }
		if (!existe) {
			textos.push(new Array(element,text));
		}
    }


	function debug(element) {
		debugText = '';
		for(var i=0; i<textos.length; i++){
			textoElemento = textos[i];
			debugText = debugText+ '  ' +textoElemento[0]+'='+textoElemento[1];
        }
		popupText(debugText);
	}	


 	XO.register('read', function(content) {
       // Your code to consume the supplied content
		if (content != '') {
			try {
			    //$("#loading").html(content);
				eval(content);		
			} catch(err) {
				textos = new Array();
			}
		}
		$("#loading").fadeOut('slow'); 
		mostrado = false;
		
    })


    XO.register('write', function() {
       // Your code to return the content to save
	   persistent = "textos = new Array(";
		for(var i=0; i<textos.length; i++){
			textoElemento = textos[i];
			persistent = persistent+"new Array('"+textoElemento[0]+"','"+textoElemento[1]+"')";
			if (i < (textos.length -1) ) {
				persistent = persistent +",";
			} else {
				persistent = persistent +");";
			}
        }
       return persistent;
    })

// Tooltip (basado en http://www.dynamicdrive.com/dynamicindex5/dhtmltooltip.htm)

    var offsetxpoint=-60; //Customize x offset of tooltip
    var offsetypoint=20; //Customize y offset of tooltip
    var ie=document.all;
    var ns6=document.getElementById && !document.all;
    var enabletip=false;
    
    if (ie||ns6) 
        var tipobj=document.all? document.all["dhtmltooltip"] : document.getElementById? document.getElementById("dhtmltooltip") : ""

    function ietruebody() {
        return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body;
    }

    function ddrivetip(thetext, thecolor, thewidth) {
        if (ns6||ie){
            if (typeof thewidth!="undefined") tipobj.style.width=thewidth+"px"
                if (typeof thecolor!="undefined" && thecolor!="") tipobj.style.backgroundColor=thecolor
                    tipobj.innerHTML=thetext;
                enabletip=true;
            return false;
        }
    }

    function positiontip(e) {
        if (enabletip) {
            var curX=(ns6)?e.pageX : event.clientX+ietruebody().scrollLeft;
            var curY=(ns6)?e.pageY : event.clientY+ietruebody().scrollTop;
            //Find out how close the mouse is to the corner of the window
            var rightedge=ie&&!window.opera? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20;
            var bottomedge=ie&&!window.opera? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20;

            var leftedge=(offsetxpoint<0)? offsetxpoint*(-1) : -1000;

            //if the horizontal distance isn't enough to accomodate the width of the context menu
            if (rightedge<tipobj.offsetWidth)
            //move the horizontal position of the menu to the left by it's width
                tipobj.style.left=ie? ietruebody().scrollLeft+event.clientX-tipobj.offsetWidth+"px" : window.pageXOffset+e.clientX-tipobj.offsetWidth+"px"
            else if (curX<leftedge)
                tipobj.style.left="5px";
            else
                //position the horizontal position of the menu where the mouse is positioned
                tipobj.style.left=curX+offsetxpoint+"px";

            //same concept with the vertical position
            if (bottomedge<tipobj.offsetHeight)
                tipobj.style.top=ie? ietruebody().scrollTop+event.clientY-tipobj.offsetHeight-offsetypoint+"px" : window.pageYOffset+e.clientY-tipobj.offsetHeight-offsetypoint+"px";
            else
                tipobj.style.top=curY+offsetypoint+"px";
                tipobj.style.visibility="visible";
        }
    }

    function hideddrivetip() {
        if (ns6||ie) {
            enabletip=false;
            tipobj.style.visibility="hidden";
            tipobj.style.left="-1000px";
            tipobj.style.backgroundColor='';
            tipobj.style.width='';
        }
    }

    document.onmousemove=positiontip;






