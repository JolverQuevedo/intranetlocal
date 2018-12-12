<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link rel="stylesheet" type="text/css" href="../estilos1.CSS" />
<head>
<title></title>
<script id="clientEventHandlersJS" language="javascript" type="text/jscript">
<!--
var letras = "ABCDEFGHIJKLMNOPQRSTUWXYZ"
menuImages = new Array(7)
menuImages[0] = new Image()
menuImages[0].src = "../imagenes/blanco.GIF"
menuImages[1] = new Image()
menuImages[1].src = "../imagenes/Pteje.gif"
menuImages[2] = new Image()
menuImages[2].src = "../imagenes/Cteje.gif"
menuImages[3] = new Image()
menuImages[3].src = "../imagenes/Pnoteje.gif"
menuImages[4] = new Image()
menuImages[4].src = "../imagenes/Cnoteje.gif"
menuImages[5] = new Image()
menuImages[5].src = "../imagenes/Pretiene.gif"
menuImages[6] = new Image()
menuImages[6].src = "../imagenes/Cretiene.gif"
var linA = Array(37)
var linB = Array(37)
var linC = Array(37)
var linD = Array(37)
var linE = Array(37)
var linF = Array(37)
var linG = Array(37)
var linH = Array(37)
var linI = Array(37)
var linJ = Array(37)
var linK = Array(37)
var linL = Array(37)

for (i=1; i<37;i++)
{	linA[i]	= 0
	linB[i]	= 0
	linC[i]	= 0
	linD[i]	= 0
	linE[i]	= 0
	linF[i]	= 0
	linG[i]	= 0
	linH[i]	= 0
	linI[i]	= 0
	linJ[i]	= 0
	linK[i]	= 0
	linL[i]	= 0
}
function CAMBIA(pos, LETRA, ID, xx)
{	matriz= eval("lin"+LETRA)
	LETRAS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	loc = eval("thisForm." + ID + LETRA+  pos )
	HID = eval("thisForm.LP" + LETRA +  pos )
	ubi = parseFloat(matriz[pos]) +1
	//alert("thisForm." + ID +  pos + LETRA)
	if (ubi > 6)
		ubi = 0
	matriz[pos] = ubi
	loc.src=menuImages[ubi].src; 
	loc.value = ubi
	HID.value = ubi

	xx=parseInt(xx,10)
	LET = LETRAS.slice(xx+1, xx+2)
	if (xx < 11)
	{eval(LET+".style.display='block'")}
}
function window_onafterprint() {
ppp.style.display='block'
}
function window_onbeforeprint() {
ppp.style.display='none'
}
//-->
</script>
    <style type="text/css">
        .style1
        {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            FONT-SIZE: 10px;
            COLOR: navy;
            FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
            font-weight: bold;
            height: 16px;
        }
        .style2
        {
            FONT-FAMILY: Tahoma, Geneva, sans-serif;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            FONT-SIZE: 10px;
            COLOR: black;
            FONT-FAMILY: Arial;
            height: 16px;
        }
    </style>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">

<% dim aCol
aCol = Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")%>
<%  aPunto= Array()
redim preserve aPunto(ubound(aPunto)+1)
aPunto(ubound(aPunto))= " " 
cad = "select * from puntadas"
rs.open cad , cnn
if rs.recordcount > 0 then
	rs.movefirst
	do while not rs.eof
		redim preserve aPunto(ubound(aPunto)+1)
		aPunto(ubound(aPunto)) = rs("codigo")
		rs.movenext
	loop	
end if
rs.close


