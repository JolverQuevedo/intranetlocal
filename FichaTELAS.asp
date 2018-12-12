<%@ Language=VBScript %>
<% Response.Buffer = true 
' Evita el cache del navegador
Response.addHeader "pragma", "no-cache"
Response.CacheControl = "Private"
Response.Expires = 0%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/FUNCIONftel.ASP"-->

<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	tel = Request.QueryString("tel")
	
CAD  =	" SELECT * from view_telas as t1 " & _
		" WHERE T1.TELA = '"&tel&"'		 " 
'Response.write(CAD)
RS.OPEN CAD,CNN

SET rs2 =  SERVER.CreateObject("ADODB.RECORDSET")
rs2.CURSORLOCATION = 3
rs2.LOCKTYPE       = 3  
rs2.CURSORTYPE     = 1

IF RS.RECORDCOUNT > 0 THEN 	
	rs.movefirst
	nuevo = 1
else 
	nuevo = 0
end if
%>
<html xml:lang="es" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0" />
<title>ESPECIFICACION TECNICA - TELAS</title>
<link rel="stylesheet" type="text/css" href="estilos1.CSS" />

<script language="jscript" type="text/jscript">

function cont()
{return true
}

function HELP(pag)
{
	var opc = "directories=no," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=600, height=600";
	window.open(pag,'HELP',opc)
}

</script>
<script  id="clientEventHandlersJS" language="javascript" type="text/jscript">
<!--
function nume(obj) 
{	if ( isNaN(trim(obj.value)) == true )
	{	alert("Sólo se aceptan números");
	    obj.value='';
	    obj.focus();
		return false ;    
	}
	else
	return true;
}	
function numero(numero, op) 
{	if ( isNaN(trim(numero)) == true )
	{	alert("Sólo se aceptan números");
		return false ;    
	}
	else if (! isNaN(op) && op >0)
	{	if( trim(eval("thisForm.M"+op+".value")) == '')
		{	alert("No puede informar un % de Hilado si antes no indica el código");
			HELP('help/hlphilOS.asp?pos='+op)
			return false;
		}
	}
	porcentaje();
return true;	
}
function rta(op)
{	if (parseInt(op,10)== 1)
    {   if (trim(thisForm.AA.value) != '' && trim(thisForm.PA.value )!= '')
	    {   var med =thisForm.PA.value * thisForm.AA.value
		    thisForm.RA.value = redondea(1000/med,2)
	    }	
	    else if (trim(thisForm.PA.value )== '')
	    {   alert("No ha registrado el PM2 de la tela ACABADA");
	        thisForm.PA.focus();
		    thisForm.RA.value = '';
		    return false;
	    }	
	}
	else
	{   if (trim(thisForm.AAL.value) != '' && trim(thisForm.PAL.value )!= '')
	    {   var med =thisForm.PAL.value * thisForm.AAL.value;
		    thisForm.RTAL.value = redondea(1000/med,2);
	    }	
	    else if (trim(thisForm.PAL.value )== '')
	    {   alert("No ha registrado el PM2 de la tela DESPUES DE LAVADA");
	        thisForm.PAL.focus();
		    thisForm.RTAL.value = '';
		    return false;
	    }	
	}    
	return true;
}
function rtt(op)
{	if (parseInt(op,10)== 1)
    {   if (trim(thisForm.AT.value) != '' && trim(thisForm.PA.value )!= '')
        {	var med =parseFloat(thisForm.PA.value) * parseFloat(thisForm.AT.value);
		    thisForm.RT.value = deci(1000/med/2,2);
	    }	
	    else if (trim(thisForm.PA.value )== '')
	    {   alert("No ha registrado el PM2 de la tela ACABADA")
	        thisForm.PA.focus()
	        thisForm.RT.value = ''
	        return false;
	    }    
	 }
	 else
	 {  if (trim(thisForm.ATL.value) != '' && trim(thisForm.PAL.value )!= '')
	    {	var med =thisForm.PAL.value * thisForm.ATL.value;
			thisForm.RTTL.value = deci(1000/med/2,2);
	    }	
	    else if (trim(thisForm.PAL.value )== '')
	    {   alert("No ha registrado el PM2 de la tela DESPUES DE LAVADO")
	        thisForm.PAL.focus()
	        thisForm.RTTL.value = ''
	        return false;
	    }   
	 }   
    return true;	 
}
function tolera(dato,op)
{   if (parseInt(op,10)==1)
    {   document.all.TMIN.innerHTML = redondea(parseFloat(dato)*.95,2)
        document.all.TMAX.innerHTML = redondea(parseFloat(dato)*1.05,2)
    }
    else
    {   document.all.TMINL.innerHTML = redondea(parseFloat(dato)*.95,2)
        document.all.TMAXL.innerHTML = redondea(parseFloat(dato)*1.05,2)
    }
    return true;
}
function porcentaje(op)
{	var a,b,c
    a =0
    for (b=1;b<7;b++)
	{   if(trim(eval("thisForm.P"+b+".value"))!= '')
	     a += parseFloat(eval("thisForm.P"+b+".value"));
	}
	if(toInt(a) > 100)
	{	alert("La suma de % de materia prima excede al 100%")
		thisForm.P1.focus();
		return false;
	}
	
/*	if ( parseInt(a,10) < 100)
	{	alert("La suma de % de materia prima no llega al 100%")
		thisForm.P1.focus();
		return false;
	}
*/	
return true;
}
//-->
</script>

</head>
<body bgcolor="#FFFFFF" text="#009999" leftmargin="0" topmargin="0" 
	marginwidth="0" marginheight="0" >
<iframe frameborder="1" style="visibility:hidden" height="1" width="100%" id="ACTIV" name="ACTIV"></iframe>
    
    
    
<form id="thisForm" method="post" action="" >
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle" > 
		<td >
			<img src="imagenes/CERRAR.gif" 	style="cursor:hand;" onClick="javascript: window.close();" alt="" />
		</td>		
		<td bgcolor="#ffffff" align="center"><b>
				<font color="#003399" size="3" face="arial"> 
				Especificación de Tela</font></b> 
		</td>
		<td align="right"><img src="imagenes/logo.gif" 	style="cursor:hand;"  alt=""/></td>
    </tr>
</table> 
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>G E N E R A L E S</b></font>
		</td>	
	</tr>
