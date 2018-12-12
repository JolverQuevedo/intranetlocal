<%@ Language=VBscript %>
<%  Response.Buffer = true 
' Evita el cache del navegador
Response.addHeader "pragma", "no-cache"
Response.CacheControl = "Private"
Response.Expires = 0
txtUsuario = Request.Cookies("Usuario")("USUARIO")
response.Cookies("usuario")("directorio")= "ligaduras/"
%><head>
<script type="text/javascript" language="javascript" src="includes/rutinas.js"></script>

<script type="text/javascript" language="jscript">
var letras = "ABCDEFGHIJKLMNOPQRSTUWXYZ"
menuImages = new Array(7)
menuImages[0] = new Image()
menuImages[0].src = "imagenes/blanco.GIF"
menuImages[1] = new Image()
menuImages[1].src = "imagenes/Pteje.gif"
menuImages[2] = new Image()
menuImages[2].src = "imagenes/Cteje.gif"
menuImages[3] = new Image()
menuImages[3].src = "imagenes/Pnoteje.gif"
menuImages[4] = new Image()
menuImages[4].src = "imagenes/Cnoteje.gif"
menuImages[5] = new Image()
menuImages[5].src = "imagenes/Pretiene.gif"
menuImages[6] = new Image()
menuImages[6].src = "imagenes/Cretiene.gif"
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
</script>
<title></title>
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="comun/funcionescomunes.asp"-->
<script id="clientEventHandlersJS" language="jscript" type="text/jscript">
<!--
//-->
</script>
</head>
<html>

<link rel="stylesheet" type="text/css" href="estilos1.CSS" />

<%dim aCol
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
cad=	" SELECT TELAS.TELA AS TEL, TELAS.DESCRIPCION AS DESTEL, TELAS.FECHA,       " & _
        " TEJEDORAS.DIAMETRO, TEJEDORAS.GALGA, TELAS.PESOCRU, TEJEDORAS.ALIMENTA,   " & _
        " TELAS.RENDTUB, TELAS.ANCHTUB, TELAS.ANCHABI, 					            " & _
        " TELAS.RENTTLAV, MARCATEJ.DESCRIPCION as marca, TEJEDORAS.AGUJAS,          " & _
        " FT.PINON, TEJEDORAS.SISTEMAS, maquinas.descripcion as modelo,             " & _
        " tejedoras.codigo as CODMAQ, tejedoras.descripcion as maquina, TELAS.FOTO, " & _
        " TRH.descriptor as cliente, TELAS.OPCION                                   " & _
        " FROM TELAS                                                                " & _
        " INNER JOIN TEJEDORAS ON TELAS.MAQUINA                                     " & _
        " COLLATE DATABASE_DEFAULT = TEJEDORAS.CODIGO COLLATE DATABASE_DEFAULT      " & _
        " INNER JOIN MODMAQ AS MAQUINAS ON MAQUINAS.CODIGO                          " & _
        " COLLATE DATABASE_DEFAULT = TEJEDORAS.MODELO COLLATE DATABASE_DEFAULT      " & _
        " INNER JOIN MARCATEJ ON TEJEDORAS.MARCA                                    " & _
        " COLLATE DATABASE_DEFAULT = MARCATEJ.CODIGO COLLATE DATABASE_DEFAULT       " & _
        " LEFT OUTER JOIN FICHATEJE FT ON FT.TELA                                   " & _
        " COLLATE DATABASE_DEFAULT = TELAS.TELA COLLATE DATABASE_DEFAULT            " & _
        " left outer join TELARUTAHEAD TRH ON TRH.TELA = TELAS.TELA                 " & _
        " WHERE (TELAS.TELA = '"&tel&"')                                            "
		'Response.Write (cad)
		'Response.end
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
	Response.Write("Este Artículo no tiene los datos completos")
	Response.Write("<br>")
	Response.Write("<br>")
	Response.Write("R E V I S A R... su Ficha Técnica")
	Response.end