tel = Request.QueryString("tel")
RUT = Request.QueryString("RUT")
cad=	" SELECT TELAS.TELA AS TEL, TELAS.DESCRIPCION AS DESTEL, TRH.DESCRIPTOR AS CLIENTE,         			" & _
        " convert(smalldatetime, TELAS.FECHA, 113 ) as fecha, TELAS.PESOCRU,  TEJEDORAS.AGUJAS,     			" & _
        " TEJEDORAS.DESCRIPCION AS MAQUINA, TEJEDORAS.DIAMETRO, TEJEDORAS.GALGA, TEJEDORAS.ALIMENTA,			" & _
        " TELAS.LM1, TELAS.LM2, TELAS.LM3, TELAS.ANCHCRU, PESOLAV, TELAS.pesoaca, TEJEDORAS.SISTEMAS,        	" & _
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN 'ABIERTA'  ELSE 'TUBULAR' END AS TIPORUTA,           		" & _
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN TELAS.ANCHABI  ELSE TELAS.ANCHTUB END AS ANCHOACA,   		" & _
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN TELAS.ANCHABILAV  ELSE TELAS.ANCHTUBLAV END AS ANCHOLAV,  " & _		
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN TELAS.RENDABI  ELSE TELAS.RENDTUB END AS RENDIMIENTO,		" & _
        " CASE WHEN RENTTLAV IS NULL THEN TELAS.RENTALAV  ELSE TELAS.RENTTLAV END AS RENLAV,  trh.lavapano,  	" & _
        " CURZALAV, COLLAV, MM.DESCRIPCION AS MODMAQ, TELAS.REVIRADO,COLUMNAS, TRH.VERSION AS RUTA, 			" & _
        " TELAS.TOLMIN, TELAS.TOLMAX, TELAS.ENCABI1, TELAS.ENCLAR1, TELAS.CURZAS, TELAS.INCACA, trh.VOLTEADO,   " & _
        " TELAS.enclar2, TELAS.enclar3, TELAS.eNCABI2, TELAS.ENCABI3,  TELAS.RENDTUB, ANCHABi, telas.foto,		" & _
        " MARCATEJ.DESCRIPCION as marca,  LTRIM(RTRIM(TIPTEL.DESCRIPCION)) AS TIPTEL, ANCHTUB,     				" & _
        " ENCLLAV1 as ell1, ENCLLAV2 as ell2, ENCLLAV3 as ell3, ENCALAV1 as eal1, ENCALAV2 as eal2, ENCALAV3 as eal3, REVLAV as revl, INCDLAV as ddll " & _
        " FROM TELAS                                           				                                    " & _
        " INNER JOIN TEJEDORAS ON TELAS.MAQUINA = TEJEDORAS.CODIGO          			                        " & _
        " INNER JOIN MARCATEJ ON TEJEDORAS.MARCA = MARCATEJ.CODIGO                      			            " & _ 
        " INNER JOIN MODMAQ MM ON TEJEDORAS.MODELO = MM.CODIGO                                      			" & _
        " INNER JOIN TELARUTAHEAD TRH ON TRH.TELA = TELAS.TELA				                                    " & _
        " INNER JOIN TIPTEL ON TELAS.TIPOTELA = TIPTEL.CODIGO	            			                		" & _
		" WHERE (TELAS.TELA = '"&TEL&"') and (TRH.version = '"&RUT&"')	                			            " 
		'	REsponse.Write(CAD)
		'REsponse.End
RS.OPEN CAD,CNN		
if rs.recordcount> 0 then	
	RS.MOVEFIRST
else
	Response.Write("<center>")
	Response.Write("<font face = arial size=3 color = red>")
	
	Response.Write("<B>")
	Response.Write("<br>")
	Response.Write("<br>")
	Response.Write("<br>")
	Response.Write("Este Artículo no tiene datos para Imprimir")
	Response.Write("<br>")
	Response.Write("<br>")
	Response.Write("R E V I S A R... si tiene alguna RUTA definidas")
	Response.end
end if 		
RS.MOVEFIRST
foto=trim(rs("foto"))
%>
<body class="datos" onafterprint="return window_onafterprint()" onbeforeprint="return window_onbeforeprint()">

<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="<%=application("color2")%>" >
<tr >
	<td width="3%" align="right" valign="top" height="180"><img src="../imagenes/modelador-head2.jpg"></td>
    <td  width="20%" class="american22" align="right"><br />EL MODELADOR S.A.<br /><br /><br /><br />
    <span class="TEXTOminibb">Calle Capitan Salvador Carmona 280
    <br />Lot. Ind. S.R. La Molina - Ate <br />
          e-Mail: sales@elmodelador.com.pe<br />
          Phone: (511)348-8180/348-6936<br />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;348-9467/348-1380<br />
          Fax: (511)348-6182</span></td>	 
	<td width="80%" align="center"  class="TALASBLUE">FICHA TECNICA DE TELA: 
		<%=TEL%> - RUTA <%=RUT%></td>		
	<td width="5%" ><img id="ppp" style="cursor:hand;" onClick="window.print();" src="../imagenes/PRINT.gif" alt="" /></td>
</tr>
</table>