</table>

<table	border="1" cellpadding="1" width="100%" cellspacing="0" 
bgcolor="<%=(Application("COLOR2"))%>" bordercolor="<%=(Application("BARRA"))%>" bordercolordark="<%=(Application("COLOR2"))%>"
bordercolorlight="gainsboro">
  <tr valign="middle">
    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%"><span class="TITULITO">Código</span></td>
    <td align="left" colspan="1" width="5%"><input type="text" id="COD" name="COD" value=
		"<%if nuevo=1 then Response.Write(rs("tela")) else Response.Write("AUTO")%>" 
		tabindex="-1" readonly="readonly" class="texto" style="width:100%" />    </td>
    <td bgcolor="<%=(Application("BARRA"))%>" width="5%"><span class="TITULITO"> Descripción</span></td>
    <td align="left"  bgcolor="<%=(Application("color2"))%>" colspan="12" width="82%">
    <input type="text" id="DESW" name="DESW" maxlength="300" class="BARRA3" value="<%if nuevo=1 then 
		response.write(trim(rs("descripcion")))%><%end if%>" /></td>
  </tr >

  <tr valign="middle">
    <td align="left" bgcolor="<%=(Application("BARRA"))%>"  width="5%" ><span class="TITULITO"> Familia </span></td>
    <td align="left" bgcolor="<%=(Application("color2"))%>"  width="8%" > 
		<select id="FAM"  name="FAM" class= "BARRA3" onChange="llenado();subfam()" <%if nuevo=1 then%> disabled="disabled" <%END IF %>>
			<%CAD =	" SELECT  famtela as correl,			" & _
                    "  descripcion as des	" & _
                    " from famtelas							" & _
                    " where ESTADO = 'A' ORDER BY des		"
                rs2.OPEN CAD, Cnn %>
              <option></option> 
              <%if rs2.recordcount <=0 then%>
                <option value=''>No Hay Familias de Tela Registradas</option>
              <%else%>
                <%rs2.movefirst%>
                <%do while not rs2.eof%>
                    <option value='<%=rs2("correl")%>'><%=rs2("des")%></option>
                    <%rs2.movenext%>
                <%loop%>
              <%end if %>
              <%RS2.CLOSE%>
		</select>
		<%if nuevo=1 then%> 
        <script language="jscript" type="text/jscript">
			var subcadena =  trim('<%=rs("codfam")%>') ;
			var elemento = thisForm.FAM ;
			thisForm.FAM.selectedIndex = seleindice(subcadena,elemento);
		</script>
		<%END IF %>
	</td>
    <td align="left" bgcolor="<%=(Application("BARRA"))%>"  width="5%" ><span class="TITULITO">Sub Familia </span></td>
    <td align="left" bgcolor="<%=(Application("color2"))%>"  width="8%" > 
		<select id="SFAM"  name="SFAM" class= "BARRA3" onChange="llenado()" >
            <option></option>         
			<%if nuevo=1 then 
				cc = trim(rs("codfam")) 
				CAD =	" SELECT  famtela, subfam as cod,			" & _
                    " descripcion as des	" & _
                    " from subfamilias " & _
                    " where ESTADO = 'A' and famtela='"&cc&"' ORDER BY des		"
    	            rs2.OPEN CAD, Cnn %>

				  <%if rs2.recordcount <=0 then%>
	                    <option value=''>No Hay SUB Familias de Tela Registradas</option>
                  <%else%>
						<%rs2.movefirst%>
                        <%do while not rs2.eof%>
                            <option value='<%=rs2("cod")%>'><%=rs2("des")%></option>
                            <%rs2.movenext%>
                        <%loop%>
                  <%end if %>
        	      <%RS2.CLOSE%>
              <%END IF %>
		</select>
		<%if nuevo=1 then%> 
        <script language="jscript" type="text/jscript">
			var subcadena =  trim('<%=rs("SUBFAM")%>') ;
			var elemento = thisForm.SFAM ;
			thisForm.SFAM.selectedIndex = seleindice(subcadena,elemento);
		</script>
		<%END IF %>
	</td>
    
    <td bgcolor="<%=(Application("BARRA"))%>" width="1%"><span class="TITULITO">Tipo</span></td
    ><td align="left" bgcolor="<%=(Application("color2"))%>" width="5%">
    	<select id="TIPTEL"  name="TIPTEL" class= "BARRA3" onChange="llenado()">
				<%CAD =	" SELECT  CODIGO,			" & _
                        "  descripcion as des	" & _
                        " from TIPTEL							" & _
                        " where ESTADO = 'A' ORDER BY des		"
                    rs2.OPEN CAD, Cnn %>
                  <option></option> 
                  <%if rs2.recordcount <=0 then%>
                    <option value=''>No Hay Tipos de Tela Registradas</option>
                  <%else%>
                    <%rs2.movefirst%>
                    <%do while not rs2.eof%>
                        <option value='<%=rs2("codigo")%>'><%=rs2("des")%></option>
                        <%rs2.movenext%>
                    <%loop%>
                  <%end if %>
                  <%RS2.CLOSE%>
			</select>
			<%IF NUEVO =1 THEN %>
            <script language="jscript" type="text/jscript">
				var subcadena =  trim('<%=rs("tiptel")%>') ;
				var elemento = thisForm.TIPTEL ;
				thisForm.TIPTEL.selectedIndex = seleindice(subcadena,elemento);
			</script>
			<%END IF %>
    </td>
	 <td bgcolor="<%=(Application("BARRA"))%>" width="1%"><span class="TITULITO">Titulo</span></td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%">
    	<input id="CODTIT"  name="CODTIT" class= "BARRA2" type="text" onChange="llenado()" readonly="readonly"
        <%if nuevo = 1 then %> value="<%=RS("codtit")%>" <%end if%> />
    </td>
     <td bgcolor="<%=(Application("BARRA"))%>" width="5%"><span class="TITULITO">Creado: </span></td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="10%">
       	<input id="FINI"  name="FINI" class= "BARRA3" type="text" readonly="readonly"
       	value="<%if nuevo = 1 then response.write(RS("FINI")) else response.write(date()) end if%>" />
    </td>
    <td bgcolor="<%=(Application("BARRA"))%>" width="1%"><span class="TITULITO">Stat:</span></td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%">
    	 <select id="STAT"  name="STAT" class= "BARRA3" onChange="llenado()">
				<%CAD =	" SELECT  CODIGO,			    " & _
                        " descripcion as des	        " & _
                        " from STATS where ESTADO = 'A'	" & _
                        " AND CODIGO < '9' ORDER BY des	"
                    rs2.OPEN CAD, Cnn %>
                  <option></option> 
                  <%if rs2.recordcount <=0 then%>
                    <option value=''>No Hay STATS Registrados</option>
                  <%else%>
                    <%rs2.movefirst%>
                    <%do while not rs2.eof%>
                        <option value='<%=rs2("codigo")%>'><%=rs2("des")%></option>
                        <%rs2.movenext%>
                    <%loop%>
                  <%end if %>
                  <%RS2.CLOSE%>
			</select>
			<%IF NUEVO = 1 THEN %>
            <script language="jscript" type="text/jscript">
				var subcadena =  trim('<%=rs("STAT")%>') ;
				var elemento = thisForm.STAT ;
				thisForm.STAT.selectedIndex = seleindice(subcadena,elemento);
			</script>   	
			<%END IF %>
    </td>
     <td bgcolor="<%=(Application("BARRA"))%>" width="5%"><span class="TITULITO">Ficha #: </span></td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%">
       	<input id="FICH"  name="FICH" class= "BARRA3" type="text" 
       	value="<%if nuevo = 1 then response.write(RS("ficha"))  end if%>" />
    </td>
  </tr >
