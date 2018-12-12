<%@ Language=VBScript %>
<%  Response.Buffer = true %>
<link REL="stylesheet" TYPE="text/css" HREF="HITEPIMA.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/FUNCIONfmodelo.ASP"-->
<script>
var aTallas = Array()
var pasacolor = ""
</script>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	coD = Request.QueryString("cod")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CURSORLOCATION   = 3
	RS2.CursorType       = 3 
	RS2.LockType         = 1 
	CAD =	" MODELODETA "  & "'" & COD & "' " 
	rs2.open cad , cnn
	IF RS2.RecordCount > 0 THEN
		RS2.MOVEFIRST
		marka = 1
	else
		marka = 0	
	END IF
	dim LETRAS
	LETRAS="ABCDEFGHIJKLMNOPQRSTUVWXYZ"%>
<HTML>
<HEAD>
<title>DETALLE DE PRENDAS</title>
</HEAD>
<BODY bgColor="White" text="#009999" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form id=thisForm method=post name=thisForm action='comun/inserFichamodelo.asp'>
<table border  =0 cellpadding="0" cellspacing="0" width=100%>
	<tr valign="center" > 
		<td>
			<img src="imagenes/CERRAR.gif" 
				style="cursor:hand;" 
				onclick="CERRAR()">
		</TD>		
      <td bgcolor="#ffffff" align = center>
		<b> <font color="#003399" size="3" Face=arial> 
		<INPUT TYPE="hidden" ID="DCL" name="DCL" VALUE='<%=dcl%>'>
        <input type="HIDDEN" id="codPrenda" name="codPrenda" value="<%=REQUEST.QueryString("cod")%>">
		<%if marka = 0 then%>
			<INPUT TYPE=hidden iD=COD name=COD >
			<INPUT TYPE=hidden ID=CLI name=CLI>
			<script>
				if(parseInt('<%=RS2.RecordCount%>')>0)
					{
						document.write(window.opener.window.thisForm.COD.value)
						document.write(window.opener.window.thisForm.DES.value)
						eval("thisForm.COD.value=window.opener.window.thisForm.COD.value")
						eval("thisForm.CLI.value=window.opener.window.thisForm.CLI.value")
					}
			</script>
		<%else%>
			<INPUT TYPE="hidden" iD="COD" name="COD" VALUE="<%=RS2("CODIGO")%>">
			<INPUT TYPE="hidden" ID="CLI" name="CLI" VALUE="<%=RS2("CLIENTE")%>">
			<%=RS2("CODIGO")%>- <%=RS2("DESCRIPCION")%></font></b> 
       <%end if %>
         </td>
		<td  width="35"> 
	<img src="imagenes/DISK.GIF"  border="1" STYLE="cursor:hand;" ALT="GRABA CAMBIOS" ID="GRABA" NAME="GRABA" onClick="VALIDA()">
		</td>
    </tr>
</TABLE>    
<table	border  =1 cellpadding="1" WIDTH=100% cellspacing="1" 
		bgcolor=White bordercolor=SeaGreen bordercolordark=DARKGREEN
		bordercolorlight=LightSeaGreen>
<tr>
	<TD ALIGN=CENTER>
		<font face="arial" size="3" color=RED> <B>
		X
	</TD>	
	<TD COLSPAN=2>
	<font face="arial" size="1" color="#003399"> 
		COLORES</font>
		 <IMG SRC="IMAGENES\HELP.GIF" width=20
				STYLE="CURSOR:HAND;"
				onclick="HELP('help/hlpcoloresarticulo.asp?cli='+thisForm.CLI.value, 99)">
	</TD>
		<%IF MARKA=0 THEN%>
			<input id=TAL CLASS = DATOSCENTER NAME=TAL TYPE=HIDDEN >
			<SCRIPT>
				eval("thisForm.TAL.value=window.parent.opener.window.thisForm.TIPRAT.value")
			</SCRIPT>
		<%ELSE%>
		<input id=TAL CLASS = DATOSCENTER NAME=TAL TYPE=HIDDEN 
		value ='<%=RS2("CODTAL")%>'>
		<%END IF%>
	<%IF MARKA=0 THEN%>
		 <%codtal=Request.QueryString("tal")%>
	<%ELSE%>
		<%codtal = RS2("CODTAL")%>
	<%END IF%>
	<%'response.Write(cODTAL)%>
	<%CAD = "SELECT * FROM TALLAS WHERE TALLAs = '"&codtal&"'"
	'response.Write(cad)
	'RESPONSE.End()
	RS.OPEN CAD, CNN
	RS.MOVEFIRST%>
	<%FOR I=0 TO 9%>		
		<%codt = trim(rs("talla" & i))%>
		<SCRIPT>
			if (aTallas.length > 0)
				aTallas[aTallas.length] = '<%=codt%>'
			else
				aTallas[0]= '<%=codt%>'	
		</SCRIPT>
		<TD WIDTH=5% ALIGN=CENTER >
			<input type=text id='TALLA<%=I%>' name='TALLA<%=I%>'
			<%IF LEN(codt)>0 THEN%>
				value=<%=codt%> 
			<%end if%>	class=talas>
		</TD>
	<%NEXT%>