end if 		
RS.MOVEFIRST
RESPONSE.COOKIES("usuario")("tela") = tel
foto = RS("FOTO")
%>
<body topmargin="0" rightmargin="0" leftmargin="0" class="datos" onUnload="CierraHelp()">
<form id="thisForm" method="post" action='COMUN/INSERfichaLIG.ASP'>
<table width="100%" align="center" border="0">
<tr>
	<td width="10%"><img  src="imagenes/cerrar.gif" alt="" onClick="window.close()" /></td>	 
	<td width="84%" align="center" class="talasblue"> HOJA DE LIGADURAS DE TELA: 
		<%=TEL%> <input id ="TELA" name="TELA" value="<%=TEL%>" type="hidden" />
      </td>		
	<td width="10%"><img  src="imagenes/logo.gif" alt="" /></td>
</tr>
</table>
<hr />
<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite"> DATOS GENERALES :</td></tr>
</table>


<table width="100%" border="0" cellspacing="1" cellpadding="1"
		bordercolor="<%=application("color2")%>" bordercolorlight="<%=application("barra")%>">
  <tr valign="middle"> 
    <td  align=right width="5%"  bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Cliente</td>
    <td width="50%" colspan="4" class="DESCRIPTORnegro">
		 <%=trim(rs("cliente"))%>
    </td>
    <td  align=right width="5%"  bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Partida</td>
    <td width="10%" class="DESCRIPTORnegro">&nbsp;
		 
	</td>
    <td  align=right width="2%"  bgcolor="<%=application("barra")%>"  class="AMERICANnavy">O/P</td>
    <td width="20%" class="DESCRIPTORnegro">&nbsp;</td>
    <td  align=right width="1%" bgcolor="<%=application("barra")%>"  class="AMERICANnavy">Fecha</td>
    <td width=10% class="DESCRIPTORnegro">
		 <%=day(RS("FECHA"))%>/<%=month(RS("FECHA"))%>/<%=year(RS("FECHA"))%>
    </td>
  </tr>
  <tr> 
    <td width="5%" bgcolor="<%=application("barra")%>" class="AMERICANnavy">Descripcion
    </td>
    <td colspan="10" class="DESCRIPTORnegro"> <%=TRIM(RS("destel"))%></td>
  </tr>
  <tr><td colspan="11" height="5"></td></tr>
</table>  
<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite"> CARACTERISTICAS DE LA MAQUINA TEJEDORA</td></tr>
</table>


<table width="100%"  border="1" cellspacing="1" cellpadding="2"  bordercolor="<%=application("color1")%>" bordercolorlight="<%=application("COLOR1")%>">
	<tr bgcolor="<%=application("barra")%>"  > 
		<td width="25%" align="center" class="AMERICANnavy">MAQUINA</td>
		<td width="25%" align="center" valign="middle" class="AMERICANnavy">MARCA</td>
		<td width="10%" align="center" class="AMERICANnavy">MODELO</td>
		<td width="10%" align="center" class="AMERICANnavy">GG</td>
		<td width="10%" align="center" class="AMERICANnavy">DIAMETRO</td>
		<td width="10%" align="center" class="AMERICANnavy"># ALIMENTADORES</td>
		<td width="10%" align="center" class="AMERICANnavy"># AGUJAS</td>
	</tr>
    <tr> 
		<td width="25%"><input id="MAQUINA" name="MAQUINA" value='<%=TRIM(RS("modelo"))%>' readonly=readonly	class="DESCRIPTORnegro" /></td>
		<td width="25%"><input id="CODMAQ" name="CODMAQ" value='<%=RS("CODMAQ")%>' type ="HIDDEN" /><input id="DESMAQ" name="DESMAQ" value='<%=TRIM(RS("Marca"))%>' class="DESCRIPTORnegro" /></td>
		<td width="25%"><input id="MODELO" name="MODELO" value='<%=TRIM(RS("maquina"))%>' class="DESCRIPTORnegro" /></td>
		<td width="10%" align="center" class="DESCRIPTORnegro"><%=RS("galga")%>&nbsp;</td>
		<td width="10%" align="center" class="DESCRIPTORnegro"><%=RS("diametro")%>&nbsp;</td>
		<td width="10%" align="center" class="DESCRIPTORnegro"><%=RS("SISTEMAS")%></td>
		<td width="10%" align="center" class="DESCRIPTORnegro"><%=RS("AGUJAS")%></td>
	</tr>