</table>  
<table width="100%" border="1" bordercolordark="DarkOrange" 
cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C O M P O S I C I O N</b></font>
		</td>	
	</tr>
</table>


<%'TABLA PARA MATERIA PRIMA %>
<table border  ="1" cellpadding="1" width="100%" cellspacing="0"  bgcolor="White" bordercolordark="white" bordercolorlight="gainsboro">  
	<tr bgcolor="<%=(Application("BARRA"))%>"  valign="middle" align="center">
		<td  width="10%"><span class="TITULITO"> &nbsp;</span></td>
        <td  width="15%" colspan="3"><span class="TITULITO">HILADO 1</span><img src="IMAGENES\HELP.GIF" width="20" style="cursor:hand;"
			onclick="HELP('help/hlphilOS.asp?pos=1')" border="0" alt="Help Hilado" /></td>
        <td  width="15%" colspan="3"><span class="TITULITO">HILADO 2</span><img src="IMAGENES\HELP.GIF" width="20" style="cursor:hand;"
			onclick="HELP('help/hlphilOS.asp?pos=2')" border="0" alt="Help Hilado" /></td>
        <td  width="15%" colspan="3"><span class="TITULITO">HILADO 3</span><img src="IMAGENES\HELP.GIF" width="20" style="cursor:hand;"
			onclick="HELP('help/hlphilOS.asp?pos=3')" border="0" alt="Help Hilado" /></td>
        <td  width="15%" colspan="3"><span class="TITULITO">HILADO 4</span><img src="IMAGENES\HELP.GIF" width="20" style="cursor:hand;"
			onclick="HELP('help/hlphilOS.asp?pos=4')" border="0" alt="Help Hilado" /></td>
        <td  width="15%" colspan="3"><span class="TITULITO">HILADO 5</span><img src="IMAGENES\HELP.GIF" width="20" style="cursor:hand;"
			onclick="HELP('help/hlphilOS.asp?pos=5')" border="0" alt="Help Hilado" /></td>
        <td  width="15%" colspan="3"><span class="TITULITO">HILADO 6</span><img src="IMAGENES\HELP.GIF" width="20" style="cursor:hand;"
			onclick="HELP('help/hlphilOS.asp?pos=6')" border="0" alt="Help Hilado" /></td>
	</tr >
    <tr >
		<td bgcolor="<%=(Application("BARRA"))%>"  valign="middle" align="center" width="10%">
        <span class="TITULITO">Código</span></td>
		<td width="15%" colspan="3"><input id="M1" name="M1" <%if nuevo = 1 then %> value= '<%=RS("H1")%>' 
			<%end if%> type="text" readonly="readonly" tabindex="-1" class="BARRA2" /></td>
        <td width="15%" colspan="3"><input id="M2" name="M2" <%if nuevo = 1 then %> value= '<%=RS("H2")%>' 
			<%end if%> type="text" readonly="readonly" tabindex="-1" class="BARRA2" /></td>
        <td width="15%" colspan="3"><input id="M3" name="M3" <%if nuevo = 1 then %> value= '<%=RS("H3")%>' 
			<%end if%> type="text" readonly="readonly" tabindex="-1" class="BARRA2" /></td>
        <td width="15%" colspan="3"><input id="M4" name="M4" <%if nuevo = 1 then %> value= '<%=RS("H4")%>' 
			<%end if%> type="text" readonly="readonly" tabindex="-1" class="BARRA2" /></td>
        <td width="15%" colspan="3"><input id="M5" name="M5" <%if nuevo = 1 then %> value= '<%=RS("H5")%>' 
			<%end if%> type="text" readonly="readonly" tabindex="-1" class="BARRA2" /></td>
        <td width="15%" colspan="3"><input id="M6" name="M6" <%if nuevo = 1 then %> value= '<%=RS("H6")%>' 
			<%end if%> type="text" readonly="readonly" tabindex="-1" class="BARRA2" /></td>                    
   </tr>
   <tr>         
   		<td bgcolor="<%=(Application("BARRA"))%>"  valign="middle" align="center" width="10%">
	        <span class="TITULITO">Descripción</span></td>    
		<td width="15%" id="D1" name="D1" class="BARRA2" colspan="3"><%if nuevo=1 then%><%=RS("D1")%><%end if%></td>	
        <td width="15%" id="D2" name="D2" class="BARRA2" colspan="3"><%if nuevo=1 then%><%=RS("D2")%><%end if%></td>	
        <td width="15%" id="D3" name="D3" class="BARRA2" colspan="3"><%if nuevo=1 then%><%=RS("D3")%><%end if%></td>	
        <td width="15%" id="D4" name="D4" class="BARRA2" colspan="3"><%if nuevo=1 then%><%=RS("D4")%><%end if%></td>	
        <td width="15%" id="D5" name="D5" class="BARRA2" colspan="3"><%if nuevo=1 then%><%=RS("D5")%><%end if%></td>	
        <td width="15%" id="D6" name="D6" class="BARRA2" colspan="3"><%if nuevo=1 then%><%=RS("D6")%><%end if%></td>	
   </tr>
   <tr>         
   		<td bgcolor="<%=(Application("BARRA"))%>"  valign="middle" align="center" width="10%">
	        <span class="TITULITO">Porcentaje</span></td>    
		<td bgcolor="<%=(Application("color2"))%>" width="5%" class="TALASWHITE" id="T1"><%if nuevo=1 then %> <%=RS("T1")%><%end if%></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"><input id="P1" name="P1" <%if nuevo=1 then %> value='<%=RS("P1")%>' 
			<%end if%> type="text" onChange="return numero(window.thisForm.P1.value,1);" onBlur="llenado()" class="datosgrande" /></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"class="BARRA2">%</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%" class="TALASWHITE" id="T2"><%if nuevo = 1 then %> <%=RS("T2")%><%end if%></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"><input id="P2" name="P2" <%if nuevo = 1 then %> value= '<%=RS("P2")%>' 
			<%end if%> type="text" onChange="return numero(window.thisForm.P2.value,2);" onBlur="llenado()" class="datosgrande" /></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"class="BARRA2">%</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%" class="TALASWHITE" id="T3"><%if nuevo = 1 then %> <%=RS("T3")%><%end if%></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"><input id="P3" name="P3" <%if nuevo = 1 then %> value= '<%=RS("P3")%>' 
			<%end if%> type="text" onChange="return numero(window.thisForm.P3.value,3);" onBlur="llenado()" class="datosgrande" /></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"class="BARRA2">%</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%" class="TALASWHITE" id="T4"><%if nuevo = 1 then %> <%=RS("T4")%><%end if%></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"><input id="P4" name="P4" <%if nuevo = 1 then %> value= '<%=RS("P4")%>' 
			<%end if%> type="text"  onchange="return numero(window.thisForm.P4.value,4);" onBlur="llenado()"  class="datosgrande" /></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"class="BARRA2">%</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%" class="TALASWHITE" id="T5"><%if nuevo = 1 then %> <%=RS("T5")%><%end if%></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"><input id="P5" name="P5" <%if nuevo = 1 then %> value= '<%=RS("P5")%>' 
			<%end if%> type="text"  onchange="return numero(window.thisForm.P5.value,5);"  onblur="llenado()" class="datosgrande" /></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"class="BARRA2">%</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%" class="TALASWHITE" id="T6"><%if nuevo = 1 then %> <%=RS("T6")%><%end if%></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"><input id="P6" name="P6" <%if nuevo = 1 then %> value= '<%=RS("P6")%>' 
			<%end if%> type="text"  onchange="return numero(window.thisForm.P6.value,6);"  onblur="llenado()" class="datosgrande" /></td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"class="BARRA2">%</td>
	</tr>