<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
  <tr><td class="AMERICANwhite"> DATOS GENERALES :</td></tr>
</table>


<table width="100%" border="0" cellspacing="1" cellpadding="1"
		bordercolor="<%=application("color2")%>" bordercolorlight="<%=application("barra")%>">
  <tr valign="middle"> 
    <td  align="right" width="5%"  bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Cliente</td>
    <td width="50%" colspan="4" class="DESCRIPTORnegro">
		 <%=trim(rs("cliente"))%>
    </td>
    <td  align="right" width="5%"  bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Partida</td>
    <td width="10%" class="DESCRIPTORnegro">&nbsp;
		 
	</td>
    <td  align="right" width="2%"  bgcolor="<%=application("barra")%>"  class="AMERICANnavy">O/P</td>
    <td width="20%" class="DESCRIPTORnegro">&nbsp;</td>
    <td  align="right" width="1%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Fecha</td>
    <td width="10%" class="DESCRIPTORnegro">
		 <%=day(RS("FECHA"))%>/<%=month(RS("FECHA"))%>/<%=year(RS("FECHA"))%>
    </td>
  </tr>
  <tr> 
    <td width="5%" bgcolor="<%=application("barra")%>" class="style1">Descripcion
    </td>
    <td colspan="10" class="style2"> <%=TRIM(RS("destel"))%></td>
  </tr>
  <tr><td colspan="11" height="5"></td></tr>
</table>  



<%CAD =	" SELECT T.TELA, T.DESCRIPCION,																			" & _
				" T.HIL1, T.POR1 AS [%1], M1.DESCRIPCION AS F1, H1.DESCRIPCION AS DES1, 								" & _
				" T.HIL2, T.POR2 AS [%2], M2.DESCRIPCION AS F2, H2.DESCRIPCION AS DES2,  								" & _
				" T.HIL3, T.POR3 AS [%3], M3.DESCRIPCION AS F3, H3.DESCRIPCION AS DES3, 								" & _
				" T.HIL4, T.POR4 AS [%4], M4.DESCRIPCION AS F4, H4.DESCRIPCION AS DES4,  								" & _
				" T.HIL5, T.POR5 AS [%5], M5.DESCRIPCION AS F5, H5.DESCRIPCION AS DES5, 								" & _
				" T.HIL6, T.POR6 AS [%6], M6.DESCRIPCION AS F6, H6.DESCRIPCION AS DES6,  								" & _
				" CAST(CAST(SUBSTRING(H1.TITULO,1,3) AS INT) AS CHAR(3))+'/'+ SUBSTRING(H1.TITULO,4,1) AS TIT1, 		" & _
				" CAST(CAST(SUBSTRING(H2.TITULO,1,3) AS INT) AS CHAR(3))+'/'+ SUBSTRING(H2.TITULO,4,1) AS TIT2, 		" & _
				" CAST(CAST(SUBSTRING(H3.TITULO,1,3) AS INT) AS CHAR(3))+'/'+ SUBSTRING(H3.TITULO,4,1) AS TIT3,			" & _
				" CAST(CAST(SUBSTRING(H4.TITULO,1,3) AS INT) AS CHAR(3))+'/'+ SUBSTRING(H4.TITULO,4,1) AS TIT4, 		" & _
				" CAST(CAST(SUBSTRING(H5.TITULO,1,3) AS INT) AS CHAR(3))+'/'+ SUBSTRING(H5.TITULO,4,1) AS TIT5,			" & _
				" CAST(CAST(SUBSTRING(H6.TITULO,1,3) AS INT) AS CHAR(3))+'/'+ SUBSTRING(H6.TITULO,4,1) AS TIT6 			" & _
				" FROM TELAS AS T 													 									" & _
				" INNER JOIN HILADO AS H1 ON T.HIL1 COLLATE DATABASE_DEFAULT = H1.HILO COLLATE DATABASE_DEFAULT			" & _
				" LEFT OUTER JOIN HILADO AS H2 ON T.HIL2 COLLATE DATABASE_DEFAULT = H2.HILO COLLATE DATABASE_DEFAULT	" & _
				" LEFT OUTER JOIN HILADO AS H3 ON T.HIL3 COLLATE DATABASE_DEFAULT = H3.HILO COLLATE DATABASE_DEFAULT	" & _
				" LEFT OUTER JOIN HILADO AS H4 ON T.HIL4 COLLATE DATABASE_DEFAULT = H4.HILO COLLATE DATABASE_DEFAULT	" & _
				" LEFT OUTER JOIN HILADO AS H5 ON T.HIL5 COLLATE DATABASE_DEFAULT = H5.HILO COLLATE DATABASE_DEFAULT	" & _
				" LEFT OUTER JOIN HILADO AS H6 ON T.HIL6 COLLATE DATABASE_DEFAULT = H6.HILO COLLATE DATABASE_DEFAULT 	" & _
				" INNER JOIN MATERIA AS M1 ON H1.FIBRA = M1.CODIGO 														" & _
				" LEFT OUTER JOIN MATERIA AS M2 ON H2.FIBRA = M2.CODIGO													" & _
				" LEFT OUTER JOIN MATERIA AS M3 ON H3.FIBRA = M3.CODIGO													" & _
				" LEFT OUTER JOIN MATERIA AS M4 ON H4.FIBRA = M4.CODIGO													" & _
				" LEFT OUTER JOIN MATERIA AS M5 ON H5.FIBRA = M5.CODIGO													" & _
				" LEFT OUTER JOIN MATERIA AS M6 ON H6.FIBRA = M6.CODIGO 												" & _
				" WHERE T.TELA ='"&TEL&"'  																				" 
		'REsponse.Write(CAD)
		'Response.end
	Set RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.ActiveConnection = Cnn
		RS2.CursorType       = 3 'CONST adOpenStatic = 3
		RS2.LockType         = 1 'CONST adReadOnly = 1