</table>
<%CAD =	" SELECT 	T.TELA,  " & _
		" T.DESCRIPCION,  " & _
		" T.HIL1, T.POR1 AS [%1], M1.DESCRIPCION AS F1,  " & _
		" H1.DESCRIPCION AS DES1, " & _
		" T.HIL2, T.POR2 AS [%2], M2.DESCRIPCION AS F2,  " & _
		" H2.DESCRIPCION AS DES2, " & _
		" T.HIL3, T.POR3 AS [%3], M3.DESCRIPCION AS F3,  " & _
		" H3.DESCRIPCION AS DES3, " & _
 		" T.HIL4, T.POR4 AS [%4], M4.DESCRIPCION AS F4,  " & _
		" H4.DESCRIPCION AS DES4, " & _
		" T.HIL5, T.POR5 AS [%5], M5.DESCRIPCION AS F5,  " & _
		" H5.DESCRIPCION AS DES5, " & _
		" T.HIL6, T.POR6 AS [%6], M6.DESCRIPCION AS F6,  " & _
		" H6.DESCRIPCION AS DES6, " & _
		" STR(CONVERT(INT,SUBSTRING(T.HIL1,4,3))) +'/'+ SUBSTRING(T.HIL1,7,1)AS TIT1, " & _
		" STR(CONVERT(INT,SUBSTRING(T.HIL2,4,3))) +'/'+ SUBSTRING(T.HIL2,7,1)AS TIT2, " & _
		" STR(CONVERT(INT,SUBSTRING(T.HIL3,4,3))) +'/'+ SUBSTRING(T.HIL3,7,1)AS TIT3, " & _
		" STR(CONVERT(INT,SUBSTRING(T.HIL4,4,3))) +'/'+ SUBSTRING(T.HIL4,7,1)AS TIT4, " & _
		" STR(CONVERT(INT,SUBSTRING(T.HIL5,4,3))) +'/'+ SUBSTRING(T.HIL5,7,1)AS TIT5, " & _
		" STR(CONVERT(INT,SUBSTRING(T.HIL6,4,3))) +'/'+ SUBSTRING(T.HIL6,7,1)AS TIT6  " & _
		" FROM 	TELAS 					AS T " & _
		" INNER JOIN  	 		HILADO 	AS H1 ON T.HIL1	 COLLATE DATABASE_DEFAULT = H1.HILO  COLLATE DATABASE_DEFAULT  " & _
		" LEFT OUTER JOIN    	HILADO 	AS H2 ON T.HIL2	 COLLATE DATABASE_DEFAULT = H2.HILO  COLLATE DATABASE_DEFAULT " & _
		" LEFT OUTER JOIN   	HILADO 	AS H3 ON T.HIL3	 COLLATE DATABASE_DEFAULT = H3.HILO   COLLATE DATABASE_DEFAULT " & _
		" LEFT OUTER JOIN		HILADO 	AS H4 ON T.HIL4	 COLLATE DATABASE_DEFAULT = H4.HILO   COLLATE DATABASE_DEFAULT " & _
		" LEFT OUTER JOIN    	HILADO 	AS H5 ON T.HIL5	 COLLATE DATABASE_DEFAULT = H5.HILO  COLLATE DATABASE_DEFAULT " & _ 
		" LEFT OUTER JOIN   	HILADO 	AS H6 ON T.HIL6	 COLLATE DATABASE_DEFAULT = H6.HILO  COLLATE DATABASE_DEFAULT " & _
		" INNER JOIN  	 		MATERIA 	AS M1 ON LEFT(T.HIL1,3)	 COLLATE DATABASE_DEFAULT = M1.CODIGO  COLLATE DATABASE_DEFAULT  " & _
		" LEFT OUTER JOIN    	MATERIA 	AS M2 ON LEFT(T.HIL2,3)	 COLLATE DATABASE_DEFAULT = M2.CODIGO COLLATE DATABASE_DEFAULT  " & _
		" LEFT OUTER JOIN   	MATERIA 	AS M3 ON LEFT(T.HIL3,3)	 COLLATE DATABASE_DEFAULT = M3.CODIGO  COLLATE DATABASE_DEFAULT  " & _
		" LEFT OUTER JOIN		MATERIA 	AS M4 ON LEFT(T.HIL4,3) COLLATE DATABASE_DEFAULT 	= M4.CODIGO   COLLATE DATABASE_DEFAULT " & _
		" LEFT OUTER JOIN    	MATERIA 	AS M5 ON LEFT(T.HIL5,3)	 COLLATE DATABASE_DEFAULT = M5.CODIGO  COLLATE DATABASE_DEFAULT " & _ 
		" LEFT OUTER JOIN   	MATERIA 	AS M6 ON LEFT(T.HIL6,3)	 COLLATE DATABASE_DEFAULT = M6.CODIGO  COLLATE DATABASE_DEFAULT " & _
		" WHERE T.TELA ='"&TEL&"'" 
	Set RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.ActiveConnection = Cnn
		RS2.Cursortype       = 3 'CONST adOpenStatic = 3
		RS2.Locktype         = 1 'CONST adReadOnly = 1
		'Response.Write(CAD)