</table>    
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" >
			<font size="1" color="navy" face="ARIAL"><b>T E J I D O &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     C R U D O   </b></font>
		</td>	
	</tr >
</table>

<table border="1" cellpadding="1" cellspacing="0" width="100%" bgcolor="White" bordercolor="SeaGreen" bordercolordark="white"  bordercolorlight="gainsboro">  
<tr>
	<td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="10%" colspan="2"><span class="TITULITO">Máquina &nbsp;<img src="IMAGENES\HELP.GIF" width="20" style="cursor:hand;" onClick="HELP('help/HLPmaquinas.asp')" border="0" alt="Help Maquinas" /></span>
    </td>
    <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="5%" colspan="2"><span class="TITULITO">Tipo</span></td> 
    <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="5%" colspan="2"><span class="TITULITO">Modelo</span></td> 
    <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="5%" colspan="2"><span class="TITULITO">Marca</span></td>
    <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="8%"><span class="TITULITO">Diámetro</span></td>   
         <input id="CMAQ" name="CMAQ" style="display:'none'" value="<%if nuevo = 1 then %><%response.write(TRIM(RS("CODMAQ")))%><%end if %>" />
    
 </tr>
 <tr>  
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%" onChange="llenado()"  id="CODMAQ"  name="CODMAQ" class="BARRA2">
		<%if nuevo = 1 then %><%=TRIM(RS("CODMAQ"))%><%end if%> </td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="10%" id="DESMAQ"  name="DESMAQ" class="BARRA2"><%if nuevo = 1 then %>
		<%=RS("DESMAQ")%> <%end if%> </td>  
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%"  id="CODTIP"  name="CODTIP" class="BARRA2">
		<%if nuevo = 1 then %><%=TRIM(RS("CODTmaq"))%> <%end if%> </td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="10%" id="DESTIP"  name="DESTIP" class="BARRA2"><%if nuevo = 1 then %>
		<%=RS("DESTIP")%> <%end if%> </td>
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%"  id="CODMOD"  name="CODMOD" class="BARRA2">
		<%if nuevo = 1 then %><%=TRIM(RS("CODMOD"))%> <%end if%> </td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="10%"  id="DESMOD"  name="DESMOD" class="BARRA2"><%if nuevo = 1 then %>
		<%=RS("DESMOD")%> <%end if%> </td>
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%"  id="CODMAR"  name="CODMAR" class="BARRA2">
		<%if nuevo = 1 then %><%=TRIM(RS("CODMAR"))%> <%end if%> </td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="10%"  id="DESMAR"  name="DESMAR"  class="BARRA2"><%if nuevo = 1 then %>
		<%=RS("DESMAR")%> <%end if%> </td>
    <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%"  id="DIAM"  name="DIAM" class="BARRA2">
            <%if nuevo = 1 then %><%=TRIM(RS("DIAM"))%> <%end if%> </td>          
        
    </tr>    
    <tr> 
    <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="7%"><span class="TITULITO">Galga</span></td>     
         <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="8%"><span class="TITULITO"># Agujas</span></td>            
         <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="8%"><span class="TITULITO"># Sistemas</span></td> 
         <td align="center" valign="middle" bgcolor="<%=(Application("barra"))%>" width="8%"><span class="TITULITO"># Alimentadores</span></td>
          <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="8%"><span class="TITULITO">DNS Crudo</span></td>
         <td bgcolor="<%=(Application("BARRA"))%>" align="center"  width="8%"><span class="TITULITO">Ancho Crudo</span></td>
         <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="8%"><span class="TITULITO">LM 1</span></td>         
         <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="8%"><span class="TITULITO">LM 2</span></td>
         <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="8%"><span class="TITULITO">LM 3</span></td>
	</tr>         
    <tr>       
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%" id="GG" name="GG" class="BARRA2">
            <%if nuevo = 1 then %><%=TRIM(RS("GG"))%> <%end if%> </td>          
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%" id="AGU" name="AGU" class="BARRA2">
            <%if nuevo = 1 then %><%=TRIM(RS("AGU"))%> <%end if%> </td>                 
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%" id="SIST" name="SIST" class="BARRA2">
            <%if nuevo = 1 then %><%=TRIM(RS("SIST"))%> <%end if%> </td>             
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="5%" id="ALIM" name="ALIM" class="BARRA2">
            <%if nuevo = 1 then %><%=TRIM(RS("ALIM"))%> <%end if%> </td>   
     <td bgcolor="<%=(Application("color2"))%>" width="8%">
        <input type="text" class="DATOSgrande" id="PC" name="PC" <%if nuevo=1 then %> value='<%=TRIM(RS("PC"))%>' <%end if%> onChange="nume(this);llenado()" /></td>
     <td align="left" bgcolor="<%=(Application("color2"))%>" width="8%">
        <input type="text" class="DATOSgrande" id="AC" name="AC" <%if nuevo=1 then %> value='<%=TRIM(RS("AC"))%>' <%end if%> onChange="nume(this);llenado()" /></td>
	<td bgcolor="<%=(Application("color2"))%>" width="8%">
       <input type="text" class="DATOSgrande" id="LM1" name="LM1" <%if nuevo=1 then %> value='<%=TRIM(RS("LM1"))%>' <%end if%> onChange="nume(this);llenado()" /></td>
    <td bgcolor="<%=(Application("color2"))%>" width="8%">
       <input type="text" class="DATOSgrande" id="LM2" name="LM2" <%if nuevo=1 then %> value='<%=TRIM(RS("LM2"))%>' <%end if%> onChange="nume(this);llenado()" /></td>
    <td bgcolor="<%=(Application("color2"))%>" width="8%">
       <input type="text" class="DATOSgrande" id="LM3" name="LM3" <%if nuevo=1 then %> value='<%=TRIM(RS("LM3"))%>' <%end if%> onChange="nume(this);llenado()" /></td>
	</tr>