RS2.Open CAD,CNN
%>

<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite">DATOS DE HILADO:</td></tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="1" bordercolor="<%=application("color2")%>" bordercolorlight="<%=application("barra")%>">
<tr> 
  <td width="10%"   bgcolor="<%=application("barra")%>"   class="AMERICANnavy">Titulo</td>
  <td width="5%" align="center"  bgcolor="<%=application("barra")%>"   class="AMERICANnavy">%</td>
  <td width="85%"  bgcolor="<%=application("barra")%>"   class="AMERICANnavy">Fibra</td>
</tr>  
<%
vont = 1
    FOR I=1 TO 6%>
	<%CAD = "HIL" + TRIM(I) %>
<%IF LTRIM(RTRIM(RS2(CAD))) <> "" THEN%>	
		<tr  <%if vONT mod 2  = 0 then%>
	 bgcolor="<%=application("color1")%>"
		<%end if%>	> 
		  <td width="10%" align="center" class="DESCRIPTORnegro"><%=trim(RS2("TIT"&I))%></td>
		  <td width="5%" align="center" class="DESCRIPTORnegro"><%=RS2("%"&I)%> %</td>
		  <td width="85%" class="DESCRIPTORnegro"><%=RS2("F"&I)%></td>		 
		</tr>
		<%vont= vont + 1 %>
	<%END IF%>
<%NEXT%>
<%rs2.close%>
		
</table>

<table width="100%"  border="1" cellspacing="1" cellpadding="2"  bordercolor="<%=application("color1")%>"
 bordercolorlight="<%=application("COLOR1")%>" align="left">
<tr bgcolor="<%=application("titulo") %>">
    <td width="49%" class="AMERICANwhite" colspan="4"> CARACTERISTICAS DE ACABADO:</td>
    <td width="2%" bgcolor="<%=application("color1")%>"></td>
    <td width="49%" class="AMERICANwhite"  colspan="4"> CARACTERISTICAS DE MAQUINA:</td>
</tr>
<tr>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Densidad BW</td>
    <td width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("pesoACA")%> Gr/m2</td>
    <td width="10%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Ancho</td>
    <td width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ANCHOACA")%> Mts</td>
    <td width="2%"  bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro">&nbsp;</td>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Tipo de Máquina</td>
    <td width="30%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" colspan="3"><%=rs("MODMAQ")%></td>
</tr>
<tr>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy"> Largo Malla</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("lm1")%></td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("lm2")%></td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("lm3")%></td>
    <td width="2%"  bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro">&nbsp;</td>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Galga</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("galga")%></td>
    <td width="10%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Diámetro</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("diametro")%>"</td>
</tr>
<tr>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">&nbsp; </td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%'=rs("lm1")%></td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%'=rs("lm2")%></td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%'=rs("lm3")%></td>
    <td width="2%"  bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro">&nbsp;</td>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy"># Agujas</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("agujas")%></td>
    <td width="10%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy"># Sistemas</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("sistemas")%></td>
