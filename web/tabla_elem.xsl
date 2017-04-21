<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    		xmlns:lxslt="http://xml.apache.org/xslt">

<xsl:output method="html"/>

<xsl:template match="/PERIODIC_TABLE">


<html>
<head>

<script language="javascript" type="text/javascript" src="jquery.js"></script> 
<script language="javascript" type="text/javascript" src="xocom.js"></script> 
<script language="javascript" type="text/javascript" src="utiles.js"></script> 

<script language="javascript" type="text/javascript">

	mostrado = false;

</script>

<style type="text/css">
    
    body {
		background-color:#666666;
 	    font:Sans-serif; 
    }

	h1 {
		width:100%;
		text-align:center;
	    font-size:24px; 
		color:white;
	}

	h2 {
		width:90%;
		text-align:left;
	    font-size:14px; 
		color:white;
	}


	.elemento {
	   text-decoration:none;
	    padding-top:5px;
		border: 2px;
		-moz-border-radius:5px;	
		font-size:10px;
	}

    .elemento:hover {
	    background-color:white;
    }

	#pop { 
	   z-index:2; 
	   position:absolute; 
	   border: 2px solid black; 
	   text-align:center; 
	   background:#bbbbbb; 
	   left:200px;
	   top:60px;		
	   -moz-border-radius:5px;	
	   color:black;	
	} 

	#textPopup { 
	   text-align:left; 
	   font-size:12px; 
	   margin:10px;	
	} 

	#wiki { 
	   z-index:2; 
	   position:absolute; 
	   border: 2px solid black; 
	   text-align:center; 
	   background:#bbbbbb; 
	   left:50px;
	   top:80px;		
	   -moz-border-radius:5px;	
	   color:black;	
	} 

	#wikiBody { 
	   width:700px;
	   height:460px;	
	   background:white; 
	   margin:10px;	
	} 

	#misNotas { 
	   z-index:2; 
	   position:absolute; 
	   border: 2px solid black; 
	   text-align:left; 
	   background:#bbbbbb; 
	   left:50px;
	   top:80px;		
	   -moz-border-radius:5px;	
	   color:black;	
	} 


	#textMisNotas { 
	   width:700px;
	   height:460px;	
	   background:white; 
	   margin:10px;	
	} 

	#botonMisNotas { 
	   z-index:2; 
	   position:absolute; 
	   border: 2px solid white; 
	   text-align:left; 
	   background:white; 
	   right:20px;
	   top:20px;		
	   -moz-border-radius:30px;	
	   color:black;	
	   text-decoration:none;
	   padding:5px;
	   font-size:11px; 
	} 

	#botonMisNotas:hover { 
	   border: 2px solid black; 
	   background:black; 
	   color:white;	
	} 

	#cerrar { 
       padding:2px;
	   border: 1px solid black; 
	   float:right; 
	   background:white; 
	   margin:5px; 
	   cursor:pointer;
       generic-family:sans-serif; 
	   font-size:12px; 
	   font-weight:bold; 
	   width:12px; 
	   position:relative; 
	   top:2px;
       right:2px; 
	   text-align:center; 
	   -moz-border-radius:10px;	
	   color:black;	
	}

	#loading { 
	   z-index:2; 
	   position:absolute; 
	   border: 2px solid black; 
	   text-align:center; 
	   background:#bbbbbb; 
	   left:300px;
	   top:150px;		
	   -moz-border-radius:5px;	
	   color:black;	
	   padding:50px;		
	} 
	

    #dhtmltooltip{
        text-align:center;
        position: absolute;
        width: 120px;
        border: 1px solid black;
        padding: 2px;
        background-color: lightyellow;
        visibility: hidden;
        z-index: 100;
	   -moz-border-radius:3px;	    
	}
	
	
</style>


