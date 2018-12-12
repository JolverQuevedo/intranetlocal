<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	'RESPONSE.Write(nivel)
%>
<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=1;
var url = '../TELARUTAHEAD.asp?COD='
var alias = 'TELARUTAHEAD'
var TBL = 'TELARUTAHEAD'
var PK  = 'TELA'
var DS  = ''
var largo = 1
var largo2 = 25
chk = ''
var oldrow=1

function VALIDA()
{	
	if (trim(thisForm.DES.value) == "" )
	{	alert('Debe Informar el Nombre/Cliente de la Ruta');
		window.thisForm.DES.focus();
		return false;
	}		
	return true;
}
function achica() {
    window.resizeTo(500, 500)
window.moveTo(0,0)
}
function PRN() {
    cad = 'reportes/prnRUTATELA.asp?tel=' + '<%=TRIM(Request.QueryString("COD"))%>'
    cad += '&rut=' + trim(thisForm.VER.value)
    var opc = "directories=no,height=500,";
    opc = opc + "hotkeys=no,location=no,";
    opc = opc + "menubar=yes,resizable=YES,";
    opc = opc + "left=0,top=0,scrollbars=yes,";
    opc = opc + "status=no,titlebar=no,toolbar=no,";
    opc = opc + "width=700";
    window.open(cad, "RUTA_TINTORERIA", opc)
}



</script> <%
'****************************************
' Definir el tamaño de la pagina
'****************************************
Dim pageSize 
if nivel > 1 then
	pageSize = 16
else
	pageSize = 6
end if
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "TELARUTAHEAD"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "VERSION"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "TELARUTAHEAD.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "RUTAS PARA TELA:"
%>
<script type="text/jscript" language="jscript">


// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERTELARUTAhead.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script> 
<%	
	DEK = Request.QueryString("DEK")
	TEL = Request.QueryString("COD")
	VER = Request.QueryString("VER")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************

CAD =	" SELECT  TELA, VERSION,		" & _
		" DESCRIPTOR, VOLTEADO, LAVAPANO" & _
		" FROM     "&alias&" 			" & _
		" WHERE ESTADO = 'A' and		" & _
		" TELA = '"&TEL&"'				" & _
        " ORDER BY "& indice &"  		" 
		'	" AND TELAS.ESTADO = 'A' " & _ 
		'RESPONSE.Write(CAD)
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body onload="achica()">


<form name="thisForm" id="thisForm" method="post" action="TELARUTAHEAD.asp">
<input id="TEL" name="TEL" value = '<%=TEL%>'  type="hidden">
<table width="100%">
	<tr><td width="5%">
		<img src="imagenes/CERRAR.gif" 	style="cursor:hand;" onClick="javascript: window.close();" />
		</td>
		<td align="center"><font face="arial" size="3" color='<%=(Application("titulo"))%>' ><b><%=titulo%> <%=trim(TEL)%><br /></b></font>
		<font face="arial" size="1" color='<%=(Application("resalte"))%>' ><b><%=DEK%></b></font>
		</td>
		<td align="right" width="5%">
		  	<img src="imagenes/logo.GIF" alt="" />
		  </td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNtelarutahead.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		response.Write("<font color=navy>")
		RESPONSE.Write("TABLA SIN DATOS")	
		SINDATOS =0
		'RESPONSE.End()%>
		<script type="text/jscript" language="jscript">
		var	tela = trim(window.opener.window.thisForm.COD.value)
	//	var	descripcion = ltrim(window.opener.window.thisForm.TELA.value)
		thisForm.TEL.value=tela
	</script>
	<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>

<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%	LIMITE =  rs.fields.count - 1 %>
<%for I=1 to LIMITE %>
	<td align="center">
		<font face="arial" color="IVORY" size="1">
		<b><%=RS.FIELDS(I).NAME%></b>
		</font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
    <tr bgcolor="<% if CONT mod 2  = 0 THEN 
		response.write(Application("color1"))
		else
		response.write(Application("color2"))
		end IF%>"
		onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  onDblClick="fichita()">
	<%for i=1 to LIMITE%>
		<td width="5%">
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=RS.FIELDS.ITEM(I)%></b>&nbsp;
			</font>
		</td>
	  <%NEXT%>	

	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
    
	<%loop%>