</tr>
<tr><td colspan="9" height="6"></td></tr>
<tr>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy"> RUTA : </td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("tiporuta")%></td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%'=rs("lm2")%></td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%'=rs("lm3")%></td>
    <td width="2%"  bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro">&nbsp;</td>
    <td width="18%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Volteado</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%if rs("volteado")="0" then%> NO<%else%>SI<%end if%></td>
    <td width="10%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Lav. paño</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%if rs("LAVAPANO")="0" then%> NO<%else%>SI<%end if%></td>
</tr>


<tr>
<td colspan ="9">
<table width="100%"  border="1" cellspacing="1" cellpadding="2"  bordercolor="<%=application("color1")%>"
 bordercolorlight="<%=application("COLOR1")%>" align="left">
<tr bgcolor="<%=application("titulo") %>">
<td class="AMERICANwhite"  colspan="4"> ESTABILIDAD DIMENSIONAL ACABADO :</td>
<td width="52%" rowspan="5"  bgcolor="<%=application("color2") %>" boder="0">&nbsp;</td>
</tr>
<tr align="center">
   <td width="12%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">% Encojimiento</td>
    <td width="12%" bgcolor="<%=application("BARRA")%>" class="AMERICANnavy">1 Lav.</td>
    <td width="12%" bgcolor="<%=application("BARRA")%>" class="AMERICANnavy">2 Lav. </td>
    <td width="12%" bgcolor="<%=application("BARRA")%>" class="AMERICANnavy">3 Lav.</td>
</tr>
<tr align="center">
    <td width="12%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Largo</td>
    <td align="center" width="10%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ENCLAR1")%> %</td>
    <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ENCLAR2")%> %</td>
    <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ENCLAR3")%> %</td>
      
</tr>
<tr align="center">
    <td width="21%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Ancho</td>
    <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ENCabi1")%> %</td>
    <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ENCabi2")%> %</td>
    <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ENCabi3")%> %</td>
</tr>
<tr>
 <td width="12%" bgcolor="<%=application("barra")%>"  align="center" class="AMERICANnavy">Revirado </td>
 <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("revirado")%> %</td>
  <td width="12%" bgcolor="<%=application("barra")%>"  align="center" class="AMERICANnavy">Inclinación </td>
 <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("incaca")%> %</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="9">
<table width="100%"  border="1" cellspacing="1" cellpadding="2"	bordercolor="<%=application("color1") %>" align="left">
<tr bgcolor="<%=application("titulo") %>">
<td class="AMERICANwhite" colspan="5"> SECUENCIA DE PROCESOS:</td>
</tr>
<tr bgcolor='<%=application("barra")%>'>
		<td width="3%" class="AMERICANnavy">ITEM</td>
		<td width="4%" class="AMERICANnavy">CODIGO</td>
		<td width="35%" class="AMERICANnavy">SERVICIO</td>
		<td width="7%" class="AMERICANnavy">% M</td>
		<td width="45%" class="AMERICANnavy">PROVEEDOR</td>
  </tr>
<%cad = " SELECT tela, servicio AS codigo,	merma, 	 " & _
		" opc, DESCRIPCION FROM TELARUTADETA	 " & _
		" INNER JOIN SERVICIOS ON SERVICIO = CODIGO	 " & _
		" WHERE TELA = '"&TEL&"' and version = '"&RUT&"'	 " & _
		" ORDER BY TELA DESC, opc, CODIGO			 "
		
'Response.Write(CAD)
'REsponse.end
rs2.Open cad,cnn
if rs2.RecordCount > 0 then
rs2.MoveFirst
CONT =1
%>  
<%do while not rs2.eof%> 
  <tr <%if CONT mod 2  = 0 then%>
	 bgcolor="<%=application("color1")%>"
		<%end if%>	>
			<td align="center" class="DESCRIPTORnegro"><%=rs2("opc")%></td>
    <td align="center" class="DESCRIPTORnegro"><%=rs2("codigo")%></td>
    <td align="center" class="DESCRIPTORnegroIZQ"><%=ucase(rs2("descripcion"))%></td>
    <td align="center" class="DESCRIPTORnegro"><%=rs2("merma")%>&nbsp;</td>
    <td align="center" class="DESCRIPTORnegro"><%'=TRIM(rs2("merma"))%>&nbsp;</td>
  </tr>
  <%rs2.MoveNext%>
  <%CONT = CONT +1 %>