</head>
<body>

    <div id="botonMisNotas" onclick="javascript:verMisNotas()">       
		Mis Notas
    </div>

	<form name="elementData">	
	<div id="pop" style="display:none"> 
	   <div id="cerrar" onclick="cerrar()">X</div>
	   <div id="textPopup">
	   </div>		 
		<input type="hidden" id="elementName" name="elementName"/>
    	<textarea cols="80" rows="5" name="editedText" id="editedText"></textarea>
	</div>

    <div id="dhtmltooltip"></div>

	<p id="loading">Cargando</p>

	<div id="wiki" style="display:none"> 
	   <div id="cerrar" onclick="cerrarWiki()">X</div>
	   <iframe id="wikiBody">
	   </iframe>		 
	</div>

	<div id="misNotas" style="display:none"> 
	   <div id="cerrar" onclick="cerrarMisNotas()">X</div>
	   <div id="textMisNotas">
	   </div>		 
	</div>

	</form>

		<h1>Tabla de los elementos</h1>

        <table  width="100%">
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &lt; 3]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 2 ][ATOMIC_NUMBER &lt; 11 ]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 10 ][ATOMIC_NUMBER &lt; 19 ]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 18 ][ATOMIC_NUMBER &lt; 37 ]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 36 ][ATOMIC_NUMBER &lt; 55 ]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 54 ][ATOMIC_NUMBER &lt; 58 ]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 71 ][ATOMIC_NUMBER &lt; 87 ]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 86 ][ATOMIC_NUMBER &lt; 90 ]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        </table>

        <h2>Serie Lantanidos</h2>

        <table width="100%" >
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 56][ATOMIC_NUMBER &lt; 72]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        </table>

        <h2>Serie Actinidos</h2>

        <table width="100%" >
        <tr>
        <xsl:apply-templates select="/PERIODIC_TABLE/ATOM[ATOMIC_NUMBER &gt; 88]">
                <xsl:sort select="ATOMIC_NUMBER" data-type="number" />
        </xsl:apply-templates>
        </tr>
        </table>

</body>
</html>


</xsl:template>

<xsl:template match="/PERIODIC_TABLE/ATOM">
<xsl:variable name="settings" select="document('../../datos/settings.xml')/settings"/>
        <td bordercolor="black" class="elemento">
	<xsl:choose>
	    <xsl:when test="COLOR=0">
		<xsl:attribute name="bgcolor">#cccccc</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="COLOR=1">
		<xsl:attribute name="bgcolor">#ccccff</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="COLOR=2">
		<xsl:attribute name="bgcolor">#99ff99</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="COLOR=3">
		<xsl:attribute name="bgcolor">#ffff99</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="COLOR=4">
		<xsl:attribute name="bgcolor">#ffcc99</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="COLOR=5">
		<xsl:attribute name="bgcolor">#ff9966</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="COLOR=6">
		<xsl:attribute name="bgcolor">#cc99ff</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="COLOR=7">
		<xsl:attribute name="bgcolor">#007000</xsl:attribute>
	    </xsl:when>



	</xsl:choose>
        <xsl:attribute name="onclick">mostrar('<xsl:value-of select="SYMBOL"/>','<xsl:value-of select="NOMBRE"/>','<xsl:value-of select="NAME"/>','<xsl:value-of select="ATOMIC_WEIGHT"/>','<xsl:value-of select="ATOMIC_NUMBER"/>','<xsl:value-of select="WIKIPEDIA"/>')</xsl:attribute>
        
        <xsl:attribute name="onMouseover">ddrivetip('<xsl:value-of select="NOMBRE"/>')</xsl:attribute>        
        <xsl:attribute name="onMouseout">hideddrivetip()</xsl:attribute>        
      
        <div align="center">
        <xsl:value-of select="SYMBOL"/>
        </div>
		<br/>
        <font size="1">
        <xsl:value-of select="ATOMIC_NUMBER"/>
        </font>

        </td>
        <xsl:if test='ATOMIC_NUMBER=1'>
                <td colspan='16'></td>
        </xsl:if>
        <xsl:if test='ATOMIC_NUMBER=4'>
                <td colspan='10'></td>
        </xsl:if>
        <xsl:if test='ATOMIC_NUMBER=12'>
                <td colspan='10'></td>
        </xsl:if>


</xsl:template>



</xsl:stylesheet>