</table>  

<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>A C A B A D O&nbsp;&nbsp;&nbsp; T E Ñ I D O </b></font>
		</td>	
	</tr>
</table>
<%'A C A B A D O%>
<table border="1" cellpadding="1" cellspacing="0" width="100%" bgcolor="White" bordercolor="SeaGreen" bordercolordark="#FFFFFF" bordercolorlight="GAINSBORO">	<tr valign="middle"> 
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> DNS Acabado</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Tol. MIN (-5%)</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Tol. MAX (+5%)</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO">Ancho Tubular</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO">Ancho Abierto</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Rend. Tela Tubular</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Rend. Tela Abierta</span></td>
       <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Cursas "</span></td>
         <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Columnas "</span></td>
	</tr>
	<tr>
		<td bgcolor="<%=(Application("color2"))%>"> 
		<input id="PA" name="PA" <%if nuevo = 1 then %> value= '<%=rs("pa")%>' <%end if%> type="text" class="DATOSgrande" onChange="nume(this);tolera(this.value,1);llenado()"/>		</td>	
     <td align="left" bgcolor="<%=(Application("color2"))%>"id="TMIN"  name="TMIN" class="BARRA2">
        <%if nuevo=1 then %><%=TRIM(RS("TMIN"))%> <%end if%> </td>   
         <td align="left" bgcolor="<%=(Application("color2"))%>" id="TMAX"  name="TMAX" class="BARRA2">
        <%if nuevo=1 then %><%=TRIM(RS("TMAX"))%> <%end if%> </td>  
	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
		<input id="AT" name="AT" <%if nuevo=1 then %> value='<%=rs("at")%>' <%end if%> type="text" onKeyUp="return rtt(1)" onChange="nume(this);llenado()" class="DATOSgrande" />		</td>		
	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
		<input id="AA" name="AA" <%if nuevo = 1 then %> value='<%=rs("aa")%>' <%end if%> type="text" onKeyUp="return rta(1)" onChange="nume(this);llenado()" class="DATOSgrande" />		</td>
	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
		<input type="text" <%if nuevo = 1 then %> value='<%=rs("rt")%>' <%end if%> id="RT" name="RT" class="texto" readonly="readonly" />
	</td>
	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
		<input type="text" <%if nuevo = 1 then %> value='<%=rs("ra")%>' <%end if%> id="RA" name="RA" class="texto" readonly="readonly" /></td>
 <td bgcolor="<%=(Application("color2"))%>" width="8%">
        <input type="text" class="DATOSgrande" id="CUR" name="CUR" <%if nuevo=1 then %> value='<%=TRIM(RS("CUR"))%>' <%end if%>  onchange="return nume(this);llenado()" /></td>    
		<td bgcolor="<%=(Application("color2"))%>" width="8%">
        <input type="text" class="DATOSgrande" id="COL" name="COL" <%if nuevo=1 then %> value='<%=TRIM(RS("COL"))%>' <%end if%> onChange="return nume(this);llenado()" /></td> 			              	
    </tr>
   </table>   
 <table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C A L I D A D &nbsp;&nbsp;&nbsp;&nbsp;T E Ñ I D O</b></font></td>	
	</tr >
</table>