<%loop%> 
  
<%end if
rs2.Close
%>  
</table>
</td>
</tr>


<tr>
<td colspan="9">
<table width="100%"  border="1" cellspacing="1" cellpadding="2"  bordercolor="<%=application("color1")%>" 
bordercolorlight="<%=application("COLOR1")%>" align="left">
<tr bgcolor="<%=application("titulo") %>">
<td class="AMERICANwhite" colspan="4"> CARACTERISTICAS DE ENCOGIMIENTO RESIDUAL:</td>
<td width="50%" rowspan="1"  bgcolor="<%=application("color2")%>" >&nbsp;</td>
</tr>
<tr>
<td width="12%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Densidad </td>
    <td width="11%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("pesoLAV")%> Gr/m2</td>
    <td width="12%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Ancho</td>
    <td width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("ANCHOLAV")%> Mts</td>
</tr>
</tr>
<td width="12%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Mts/Kgs AW </td>
    <td width="12%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Cursas "</td>
    <td width="12%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Columnas "</td>
</tr>
<tr>
 <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%'=rs("ENCabi1")%> </td>
    <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("curzalav")%> </td>
    <td align="center" width="12%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs("collav")%></td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="9">
<table width="100%"  border="1" cellspacing="1" cellpadding="2"  bordercolor="<%=application("color1")%>"
 bordercolorlight="<%=application("COLOR1")%>" align="left">
<tr bgcolor="<%=application("titulo") %>">

<td width="49%" class="AMERICANwhite" colspan="3"> Encogimiento Largo:</td>
<td width="2%" bgcolor="<%=application("color1")%>"></td>
<td width="49%" class="AMERICANwhite"  colspan="5"> Encogimiento Ancho:</td>
</tr>
<tr valign="center"> 
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="AMERICANnavy"> Lavada # 1</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="AMERICANnavy"> Lavada # 2</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="AMERICANnavy"> Lavada # 3</span></td>
      <td width="2%"  bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro">&nbsp;</td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="AMERICANnavy"> Lavada # 1</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" width="10%" align="center"><span class="AMERICANnavy"> Lavada # 2</span></td>
      <td align="center" bgcolor="<%=(Application("BARRA"))%>" width="10%"><span class="AMERICANnavy"> Lavada # 3</span></td>
      <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="AMERICANnavy">% Revirado</span></td>
       <td bgcolor="<%=(Application("BARRA"))%>" align="center" width="10%"><span class="AMERICANnavy">Inclinaci&oacute;n</span></td>
  </tr>
  <tr>              
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("ELL1")%></td>	
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("ELL2")%></td>	
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("ELL3")%></td>
   <td width="2%"  bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro">&nbsp;</td>
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("EAL1")%></td>	
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("EAL2")%></td>	
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("EAL3")%></td>	  
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("REVL")%></td>	
   <td align="center" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro" > <%=rs("DDLL")%></td>	     
 </tr>
</table>
</td>
</tr>

<tr>
<td colspan="9">
<table width="100%"  border="1" cellspacing="1" cellpadding="2"  bordercolor="<%=application("color1")%>"
 bordercolorlight="<%=application("COLOR1")%>" align="left" >
<tr bgcolor="<%=application("titulo") %>">
<td width="49%" class="AMERICANwhite" colspan="4"> OBSERVACIONES:</td>
<td width="2%" bgcolor="<%=application("color1")%>"></td>
<td width="49%" class="AMERICANwhite"  colspan="4"> COMENTARIOS DDP:</td>
</tr>

<%CAD= "SELECT * FROM [TELA-OBS] WHERE TELA = '"&TEL&"' "
RS2.OPEN CAD,CNN
IF RS2.RECORDCOUNT > 0 THEN%>
<tr>
    <td align="left" width="50%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs2("OBSERVACION")%></td>
    <td align="left" width="50%" bgcolor="<%=application("color2")%>" class="DESCRIPTORnegro"><%=rs2("COMENTARIO")%></td>
</tr>
<%END IF %>
</table>
</td>
</tr>

<tr>
<td colspan="9">
<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite">ESPECIFICACIONES TECNICAS PARA EL TEJIDO</td></tr>
<tr>
		<td  bgcolor="<%=application("barra") %>" align="center">
		<span class="AMERICANnavy">LIGADURAS</span>
		</td>
	</tr>