</table>
<%END IF %>
<BR>
<input id="CHK" name="CHK" value="0" type="hidden">
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
<table	width="100%" border="0" id="DATAENTRY"  style="display:block;">
   <tr>
   		<td>
            <table	align="center" width="100%" cellpadding="1" cellspacing="0"  bgcolor="<%=(Application("COLOR2"))%>" border="1" >
              <tr valign="middle"> 
                <td width="3%" bgcolor="<%=(Application("barra"))%>" align= "right" class="TEXTOblue">VER :</td>
                <td bgcolor="WHITE" width="3%" valign="middle"><input type="text" id="VER" name="VER" class="barra3"  readonly="readonly" /></td>
                <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="TEXTOblue">DESCRIPCION :</td>
                	<td bgcolor="#FFFFFF" WIDTH="50%" ><input type="text" id="DES" name="DES" class="BARRA3" onBlur="this.value=toAlpha(this.value)" /></td>
              	 <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right"class="TEXTOblue">VOLTEADO? :</td>
                <td bgcolor="WHITE" width="10%" valign="middle"><select id="VOL" name="VOL" class="TEXTOblue">
                    <option value='0'>NO</option>
                    <option value='1'>SI</option>
                </select>
                </td>
                <td width="10%" bgcolor="<%=(Application("barra"))%>" align="left" class="TEXTOblue">LAV. PA&Ntilde;O? :</td>
                <td bgcolor="#FFFFFF" colspan="3" WIDTH="10%"><select id="LAV" name="LAV"  style="width:100%" class="TEXTOblue">
                    <option value='0'>NO</option>
                    <option value='1'>SI</option>
                </select>
                </td>
              </tr>
            </table>
         </td>   
        </tr>
        
        
        <tr>
        <td>
<table border="0" align="center"  cellspacing="3">
    <tr>
        <td id="a"><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO" onClick="NUEVO_onclick()" style="cursor:hand;" /></td>
        <td id="b"><img src="imagenes/DISK.gif" alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:hand;" /></td>		
        <td id="c"><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:hand;" /></td>		
        <td style="display:block"><img src="imagenes/PRINT.gif" alt="IMPRIMIR RUTA" onClick="PRN()" style="cursor:hand;" /></td>		
        <td id="d"><img src="imagenes/protover.jpg" alt="COPIAR RUTA" onClick="COPIA()" style="cursor:hand;" /></td>		
    </tr>
</table>
</td>
</tr>
</table>
<script type="text/jscript" language="jscript">
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
{	ver = trim('<%=ver%>')
	if (ver != '')
		dd2(ver);
	else	
		dd2('1');
}

function COPIA() {
    document.all.ACTIV.style.visibility = 'visible'
    document.all.ACTIV.height = "100"
    document.all.ACTIV.width = "110%"

cad = 'copiarutatela.asp?tel=' + '<%=tel%>'+'&ver='+trim(document.all.VER.value)

document.all.ACTIV.src=(cad)

}

function fichita() {
nivel = parseInt('<%=nivel%>',10)
if (nivel == 1)
    window.open('ficharutatelas.asp?tel=' + trim(thisForm.TEL.value) + '&rut=' + trim(thisForm.VER.value) + '&des=' + ltrim(thisForm.DES.value))
}
</script>    
<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("DATAENTRY.style.display='block'");
		thisForm.VER.maxLength=largo
		thisForm.DES.maxLength=largo2
		if (rec <= 0)
		{  NUEVO_onclick()
		    SS = trim('<%=SINDATOS%>')
		    if (SS == "1")
		    {thisForm.kod.maxLength=largo
		    thisForm.ds.maxLength=largo2
		    }
		}    
	</script>
<%else%>
	<script type="text/jscript" language="jscript">
	    document.all.a.style.display = 'none';
	    document.all.b.style.display = 'none';
	    document.all.c.style.display = 'none';
	    document.all.d.style.display = 'none';
    </script>
<%END IF %>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