<table border="1" cellpadding="1" cellspacing="0" width="100%" bgcolor="White" bordercolor="SeaGreen" 
bordercolordark="#FFFFFF"  bordercolorlight="GAINSBORO">  

	<tr valign="middle"> 
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center" rowspan="2" valign="middle"><span class="TITULITO"> Encogimiento Largo <br />%</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 1</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 2</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO"> Lavada # 3</span></td>
       <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center" rowspan="2" valign="middle"><span class="TITULITO"> Encogimiento Ancho<br /> %</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 1</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 2</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO"> Lavada # 3</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">% Revirado</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Inclinaci&oacute;n</span></td>
   </tr>
  <tr>
  		              
   <td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EL1" name="EL1" <%if nuevo = 1 then %> value='<%=rs("EL1")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
   	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EL2" name="EL2" <%if nuevo = 1 then %> value='<%=rs("EL2")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
  	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EL3" name="EL3" <%if nuevo = 1 then %> value='<%=rs("EL3")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>
              <td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EA1" name="EA1" <%if nuevo = 1 then %> value='<%=rs("EA1")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
   	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EA2" name="EA2" <%if nuevo = 1 then %> value='<%=rs("EA2")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
  	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EA3" name="EA3" value="<%if nuevo = 1 then response.write(rs("EA3")) %>"
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	  
	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="REV" name="REV" <%if nuevo = 1 then %> value='<%=rs("REV")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
    <td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="DDL" name="DDL" <%if nuevo = 1 then %> value='<%=rs("DDL")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	                            
</tr>        	  
   </table>
     
 
 <table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>P A Ñ O S&nbsp;&nbsp;&nbsp;&nbsp; L A V A D O </b></font>
		</td>	
	</tr>
</table>
<%'A C A B A D O%>
<table border="1" cellpadding="1" cellspacing="0" width="100%"  bgcolor="White" bordercolor="SeaGreen" bordercolordark="#FFFFFF"  bordercolorlight="GAINSBORO">  
	<tr valign="middle"> 
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> DNS Lavado</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Tol. MIN (-5%)</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Tol. MAX (+5%)</span></td>
     
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO">Ancho Tubular</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO">Ancho Abierto</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Rend. Tela Tubular</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Rend. Tela Abierta</span></td>
       <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Cursas "</span></td>
         <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Columnas "</span></td>
	</tr>
	<tr>
		<td bgcolor="<%=(Application("color2"))%>"> 
		<input id="PAL" name="PAL" <%if nuevo = 1 then %> value= '<%=rs("paL")%>' <%end if%> type="text" class="DATOSgrande" onChange="nume(this);tolera(this.value,2)"/>		</td>	
         <td align="left" bgcolor="<%=(Application("color2"))%>" id="TMINL"  name="TMINL" class="BARRA2">
            <%if nuevo = 1 then %><%=TRIM(RS("TMINL"))%> <%end if%> </td>   
             <td align="left" bgcolor="<%=(Application("color2"))%>" id="TMAXL"  name="TMAXL" class="BARRA2">
            <%if nuevo = 1 then %><%=TRIM(RS("TMAXL"))%> <%end if%> </td>  
           
		<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="ATL" name="ATL" <%if nuevo = 1 then %> value='<%=rs("atL")%>' <%end if%> type="text"  onchange="return nume(this)"
			onkeyup="return rtt();" class="DATOSgrande" />		</td>		
		<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="AAL" name="AAL" <%if nuevo = 1 then %> value='<%=rs("aaL")%>' <%end if%> type="text" onChange="return nume(this)" onKeyUp="return rta()" class="DATOSgrande" />		</td>
		<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input type="text"  <%if nuevo = 1 then %> value='<%=rs("rTtL")%>' <%end if%>
			id="RTTL" name="RTTL" onChange="return nume(this)" class="texto" readonly="readonly"/>
		</td>
		<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="RTAL" name="RTAL" <%if nuevo = 1 then %> value='<%=rs("rTaL")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="texto" readonly="readonly" /></td>
 <td bgcolor="<%=(Application("color2"))%>" width="8%">
        <input type="text" class="DATOSgrande" id="CURLAV" name="CURLAV" <%if nuevo = 1 then %> value= '<%=TRIM(RS("CURLAV"))%>' <%end if%> onChange="return nume(this)" /></td>    
		<td bgcolor="<%=(Application("color2"))%>" width="8%">
        <input type="text" class="DATOSgrande" id="COLLAV" name="COLLAV" <%if nuevo = 1 then %> value= '<%=TRIM(RS("COLLAV"))%>' <%end if%> onChange="return nume(this)" /></td> 			              	
    </tr>
   </table>     
   
   
   
    
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C A L I D A D&nbsp;&nbsp;&nbsp;&nbsp;L A V A D O </b></font></td>	
	</tr >
</table>

<table border="1" cellpadding="1" cellspacing="0" width="100%" bgcolor="White" bordercolor="SeaGreen" 
bordercolordark="#FFFFFF"  bordercolorlight="GAINSBORO">  

	<tr valign="center"> 
     
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center" rowspan="2" valign="middle"><span class="TITULITO"> Encogimiento Largo <br />%</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 1</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 2</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO"> Lavada # 3</span></td>
       <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center" rowspan="2" valign="middle"><span class="TITULITO"> Encogimiento Ancho<br /> %</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 1</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="TITULITO"> Lavada # 2</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="TITULITO"> Lavada # 3</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">% Revirado</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="TITULITO">Inclinaci&oacute;n</span></td>
   </tr>
  <tr>
  		              
   <td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="ELL1" name="ELL1" <%if nuevo = 1 then %> value='<%=rs("ELL1")%>' <%end if%>
        	  type="text" onChange="return nume(this)" class="DATOSgrande" /></td>	
   	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="ELL2" name="ELL2" <%if nuevo = 1 then %> value='<%=rs("ELL2")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
  	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="ELL3" name="ELL3" <%if nuevo = 1 then %> value='<%=rs("ELL3")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>
              <td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EAL1" name="EAL1" <%if nuevo = 1 then %> value='<%=rs("EAL1")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
   	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EAL2" name="EAL2" <%if nuevo = 1 then %> value='<%=rs("EAL2")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
  	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="EAL3" name="EAL3" <%if nuevo = 1 then %> value='<%=rs("EAL3")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	  
	<td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="REVL" name="REVL" <%if nuevo = 1 then %> value='<%=rs("REVL")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	
    <td align="left" bgcolor="<%=(Application("color2"))%>"> 
			<input id="DDLL" name="DDLL" <%if nuevo = 1 then %> value='<%=rs("DDLL")%>' <%end if%>
        	  type="text"  onchange="return nume(this)" class="DATOSgrande" /></td>	     
</tr>        	                         
   </table>
   
   
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C O S T O S</b></font></td>	
	</tr >