</table>









<form id="thisForm" method="post" action=''>

<table width="100%"  border="0" cellspacing="0" cellpadding="0" bgcolor="<%=application("color1") %>" id="liga" style="display:none">
	
	<tr>
		<td valign="top">
		<table width="100%"  border="1" cellspacing="0" cellpadding="0" bgcolor="<%=application("color2") %>">
			<tr bgcolor="<%=application("resalte") %>">
				<td width="20"></td>
				<%FOR P=1 TO 36%>
					<td align="center" class="AMERICANwhite"><%=P%></td>
				<%NEXT%>
			</tr>
				<%for m=0 to 0%>
				<tr id='<%=aCol(m)%>' name='<%=aCol(m)%>'>
					<td width="20" align="center" bgcolor="<%=application("resalte") %>" class="AMERICANwhite">&nbsp;A&nbsp;</td>
					<%FOR K=1 TO 36%>
					<td align="center"  height="50"	>
						<input id="LP<%=aCol(m)%><%=K%>" name="LP<%=aCol(m)%><%=K%>" type ="hidden" value="0" /><img width="25" id="PLATO<%=aCol(m)%><%=K%>" name="PLATO<%=aCol(m)%><%=K%>"  src="../imagenes/blanco.jpg" alt="" /></td>
					<%NEXT%>
		  </tr>
				<%next%>
				<%letas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"%>
				<%for m=1 to 12%>
				<tr id='<%=aCol(m)%>' style="display:'none'" name='<%=aCol(m)%>'>
					<td width="20" align="center" bgcolor="<%=application("resalte") %>" class="AMERICANwhite">&nbsp;<%=mid(letas,m+1,1)%>&nbsp;</td>
					<%FOR n=1 TO 36%>
					<td align="center"  height="55">		
						<input id="LP<%=aCol(m)%><%=N%>" name="LP<%=aCol(m)%><%=N%>" type="hidden" value="0" />					
						<img  width="25" id="PLATO<%=aCol(m)%><%=n%>"	name="PLATO<%=aCol(m)%><%=n%>" src="../imagenes/blanco.jpg" alt="" />
					</td>
					<%NEXT%>
				</tr>
				<%next%>				
			</table>
		</td>
	</tr>
</table>
</td></tr>
<tr><td>
<table align="center" width="100%"><tr><td align="center">
<img src='../ligaduras/<%=foto%>' name="dibu" width="516" height="328" align="middle" id="dibu" style="display:none" />
</td></tr></table>



<%rs.close
cad =	" SELECT FTL.TELA, FTL.UBI, FTL.LIGADURA,					" & _
	    " LL.DESCRIPCION AS LIGA									" & _
		" FROM FICHATEJELIGA FTL									" & _
		" LEFT OUTER JOIN  LIGADURAS LL ON FTL.LIGADURA = LL.CODIGO	" & _
		" WHERE (FTL.TELA = '"&tel&"')								" 
rs.open cad, cnn
dibujo =""
if rs.RecordCount > 0 then
	RS.MOVEFIRST
	DIBUJO="1"
	do while not rs.eof%>
		<script language="jscript" type="text/jscript">
		//  FILA	:	A ...	L
		//	COLUMNA :	1 ...	36  
			Aa = trim('<%=TRIM(RS("LIGADURA"))%>')
			if (!isNaN(Aa))
			{	Ba = trim('<%=RS("UBI")%>')
				kk = trim('<%=left(RS("UBI"),1)%>')
				Ca = '../imagenes/'+'<%=trim(RS("LIGA"))%>'+'.gif'
				eval("document.all.PLATO"+Ba+".value = Aa")
				eval("thisForm.LP"+Ba+".value = Aa")
				eval("document.all.PLATO"+Ba+".src = Ca")
				eval(kk +".style.display='block'")
			}
		</script>
		<%
		rs.MoveNext
	loop	

end if
 if len(trim(foto)) > 0 then DIBUJO =0 else dibujo = 1

%>

</form>
</td>
</tr>

</table>

<script language="jscript" type="text/jscript">
    dibu = parseInt('<%=DIBUJO%>')

if (dibu == 1)
    document.all.liga.style.display='block'
else if (dibu == 0)
    document.all.dibu.style.display='block'

</script>
</body>
</html>
