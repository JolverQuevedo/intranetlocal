<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>**** BUSCADOR ****</title>
</head>
<script type="text/jscript" language="jscript">
var aCon = new Array()
var aDes = new Array()
var aVal = new Array()
var k = 0
</script>
<%	TIT	= Request.QueryString("TIT") ' recibe el titulo de la pagina que lo llamó
	tbl = Request.QueryString("Tbl") ' recibe el nombre de la Tabla o view en donde hay que hacer el filtro
	url = Request.QueryString("url") ' recibe el nombre de la pagina/progama que lo invocó
kat = "%"	
cad = "Select * from Condiciones order by 1"
RS.OPEN CAD, Cnn
	if	 rs.eof or rs.bof then%>
		<script>
		aCon[k]= "" 
		aDes[k]= ""
        aVal[k]= ""
        </script>
	<%else%>
		<%rs.movefirst%>
		<%do while not rs.eof%>
			<script type="text/jscript" language="jscript">
				aCon[k]= '<%=RS("CODIGO")%>'
				aDes[k]= '<%=RS("DESCRIPCION")%>'
				aVal[k]= '<%=RS("VALOR")%>'
				k++
			</script>
		 <%rs.movenext%>
		<%loop%>
	<%end if%>  
	
<%RS.CLOSE%>	
<%IF LEN(TRIM(tbl)) = 0 THEN tbl = "generos" 

cad = "select * from "&TBL&"  ORDER BY 1"

'RESPONSE.Write(CAD)

rs.open cad,cnn


IF LEN(TRIM(TIT)) = 0 THEN TIT = "prueba" 
 
%>
<script type="text/jscript" language="jscript">

var largo = parseInt(aCon.length,10)


</script>

<body>
<form name="thisForm" METHOD="post" onSubmit="envio()" >

<table WIDTH="100%" border="0">

	<tr>
		<td align= "left" WIDTH="10%">
			<img src="../IMagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">			
		</td>
		<td align= CENTER>
			<font face="arial" size="3" color='<%=Application("titulo")%>'><B>
			<%=tit%>
			</b></font>
		</td>
		<TD ALIGN="right" WIDTH="10%"> 
		  	<img src="../IMagenes/logo.GIF">
		  </TD>
        </TR>
	</tr>
	<TR>
	<td COLSPAN="3"><HR></td></TR>
</table>

<table	align="center"  cellpadding="1" cellspacing="2"  bgcolor="WHITE"
border="1" bordercolorlight="GAINSBORO" bordercolordark="WHITE">
	<TR bgcolor="<%=Application("titulo")%>">
    	<TD align="center"><font size="2" color="#FFFFFF" face="Tahoma, Geneva, sans-serif"> Columna</font>
        </TD>
        <TD align="center"><font size="2" color="#FFFFFF" face="Tahoma, Geneva, sans-serif"> Dato</font>
        </TD>
        <TD align="center"><font size="2" color="#FFFFFF" face="Tahoma, Geneva, sans-serif"> Condición</font>
        </TD>
    </TR>
<% tope = cInt(rs.fields.count)-1 %>
<%for i =0 to tope%>
	<tr> 
    	<td  bgcolor="#DDEBC6" ALIGN="RIGHT" ><input id="col<%=i%>"  name="col<%=i%>" 
    	style="font-family:Tahoma, Geneva, sans-serif; font-size:9px; font-style:normal; color:'<%=Application("titulo")%>';
    	 background-color:transparent; border:none; font-weight:bold" value="<%=rs.fields(i).name%>" />  </td>
        
		<td> <input id="dat<%=i%>" name= "dat<%=i%>" value="" tabindex="<%=i+1%>" /></td>
        <td width="100">  <select id="COND<%=i%>" style="WIDTH:100%" name="COND<%=i%>">
                <script type="text/jscript" language="jscript"> 
				
				if(aCon.length ==0)
                {	document.write("<option value=''>")
					document.write("No Hay Condiciones Registradas")
					document.write("</option>")
				}
                else
				{	document.write("<option>")
					document.write("</option>")
					 for (var tu=0; tu<largo; tu++)
                        {   document.write("<option value=")
                            document.write(aCon[tu])
                            document.write(">")
                            document.write(aDes[tu]) 
						    document.write("</option>")
					    }	
				}
				</script>    
              </select></td>
     </tr>
<% next%>

<tr>
	<td colspan="3" align="center">
        <input type="button" style="font-family:Tahoma, Geneva, sans-serif; font-size:9px; font-style:normal; color:#33F; 
        background-color:'<%=(Application("barra"))%>'; font-weight:bold; cursor:hand; vertical-align:central;" 
        value="FILTRAR" onClick="envio()" />
 	</td>

</tr>
<tr><td colspan="3" width="100%" align="center"><input id="filtro" name="filtro" style="width:100%" value = "" /></td></tr>
</table>
<script type="text/jscript" language="jscript">
function envio()
{	tope = '<%=tope%>'
	document.all.filtro.value =''
	for (si=0 ; si<= tope; si++)
	{	// valor de la columna de datos
		dato = trim(eval("thisForm.dat"+si+".value"))
		// valor de la condición
		cond =  trim(eval("thisForm.COND"+si+".value"))
		cond = parseInt(cond,10)
		if ( cond > 0) 
		{   // hay condicion	
		    if(dato.length != 0)
		    {	document.all.filtro.value += trim(eval("thisForm.col"+si+".value")) + ' ' 
				alert(trim(aVal[cond-1]))
				if (trim(aVal[cond-1]) == 'LIKE')
				{	
					document.all.filtro.value +=   'LIKE xxx' + dato + 'xxx'  
				}
				else
					document.all.filtro.value += aVal[cond-1]+ '"'+ dato + '"'
				document.all.filtro.value += ' and '	
		    }
			else
			{	alert("Favor informar el dato correspondiente al filtro seleccionado\n            o dejar en blanco la condición\n\n                                             G R A C I A S")
			}
		}    
		
	}
	
	
	filtro = document.all.filtro.value
	largo = filtro.length
	filtro = Left(filtro, largo - 4)
	cad =  '../' + '<%=url%>' + '?filtro="' + filtro
	alert(cad)



//	parent.window.opener.location.replace(cad)
}
</script>
</form>


</body>
</html>