</table><%'I N V E N T A R I O%>
<table border="1" cellpadding="1" cellspacing="0" width="100%"  bgcolor="<%=(Application("color2"))%>" bordercolor="<%=(Application("barra"))%>" bordercolordark="#FFFFFF"  
bordercolorlight="GAINSBORO">  
<tr >
    <td bgcolor="<%=(Application("BARRA"))%>" width="8%"><span class="TITULITO"> REAL SOFT</td>
    <td bgcolor="<%=(Application("color2"))%>" width="40%"> 
       <select id="REALSOFT" style="width:100%" name="REALSOFT" class="barra3" onChange="thisForm.RCOD.value=this.value">
           <option></option>
            <%Set   RS2 = Server.CreateObject("ADODB.Recordset")
	            RS2.ActiveConnection = Cnn
	            RS2.CursorType       = 3 'CONST adOpenStatic = 3
	            RS2.LockType         = 1 'CONST adReadOnly = 1 
            CAD = "select ltrim(rtrim(AR_CCODIGO)) AS COD, AR_CCODIGO + ' - ' + AR_CDESCRI AS DES " & _
                    " from RSFACCAR.DBO.AL0001ARTI where AR_CGRUPO='TL' " & _
                    " ORDER BY AR_Ccodigo"
	        RS2.OPEN CAD, Cnn %>
	        <%if rs2.recordcount <=0 then%>
           		 <option value=''>No Hay Telas Registradas </option>
            <%else%>
				<%rs2.movefirst%>
                <%do while not rs2.eof%>
                    <option value="<%=rs2("COD")%>"><%=(ucase(rs2("DES")))%></option>
                <%rs2.movenext%>
                <%loop%>
          <%end if %>
          <%rs2.close%>
        </select>
    	<%IF NUEVO = 1 THEN %>
        <script language="jscript" type="text/jscript">
			var subcadena =  trim('<%=rs("realcod")%>') ;
			var elemento = thisForm.REALSOFT ;
			thisForm.REALSOFT.selectedIndex = seleindice(subcadena,elemento);
		</script>   	
		<%END IF %>
    </td>
    <td><input id="RCOD" id="RCOD" <%IF NUEVO = 1 THEN %>value="<%=TRIM(RS("REALCOD"))%>" <%END IF%> class="DATOS" /></td>
    <td bgcolor="<%=(Application("BARRA"))%>" width="5%"><span class="TITULITO">Unidad:</span></td>
    <td width="10%">
    <select id="UNI" style="width:100%" name="UNI" class="barra3">
           <option></option>
            <%CAD = "select TG_CCLAVE AS COD, TG_CDESCRI AS DES from RSFACCAR.DBO.AL0001TABL WHERE TG_CCOD='05' ORDER BY DES"
	        RS2.OPEN CAD, Cnn %>
	        <%if rs2.recordcount <=0 then%>
           		 <option value=''>No Hay Monedas Registradas </option>
            <%else%>
				<%rs2.movefirst%>
                <%do while not rs2.eof%>
                        <option value='<%=rs2("COD")%>'><%=(ucase(rs2("DES")))%> </option>
                <%rs2.movenext%>
                <%loop%>
          <%end if %>
          <%rs2.close%>
        </select>
        	<%IF NUEVO = 1 THEN %>
        <script language="jscript" type="text/jscript">
			var subcadena =  trim('<%=rs("UNI")%>') ;
			var elemento = thisForm.UNI ;
			thisForm.UNI.selectedIndex = seleindice(subcadena,elemento);
		</script>   	
		<%END IF %>
        </td> 
    <td width="5%"bgcolor="<%=(Application("BARRA"))%>"  ><span class="TITULITO">Moneda</td>
    <td bgcolor="<%=(Application("color2"))%>" width="10%" colspan="1"> 
       <select id="MON" style="width:100%;border='1'" name="MON" class="barra3">
           <option></option>
            <%CAD = "select TG_CCLAVE AS COD, ltrim(rtrim(TG_CDESCRI)) AS DES from RSFACCAR.DBO.AL0001TABL WHERE TG_CCOD='03' ORDER BY DES"
	        RS2.OPEN CAD, Cnn %>
	        <%if rs2.recordcount <=0 then%>
           		 <option value=''>No Hay Monedas Registradas </option>
            <%else%>
				<%rs2.movefirst%>
                <%do while not rs2.eof%>
                        <option value=<%=rs2("COD")%>><%=(ucase(rs2("DES")))%> </option>
                <%rs2.movenext%>
                <%loop%>
          <%end if %>
          <%rs2.close%>
        </select>
        	<%IF NUEVO = 1 THEN %>
        <script language="jscript" type="text/jscript">
			var subcadena =  trim('<%=rs("MON")%>') ;
			var elemento = thisForm.MON ;
			thisForm.MON.selectedIndex = seleindice(subcadena,elemento);
		</script>   	
		<%END IF %>
    </td>
    <td bgcolor="<%=(Application("BARRA"))%>" width="5%"><span class="TITULITO">COSTO:</td>
    <td bgcolor="<%=(Application("color2"))%>" width="5%"><input id="CTO" name="CTO" <%if nuevo=1 then %> value= '<%=rs("cto")%>' <%end if%>  
		class="datos" onChange="nume(this)"/>
      </td>
	</tr >      
	
</table>

 <table	border="1" cellpadding="1" width="100%" cellspacing="0" 
bgcolor="<%=(Application("COLOR2"))%>" bordercolor="<%=(Application("BARRA"))%>" bordercolordark="<%=(Application("COLOR2"))%>"
bordercolorlight="gainsboro">
	<tr valign="middle">
		<td bgcolor="#f7d975" width="50%"><font size="1" color="navy" face="Arial, Helvetica, sans-serif"><b>C O M E N T A R I O S</b></font></td>
		<td bgcolor="#f7d975" width="50%"><font size="1" color="navy" face="Arial, Helvetica, sans-serif"><b>D E S A R R O L L O</b></font></td>
    </tr >