</TR>		
<%J=0%>
<%'if marka=0 then%>
<%do while not rs2.eof%>
	<%color= trim(rs2("color"))%>
	<TR ID='fila<%=J%>' NAME='fila<%=J%>' style="display:block">
	<td width=1%>
		<input type="hidden" id="h_cke<%=J%>" name="h_cke<%=J%>" value="0">
		
		<input id='CHK<%=J%>' NAME='CHK<%=J%>' VALUE=0 TYPE=CHECKBOX
		onclick="elimina('<%=j%>')">
	</td>
	<TD WIDTH=8%>
		<input	id=COL<%=j%> 
			READONLY SIZE=4 NAME=COL<%=j%>
				CLASS=TEXTOCENTER
			value ='<%=trim(rs2("COLOR"))%>'>
			<%pasacolor = pasacolor +  rs2("color") + " "%>
		</TD>
		<TD WIDTH=20%>
			<INPUT CLASS = TEXTO ID=DESCOL<%=J%> NAME=DESCOL 
			VALUE ='<%=TRIM(RS2("DESCOL"))%>'>
		</TD>
		<%FOR I=0 TO 9%>
			<TD><%dato = MID(LETRAS,I+1,1)%>
			<input	id=CAN<%=j%><%=dato%> NAME=CAN<%=j%><%=dato%> 
				CLASS=TEXTOcenter readonly
				<%'CAN + LETRA + NUMERO DE COLUMNA%>>
			</TD>
		<%NEXT%>	
	</tr>
	<%do while not rs2.EOF and trim(rs2("color"))= trim(color)%>
		<SCRIPT>
			//alert('<%=rs2("descol")%>')
			CAN = '<%=RS2("UNIDADES")%>'
			TALL = '<%=trim(RS2("TALLA"))%>'
			abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
			iy	= '<%=j%>'
			for (f=0; f<aTallas.length-1; f++)
			{	letra = abc.substr(f,1)
				if (trim(aTallas[f])== trim(TALL))
				{	if(CAN == 0)
					{	CAN = ''	}
					else
					if ('<%=rs2("unidad")%>'=='DD')	
					{	CAN = decidoce(CAN)				}
					else
					{	CAN = FormatNumber(CAN,0,false,false,true,false)	}
					eval("thisForm.CAN"+iy+letra+".value=CAN")
					break;	
					letra=''
				}
				letra=''
			}
		</SCRIPT>
		
		<%rs2.MoveNext%>
		<%if rs2.EOF then 
			exit DO
		end if%>
	<%loop%>
	<%J=J+1%>
	<%if rs2.EOF then 
		exit DO
	end if%>
<%loop%>
<%'end if%>
<%'**********************************************************%>
<%'       COLOCAR FILAS OCULTAS PARA COLORES EXTRA ...       %>
<%'**********************************************************%>
<input id=MARCADOR name=MARCADOR VALUE ='<%=J%>' TYPE = HIDDEN>
<%for jj = j to j+19%>
<TR ID='fila<%=jJ%>' NAME='fila<%=jJ%>' style="display:none">
	<td width=1%>
	<input type="hidden" id="h_cke<%=jj%>" name="h_cke<%=jj%>" value="0">
		<input id='CHK<%=jj%>' NAME='CHK<%=jj%>' VALUE="0" TYPE=CHECKBOX		
		onclick="elimina('<%=jj%>')">
	</td>
	<TD WIDTH=8%>
		<input	id=COL<%=jj%> 
			READONLY SIZE=4 NAME=COL<%=jj%>
				CLASS=TEXTOCENTER>
		</TD>
		<TD WIDTH=20%>
			<INPUT CLASS = TEXTO ID=DESCOL<%=jJ%> NAME=DESCOL >
		</TD>
		<%FOR I=0 TO 9%>
			<TD><%dato = MID(LETRAS,I+1,1)%>
			<input	id=CAN<%=jj%><%=dato%> NAME=CAN<%=jj%><%=dato%> 
				CLASS=TEXTOcenter readonly
				<%'CAN + LETRA + NUMERO DE COLUMNA%>>
			</TD>
		<%NEXT%>
	</tr>
<%next%>
</table> 
<input id=TOPE name=TOPE type = hidden value='<%=JJ-1%>'>

<input id=pasacolor name=pasacolor type = hidden value='<%=pasacolor%>'>
<SCRIPT>
function HELP(pag, POS)
{	
	pag = pag + '&marca=1'
	pag = pag + '&pos=' + POS
	pag = pag + '&DCL=' + '<%=DCL%>'
	if (POS == 99)
	{	
		pag = pag + '&CCC=' + 	thisForm.pasacolor.value 
	}
	var opc = "directories=no,height=400," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=yes,titlebar=no,toolbar=no," ;
	opc = opc + "width=400";
 window.open(pag,'HELP',opc)
 
}
function CERRAR()
{	window.close()
}
function elimina(pos)
{	abc= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	for (o=0; o<10; o++)
	{	letra = abc.substr(o,1)
		if(isNaN(parseFloat(eval("thisForm.CAN"+pos+letra+".value")))== false)
		{	if (parseFloat(eval("thisForm.CAN"+pos+letra+".value"))>0 )
			{	alert("No puede eliminar un color que tiene Stock")
				eval("thisForm.CHK"+pos+".checked=false")
				return true;
			}	
		}	
	}
	eval("thisForm.h_cke"+pos+".value=1")
	eval("thisForm.CHK"+pos+".checked=true")
}
function VALIDA()
{	aColor = Array()
	aCant = Array()
	aColor[0] = thisForm.COL0.value
	aCant[0] = 1
	if (aColor[0]== '')
	{	alert('Debe informar por lo menos un COLOR por artículo')
		HELP('help/hlpCOLORESARTICULO.asp?cli='+thisForm.CLI.value, 0)
		return false;
	}
	for (i=3;i<37; i+=3)
	{	for(j=0; aColor.lenght; j++ )
		{	if (eval("thisForm.COL"+i+".value")== aColor[j]) 
			alert('Código de Color Duplicado, REVISE')
			return false;
		}
	}
	thisForm.action='comun/inserfichamodelo.asp'
	//alert("submit")
	thisForm.submit();
}



</SCRIPT>
	<%RS.CLOSE%>
</form>
</BODY>
</HTML>