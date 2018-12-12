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
var aCod = new Array()
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
		<script type="text/jscript" language="jscript">
		aCod[k]= "" 
		aDes[k]= ""
        </script>
	<%else%>
		<%rs.movefirst%>
		<%do while not rs.eof%>
			<script type="text/jscript" language="jscript">
				aCod[k]= '<%=RS("CODIGO")%>'
				aDes[k]= '<%=RS("DESCRIPCION")%>'
				aVal[k]= ""
				k++
			</script>
		 <%rs.movenext%>
		<%loop%>
	<%end if%>  
	
<%RS.CLOSE%>	
<%IF LEN(TRIM(tbl)) = 0 THEN tbl = "ERROR" 

cad = "select * from "&TBL&"  ORDER BY 1"
rs.open cad,cnn

IF LEN(TRIM(TIT)) = 0 THEN TIT = "BLANCO" %>
<script type="text/jscript" language="jscript">
	var largo = parseInt(aCod.length,10)
</script>

<body>
<form name="thisForm" method="post" onsubmit="envio()" action="" >
<table width="100%" border="0">
	<tr>
		<td align= "left" width="10%">
			<img src="../IMagenes/CERRAR.gif" 
			style="cursor:hand;" alt=""
			onclick="javascript: window.close();" />			
		</td>
		<td align="center">
			<font face="arial" size="3" color='<%=Application("titulo")%>'><b>
			<%=tit%>
			</b></font>
		</td>
		<td align="right" width="10%"> 
		  	<img src="../IMagenes/logo.GIF" alt="" />
		  </td>
        </tr>
	
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>

<table	align="center"  cellpadding="1" cellspacing="2" border="1" bordercolorlight="GAINSBORO"  bordercolordark="WHITE">
	<tr bgcolor="<%=Application("titulo")%>">
    	<td align="center"><font size="2" color="#FFFFFF" face="Tahoma, Geneva, sans-serif"> Columna</font>
        </td>
        <td align="center"><font size="2" color="#FFFFFF" face="Tahoma, Geneva, sans-serif"> Dato</font>
        </td>
        <td align="center"><font size="2" color="#FFFFFF" face="Tahoma, Geneva, sans-serif"> Condición</font>
        </td>
    </tr>
<% tope = cInt(rs.fields.count)-1 %>
<%for i =0 to tope%>
	<tr> 
    	<td  bgcolor="#DDEBC6" align="right" ><input id="col<%=i%>"  name="col<%=i%>" 
    	style="font-family:Tahoma, Geneva, sans-serif; font-size:9px; font-style:normal; color:'<%=Application("titulo")%>';
    	 background-color:transparent; border:none; font-weight:bold" value="<%=rs.fields(i).name%>" />  </td>
        
		<td> <input id="dat<%=i%>" name= "dat<%=i%>" value="" tabindex="<%=i+1%>" /></td>
        <td width="100">  <select id="COND<%=i%>" style="width:100%" name="COND<%=i%>">
                <script type="text/jscript" language="jscript"> 
				
				if(aCod.length ==0)
                {	document.write("<option value=''>")
					document.write("No Hay Condiciones Registradas")
					document.write("</option>")
				}
                else
				{	document.write("<option>")
					document.write("</option>")
					 for (var tu=0; tu<largo; tu++)
                        {   document.write("<option value=")
                            document.write(aCod[tu])
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
        value="FILTRAR" onclick="envio()" />
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
		if ( cond > 0 && dato.length != 0) 
		{   // hay condicion	
		  	aVal[si]= dato
			aOpc[si]= cond
			document.all.filtro.value += dato + '--' + cond + ' ** '
		}
		else
		{	alert("Favor informar el dato correspondiente al filtro seleccionado\n     		    o dejar en blanco la condición\n\n                                         		       G R A C I A S")
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