</table>    
<table	border="1" cellpadding="1" width="100%" cellspacing="0" 
bgcolor="<%=(Application("COLOR2"))%>" bordercolor="<%=(Application("BARRA"))%>" bordercolordark="<%=(Application("COLOR2"))%>"
bordercolorlight="gainsboro">
    <tr > 
      <td width="50%" bgcolor="<%=application("color2") %>"> 
        <TEXTAREA id="CONTENIDO" name="CONTENIDO" rows="5" wrap="virtual" style="width:100%;"> <%if nuevo = 1 then %> 
        <%cad= "select * from [tela-obs] where tela = '"&tel&"'"
        rs2.open cad,cnn
        if rs2.recordcount > 0 then %>
		    <%=rs2("OBSERVACION")%> 
		<%end if %>    
		
		<%end if%> </textarea>
      </td>
      <td width="50%" bgcolor="<%=application("color2") %>"> 
        <textarea id="DESARROLLO" name="DESARROLLO" rows="5" wrap="virtual" style="width:100%;"> <%if nuevo = 1 then %> 
        <%if rs2.recordcount > 0 then %>
		    <%=rs2("COMENTARIO")%> 
		<%end if %>    
		
		<%end if%> </textarea>
      </td>
    </tr >
  </table>
  <center>
  <%if cInt(trim(nivel)) = 1 then %>
  <img src="imagenes/disk.gif" style="cursor:hand;" onClick="return GRABA();" alt ="" /> 
  <%end if%></center>
  
  
  <table border="0" cellpadding="1" 	cellspacing="0" align="center" valign="middle" height="22"
  bgcolor="<%=application("color>2")%>" bordercolor="<%=application("color2") %>" bordercolordark="<%=application("color2") %>"
  bordercolorlight="GAINSBORO">
	<tr valign="middle">
		<td ><span class="texto"><b>&nbsp;&nbsp;Fecha : &nbsp;&nbsp;</b></span></td>
		<td ><input	value='<%=DATE()%>' id="FEC" name="fec" class="TEXTO" /></td>
		<td ><span class="texto"><b>&nbsp;&nbsp;Usuario :&nbsp;&nbsp;</b></span></td>
		<td ><input	value = '<%=txtUsuario%>'id="USR" class="texto" /></td>
		<td align="right"><span class="texto"><b>&nbsp;&nbsp;Estado :&nbsp;&nbsp;</b></span></td>
		<td ><input	value = 'A' id="EDO" name="EDO" class="texto" /></td>
	</tr >
</table>




<script language="jscript" type="text/jscript">

function llenado()
{   thisForm.DESW.value  = ''
    thisForm.DESW.value += thisForm.FAM.options(thisForm.FAM.selectedIndex).innerHTML;  
	if (thisForm.SFAM.selectedIndex != -1)
	thisForm.DESW.value += ' ' + thisForm.SFAM.options(thisForm.SFAM.selectedIndex).innerHTML;
    var aPor = new Array()
    var aTit = new Array()
    con =0
    for (t=1; t<7; t++)
    {   if (trim(eval("thisForm.P"+t+".value"))!='' && parseFloat(eval("thisForm.P"+t+".value"))>0)
        {   aPor[con] =parseFloat(eval("thisForm.P"+t+".value")) 
            eval("thisForm.P"+t+".value=aPor[con]")
            aTit[con++] = eval("document.all.T"+t+".innerHTML")
        }
    }
   
    var i, j, x,y 
	for (i=0; i<aPor.length; i++)
	{	for (j=i+1; j<aPor.length; j++)
		{	if ((aPor[i]) < (aPor[j]))
			{	x = aPor[i]
			    y = aTit[i]
				aPor[i] = aPor[j]
				aTit[i] = aTit[j]
				aPor[j] = x
				aTit[j] = y
			}
		}
	}
	
    thisForm.CODTIT.value = aTit[0]
    if (trim(thisForm.CODTIT.value)!= 'undefined')
    {   rr = parseInt(Left(thisForm.CODTIT.value,3),10)
        thisForm.DESW.value += ' ' + rr + '/' + Right(thisForm.CODTIT.value,1) + ' '
    }
    else
    thisForm.CODTIT.value=''    
    
	if (aTit.length >1)
	   thisForm.DESW.value += ' Mix: ' 
	
    for (a=1; a<=aTit.length; a++)
    {  // jalar la parte izquierda hasta llegar a la cadena "TIT" de la descripcion
        BB = eval("document.all.D"+a+".innerHTML")
        tt = parseInt(Left(eval("document.all.T"+a+".innerHTML"),3),10)+'/'+Right(eval("document.all.T"+a+".innerHTML"),1) + ' '
        thisForm.DESW.value += Left(BB, BB.indexOf('TIT',0)) + tt +' (' + parseInt(eval("thisForm.P"+a+".value"),10) + '%), '
    }
    thisForm.DESW.value += ' GG: ' + document.all.GG.innerHTML + ', '
    
    thisForm.DESW.value += ' gr/m2: ' + thisForm.PA.value+ ', '   
    if (trim(thisForm.AT.value) != '' )
        thisForm.DESW.value += ' AT: ' + thisForm.AT.value+ ' mt, '   
    if (trim(thisForm.AA.value) != '' )
        thisForm.DESW.value += ' AA: ' + thisForm.AA.value + ' mt, '   
    thisForm.DESW.value += ' ' + thisForm.TIPTEL.options(thisForm.TIPTEL.selectedIndex).innerHTML; 


}
 function NUMERO(obj)
 {	if (isNaN(obj.value))
	{	obj.value = ''
		alert("Sólo se aceptan números")
		obj.focus()
		return false
	}
 }
 
 function fValidaInput() 
{
  var mcadena = document.getElementById('DES').value;
  /*var mcadena =thisForm.COD.value*/
   var marray1 = mcadena.split("'");
   var marray2 = mcadena.split("&");
   if (marray1.length > 1 )
	{	alert('Caracter Invalido');
		document.getElementById('DES').focus();
	 	document.getElementById('DES').value ='';		
		return false;
	}	
   if (marray2.length > 1 )
	{	alert('Caracter Invalido, usa "Y"');
		document.getElementById('DES').focus();
	 	document.getElementById('DES').value ='';		
		return false;
	}	
}
 
function subfam()
{   thisForm.SFAM.value = '';
    cad = 'bake/bakesubfamilias.asp?pos='+trim(thisForm.FAM.value)+'&sele='+'SFAM'
    document.all.ACTIV.src= cad
}
</script>	
</form>
</body>
</html>