RS2.Open CAD,CNN
%>
<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite">DATOS DE HILADO:</td></tr>
</table>
<% aTit = Array()%>
<% aFIB = Array()%>
<% aMAT = Array()%>
<table width="100%" border="0" cellspacing="1" cellpadding="1" bordercolor="<%=application("color2")%>" bordercolorlight="<%=application("barra")%>">
<tr> 
  <td width="10%"   bgcolor="<%=application("barra")%>"   class="AMERICANnavy">Titulo</td>
  <td width="5%" align="center"  bgcolor="<%=application("barra")%>"   class="AMERICANnavy">%</td>
  <td width="85%"  bgcolor="<%=application("barra")%>"   class="AMERICANnavy">Fibra</td>
</tr>  
<%FOR I=1 TO 6%>
	<%CAD = "HIL" + TRIM(I) %>
	<%IF trim(RS2(CAD))<> "" THEN%>	
		<tr> 
		    <td width="10%" class="DESCRIPTORnegro">
				 <%=RS2("TIT"&I)%>
				 <%redim preserve aTit(UBOUND(AtIT)+1)
				 aTit(UBOUND(ATIT))= RS2("TIT"&I)%>
				 <%redim preserve aFIB(UBOUND(AFIB)+1)
				 aFIB(UBOUND(AFIB))= LEFT(RS2("HIL"&I),3)%>
		    </td>
    	    <td width="5%" class="DESCRIPTORnegro"><%=RS2("%"&I)%></td>
		  <td width="85%" class="DESCRIPTORnegro">
				 <%=RS2("F"&I)%></td> 
		</tr>
	<%END IF%>
<%NEXT%>
<%rs2.close%>		
</table>
<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite">ESPECIFICACIONES TECNICAS PARA EL TEJIDO</td></tr>
<tr>
		<td  bgcolor="<%=application("barra") %>" align="center">
		<SPAN class="AMERICANnavy">LIGADURAS</SPAN>
		</td>
	</tr>
</table>
<center>
<table align="center"cellspacing="2" cellpadding="4" bgcolor="<%=application("color2") %>">
    <tr>
        <td><input type="radio" name="opc" value="L" onClick="show()" <%if rs("opcion")="L" then %>checked<%end if %> />Arma Ligaduras</td>
    </tr>
    <tr>
        <td><input type="radio" name="opc" value="I" onClick="show()" <%if rs("opcion")="I" then %>checked<%end if %> />Sube Archivo Imágen</td>
    </tr>
</table>
</center>

<table width="100%"  border="1" cellspacing="0" cellpadding="0" bgcolor="<%=application("color1") %>" id="LIGA" name ="LIGA" style="display:none">
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
					<td align="center"  height="50"	onclick="CAMBIA(<%=K%>,'<%=aCol(m)%>','PLATO','<%=m%>')">
						<input id="LP<%=aCol(m)%><%=K%>" name="LP<%=aCol(m)%><%=K%>" type ="hidden" value="0" /><img width="25" 
						id="PLATO<%=aCol(m)%><%=K%>" name="PLATO<%=aCol(m)%><%=K%>"  src="imagenes/blanco.jpg" alt="" /></td>
					<%NEXT%>
				</tr>
				<%next%>
				<%letas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"%>
				<%for m=1 to 12%>
				<tr id='<%=aCol(m)%>' style="display:'none'" name='<%=aCol(m)%>'>
					<td width="20" align="center" bgcolor="<%=application("resalte") %>" class="AMERICANwhite">&nbsp;<%=mid(letas,m+1,1)%>&nbsp;</td>
					<%FOR n=1 TO 36%>
					<td align="center"  height="55"	onclick="CAMBIA(<%=n%>,'<%=aCol(m)%>','PLATO','<%=m%>')">		
						<input id="LP<%=aCol(m)%><%=N%>" name="LP<%=aCol(m)%><%=N%>" type="hidden" value="0" />					
						<img  width="25" id="PLATO<%=aCol(m)%><%=n%>"	name="PLATO<%=aCol(m)%><%=n%>" src="imagenes/blanco.jpg" alt="" />
					</td>
					<%NEXT%>
				</tr>
				<%next%>				
			</table>
		</td>
	</tr>
</table>
<center><input id="foton" name="foton" value='<%=foto%>' style="display:none" />

 <input name="FLGFOT" type="hidden" id="FLGFOT" value="0">
<img src='ligaduras/<%=foto%>' name="foto" width="516" height="328" align="middle" id="foto" style="cursor:pointer; display:none" onClick="Help('subefoto.asp?usr='+tel,516,328)"/>
<br /><br />
<img ID="ppp" style="cursor:hand;" onClick="GRABA();"	src="imagenes/DISK.gif" alt="" />
</center> 


</form>
<%rs.close 
cad =	" SELECT FTL.TELA, FTL.UBI, FTL.LIGADURA,					" & _
	    " LL.DESCRIPCION AS LIGA									" & _
		" FROM FICHATEJELIGA FTL									" & _
		" LEFT OUTER JOIN  LIGADURAS LL ON FTL.LIGADURA = LL.CODIGO	" & _
		" WHERE (FTL.TELA = '"&tel&"')								" 
rs.open cad, cnn
dibujo ="1"
if rs.RecordCount > 0 then
	RS.MOVEFIRST	
	do while not rs.eof%>
		<script language="jscript" type="text/jscript">
		//  FILA	:	A ...	L
		//	COLUMNA :	1 ...	36  
			Aa = '<%=TRIM(RS("LIGADURA"))%>'
			if (!isNaN(Aa))
			{	Ba = '<%=RS("UBI")%>'
				kk = '<%=left(RS("UBI"),1)%>'
				Ca = 'imagenes/'+'<%=trim(RS("LIGA"))%>'+'.gif'
				eval("document.all.PLATO"+Ba+".value = Aa")
				eval("thisForm.LP"+Ba+".value = Aa")
				eval("document.all.PLATO"+Ba+".src = Ca")
				eval(kk +".style.display='block'")
			}
		</script>
		<%
		rs.MoveNext
	loop
else
    dibujo="0"		
end if
rs.close
%>
<script type="text/jscript" language="jscript">
var _objetus=objetus() //crear objeto ajax
var cli= document.getElementById("CLI")
var valor
var _obj
var _tb
var _f
var _ci
var _n
var help= null
var tel = '<%=tel%>'

    
function GRABA()
{ thisForm.submit();
}

function Help(pag,h,w)
{	thisForm.FLGFOT.value = "0"
    document.all.foto.src=''
	CierraHelp()
	if(h==null) h=80
	if(w==null) w=400
	
	var opc = "height=180,width="+w+",channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,scrollbars=1,status=1,toolbar=0" 
	help=window.open(pag,'help',opc)
	document.all.foton.value='<%=tel%>.jpg'
}

function CierraHelp(){
	if (help != null){
		help.close()
		help=null
	}
}

function VeFoto(nfoto){
document.getElementById("foto").src='ligaduras/'+nfoto
document.getElementById("foto").width=516
document.getElementById("foto").height=328
document.getElementById("FLGFOT").value=1
CierraHelp()
}
function show()
{   if (document.all.opc(0).checked== true)
    {   document.all.LIGA.style.display='block'
        document.all.foto.style.display='none'
    }
    if (document.all.opc(1).checked== true)    
    {   document.all.LIGA.style.display='none'
        document.all.foto.style.display='block'
        foto = trim('<%=foto%>')
        if (foto=='')
            Help('subefoto.asp?usr='+tel,516,328)
    }
}

show()
</script>
</body>
</html>
