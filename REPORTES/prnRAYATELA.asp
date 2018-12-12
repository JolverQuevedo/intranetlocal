<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link rel="stylesheet" type="text/css" href="../estilos1.CSS" />
<head>
<title></title>
<script id="clientEventHandlersJS" language="javascript" type="text/jscript">
<!--
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
            height: 16px; 
            text-align:center;
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
         .style3
        {
            FONT-FAMILY: Tahoma, Geneva, sans-serif;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            FONT-SIZE: 10px;
            COLOR: black;
            FONT-FAMILY: Arial;
            height: 16px; 
            text-align:left;
        }
    </style>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">

<% 
tel = Request.QueryString("tel")
LIS = Request.QueryString("POS")
cad=	" SELECT TELAS.TELA AS TEL, TELAS.DESCRIPCION AS DESTEL,                                    			" & _
        " convert(smalldatetime, TELAS.FECHA, 113 ) as fecha, TELAS.PESOCRU,  TEJEDORAS.AGUJAS,     			" & _
        " TEJEDORAS.DESCRIPCION AS MAQUINA, TEJEDORAS.DIAMETRO, TEJEDORAS.GALGA, TEJEDORAS.ALIMENTA,			" & _
        " TELAS.LM1, TELAS.LM2, TELAS.LM3, TELAS.ANCHCRU, PESOLAV, TELAS.pesoaca, TEJEDORAS.SISTEMAS,        	" & _
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN 'ABIERTA'  ELSE 'TUBULAR' END AS TIPORUTA,           		" & _
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN TELAS.ANCHABI  ELSE TELAS.ANCHTUB END AS ANCHOACA,   		" & _
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN TELAS.ANCHABILAV  ELSE TELAS.ANCHTUBLAV END AS ANCHOLAV,  " & _		
        " CASE WHEN ANCHTUB IS NULL OR ANCHTUB=0 THEN TELAS.RENDABI  ELSE TELAS.RENDTUB END AS RENDIMIENTO,		" & _
        " CASE WHEN RENTTLAV IS NULL THEN TELAS.RENTALAV  ELSE TELAS.RENTTLAV END AS RENLAV,                	" & _
        " CURZALAV, COLLAV, MM.DESCRIPCION AS MODMAQ, TELAS.REVIRADO,COLUMNAS,                      			" & _
        " TELAS.TOLMIN, TELAS.TOLMAX, TELAS.ENCABI1, TELAS.ENCLAR1, TELAS.CURZAS, TELAS.INCACA,                 " & _
        " TELAS.enclar2, TELAS.enclar3, TELAS.eNCABI2, TELAS.ENCABI3,  TELAS.RENDTUB, ANCHABi, telas.foto,		" & _
        " MARCATEJ.DESCRIPCION as marca,  LTRIM(RTRIM(TIPTEL.DESCRIPCION)) AS TIPTEL, ANCHTUB     				" & _
        " FROM TELAS                                           				                                    " & _
        " INNER JOIN TEJEDORAS ON TELAS.MAQUINA = TEJEDORAS.CODIGO          			                        " & _
        " INNER JOIN MARCATEJ ON TEJEDORAS.MARCA = MARCATEJ.CODIGO                      			            " & _ 
        " INNER JOIN MODMAQ MM ON TEJEDORAS.MODELO = MM.CODIGO                                      			" & _
        " INNER JOIN TIPTEL ON TELAS.TIPOTELA = TIPTEL.CODIGO	            			                		" & _
		" WHERE (TELAS.TELA = '"&TEL&"')               			            " 
		'REsponse.Write(CAD)
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
	Response.Write("R E V I S A R... si tiene algun LISTADO definido")
	Response.end
end if 		
RS.MOVEFIRST

%>
<body class="datos" onafterprint="return window_onafterprint()" onbeforeprint="return window_onbeforeprint()">

<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="<%=application("color2")%>" >
<tr >
	<td width="3%" align="right" valign="top" height="180" rowspan="2"><img src="../imagenes/modelador-head2.jpg"></td>
    <td  width="20%" class="american22" align="right" rowspan="2"><br />EL MODELADOR S.A.<br /><br /><br /><br />
    <span class="TEXTOminibb">Calle Capitan Salvador Carmona 280
    <br />Lot. Ind. S.R. La Molina - Ate <br />
          e-Mail: sales@elmodelador.com.pe<br />
          Phone: (511)348-8180/348-6936<br />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;348-9467/348-1380<br />
          Fax: (511)348-6182</span></td>	 
	<td width="80%" align="center"  class="TALASBLUE" rowspan="2">FICHA TECNICA DE TELA LISTADA: 
		<%=TEL%> - RAYA <%=LIS%></td>		
	<td width="5%" ><img id="ppp" style="cursor:hand;" onClick="window.print();" src="../imagenes/PRINT.gif" alt="" /></td>
</tr>
<tr><td width="10%" bgcolor='<%=application("color2") %>' class="DESCRIPTORnegro" valign="bottom">
		 <%=day(RS("FECHA"))%>/<%=month(RS("FECHA"))%>/<%=year(RS("FECHA"))%><br /><br />
    </td></tr>
</table>
<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
  <tr><td class="AMERICANwhite"> DATOS GENERALES :</td></tr>
</table>


<table width="100%" border="0" cellspacing="1" cellpadding="1"
		bordercolor="<%=application("color2")%>" bordercolorlight="<%=application("barra")%>">
  <tr> 
    <td width="5%" bgcolor="<%=application("barra")%>" class="style1">Descripcion
    </td>
    <td colspan="10" class="style2"> <%=TRIM(RS("destel"))%></td>
  </tr>
  <tr><td colspan="11" height="5"></td></tr>
</table>  

<table width="100%" border="0" cellspacing="1" cellpadding="1" bordercolor="<%=application("color2")%>" bordercolorlight="<%=application("barra")%>">

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
<%  afib= Array()
    aPor= Array()
    vont = 1
    FOR I=1 TO 6%>
	<%CAD = "HIL" + TRIM(I) %>
<%IF LTRIM(RTRIM(RS2(CAD))) <> "" THEN%>	
		<tr  <%if vont mod 2  = 0 then%>
	 bgcolor="<%=application("color1")%>"
		<%end if%>	> 
		  <td width="10%" align="center" class="DESCRIPTORnegro"><%=trim(RS2("TIT"&I))%></td>
		  <td width="5%" align="center" class="DESCRIPTORnegro"><%=RS2("%"&I)%> %</td>
		  <td width="85%" class="DESCRIPTORnegro"><%=RS2("F"&I)%></td>		 
		</tr>
        <%' porcentajes de intervencion por fibra (los aarays inician en 0)
        redim preserve aPor(vont)
        aPor(vont-1)= RS2("%"&I)%>
		<%vont= vont + 1 %>
	<%END IF%>
<%NEXT%>
<%rs2.close%>
<tr><td colspan="3" height="5"></td></tr>		
</table>

<table width="100%"  border="1" cellspacing="1" cellpadding="2"  bordercolor="<%=application("color1")%>" bordercolorlight="<%=application("COLOR1")%>">
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
<form id="thisForm" method="post" action=''>

<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite">ESPECIFICACIONES TECNICAS DEL LISTADO</td></tr>

</table>
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="0">
    <tr valign="middle">
		<td  bgcolor="<%=application("barra") %>" align="center">
		<span class="AMERICANnavy">ESTRUCTURA DE LAS RAYAS</span>
		</td>
	</tr>
</table>
<%RS2.CLOSE
CAD =	" SELECT * from VIEW_RAYADOS WHERE TELA = '"&tel&"' " & _
        " and codigo ='"&LIS&"' ORDER BY  CODIGO            " 
        'response.write(cad)
RS2.Open CAD, Cnn        
%>
<table border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="<%=application("COLOR1")%>">
     <tr>            
	    <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="AMERICANnavy">RAYA # :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%" class="style2"><%=TRIM(RS2("CODIGO")) %></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="AMERICANnavy">DESCRIPCION :</td>
        <td width="55%" bgcolor="<%=(Application("color2"))%>" colspan="3" class="style2"><%=TRIM(UCASE(RS2("DESCRIPCION"))) %></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right" class="AMERICANnavy">CLIENTE :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%" class="style2"><%=TRIM(UCASE(RS2("DESCLI"))) %>
        </td>      
    </tr>
    <tr>             
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="AMERICANnavy">COD CLI :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%" class="style2"><%=TRiM(RS2("COLCLI")) %></td>  
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="AMERICANnavy"># COLORES :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%" class="style2"><%=RS2("NUMCOL") %></td>        
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="AMERICANnavy">RAPPORT CMS :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%" class="style2"><%=RS2("RAPPORT") %></td> 
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="AMERICANnavy"># FRANJAS :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%" class="style2"><%=RS2("NUMFRA") %></td> 
    </tr>
    <tr>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="AMERICANnavy">OBSERVACION :</td>
        <td bgcolor="<%=(Application("color2"))%>"  colspan="7" class="style2"><%=trim(ucase(rs2("obs"))) %></td> 
    </tr>
</table>
 <% letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"     
    CAD = "exec FIBRAS_TELA '"&tel&"' "
    'response.Write(cad)
    rs.close
    rs.open cad,cnn
    xx=0
    aFib = Array(0)   
    if rs.recordcount > 0 then
        rs.movefirst
        do while not rs.eof
            'fibras que intervienen en la tela
            redim preserve aFib(xx)
            aFib(xx) = rs("fibra")
            xx=xx+1
            rs.movenext
        loop
    end if

    rs.close
	CAD =	" SELECT COLOR, colores.DESCRIPCION, LETRA1, SEC, ALTURA, RAPPORT, NUMCOL,  " & _
	        " NUMFRA, PASADAS, m1.descripcion as FIBRA1,                        " & _
            " marka = case when sum(altura) is null                             " & _
            " then 0 else 1 end         " & _
            " FROM materia m1, RAYASEC AS R1 RIGHT OUTER JOIN COLORES ON COLOR = CODIGO     " & _
	        " WHERE COMBIN = '00' AND COLOR = '"&lis&"' AND R1.ESTADO = 'A'     " & _
            " and m1.codigo = fibra1                " & _
            " group by COLOR, colores.DESCRIPCION, LETRA1, SEC, ALTURA, RAPPORT, NUMCOL, " & _
            " NUMFRA, PASADAS, m1.descripcion, letra2, letra3, letra4,letra5,letra6    " & _
	        " ORDER BY 4                                                        " 
	'response.Write(cAD)

	rs.open cad , cnn
    if rs.recordcount > 0 then
	    maxi = rs("rapport")
	    FRA = RS("NUMFRA")
	    numlet = rs("numcol")
	    descrip = trim(rs("descripcion"))
    end if    %>
<table border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>" >
    <tr valign="middle" bgcolor="<%=(Application("BARRA"))%>" align="center">
        <td class="DESCRIPTORnavyBOLD">FRANJA<br />#</td>
        <td class="DESCRIPTORnavyBOLD">PASADAS</td>
        <td class="DESCRIPTORnavyBOLD">ALTURA<br /> cms.</td>
        <%LETTER = rs("numcol") %>
        <%'for x=0 to ubound(afib) %>
	        <td class="DESCRIPTORnavyBOLD">L<%=x+1%></td>
            <td class="DESCRIPTORnavyBOLD">FIB<%=x+1 %></td>
        <%'next%> 
	</tr>
    <%if rs.recordcount <=0 then response.end %>	
    <%cn=0 
    ' join hace que un array se convierta en un string, es el inverso de SPLIT
    RESUL = JOIN(AfIB)
    tota2=0
    ttoa = 0%>	
    <%rs.movefirst %>
    <%do while not rs.eof %>
      <tr valign="middle" bgcolor="<%if cn mod 2 = 0 then response.write(Application("color1")) else response.write(Application("color2")) %>" align="center">
            <td class="DESCRIPTORnavyBOLD"><%=rs("sec")%></td>
            <td class="style2"><%if rs("pasadas")> 0 then response.write(rs("pasadas"))%></td>
            <td class="style2"><%if trim(rs("altura")) <> "0" then response.write(rs("altura"))%></td>
	       <%'for x=0 to ubound(afib)%>
                <%vari = "letra"&(x+1)           
                fibi = "fibra"&(x+1)%>
                <td class="style2">&nbsp;&nbsp;<%=trim(rs(vari))%>&nbsp;&nbsp;</td>	 
                <td class="style3">&nbsp;&nbsp;<%=trim(rs(fibi))%>&nbsp;&nbsp;</td>
            <%'next %>
	    </tr>
        <%cn = cn+1 
        IF ISNULL(rs("altura")) OR LEN(TRIM(rs("altura")))=0 THEN ALT = 0 ELSE ALT = cdbl(rs("altura"))
        tota = tota + ALT
        IF ISNULL(rs("pasadas")) OR LEN(TRIM(rs("pasadas")))=0 THEN pas = 0 ELSE pas = cdbl(rs("pasadas"))
        tota2 = tota2 + pas%>
        <%rs.movenext%>
    <%loop%>   
    <tr valign="middle" bgcolor="<%=(Application("BARRA"))%>" align="center">
            <td colspan="1" class="DESCRIPTORnavyBOLD">Total</td>
            <td class="DESCRIPTORnavyBOLD" id="tota1"><%=tota2%></td>
            <td class="DESCRIPTORnavyBOLD" id="tota2"><%=tota%></td>
           <td colspan="12"></td>
    </tr>
</table>
<p></p>
<table border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>" >
    <tr valign="middle" bgcolor="<%=(Application("HEAD"))%>" align="center" class="AMERICANwhite">
        <td>FIBRA</td>
        <td>%</td>
        <td>COLOR</td> 
        <td>Alt.</td>
        <td>Pasad.</td>
        <td>% COLOR</td>
    </tr> 
        <%CAD = " FIBRA_LETRA '"&LIS&"' "
        RS.CLOSE
        RS.OPEN CAD,CNN
        RS.MOVEFIRST
        'response.write(cad)
        x=0
        for y=0 to ubound(afib)%>
            <tr bgcolor="<%=application("BARRA")%>">
                <td class="DESCRIPTORnavyBOLD"><%=AfIB(Y)%></td>
                <td class="DESCRIPTORnavyBOLD"><%=APOR(Y)%> %</td>
                <td colspan="4"></td>
            </tr>
            <%t1=0
            t2=0
            DO WHILE NOT RS.EOF 
              IF RS("FIBRA1")= AFIB(Y) THEN%>
                <tr bgcolor="<%=application("color2")%>">
                    <td colspan="2"></td>
                    <td class="style1"><%=rS("LETRA1")%></td>
                    <td class="style3"><%=formatnumber(RS("ALTU"),2,,,true)%></td>
                    <td class="style3"><%=RS("PASA")%>&nbsp;&nbsp;</td>
                    <%dato = ((cdbl(rs("altu"))*100)/tota)*aPor(y)/100 %>
                    <td class="style3"><%=formatnumber(dato,2,,,true) %>&nbsp;%&nbsp;</td>
                    <%if cdbl(rs("altu")) > 0 then t1=t1+cdbl(rs("altu"))%>
                    <%if cdbl(rs("pasa")) > 0 then t2=t2+cdbl(rs("pasa"))%>
                </tr>
                <%else
                exit do%>
                <%END IF%>
                <%RS.MOVENEXT%>
                <%x= x +1%>
            <%LOOP%>                 
             <tr bgcolor="<%=application("color1")%>">
                    <td colspan="3"></td>
                    <td class="style3"><%=formatnumber(t1,2,,,true)%></td>
                    <td class="style3"><%=t2%>&nbsp;&nbsp;</td>
                    <td class="style3"></td> 
                </tr>
            <script language="jscript" type="text/jscript">
            dato = '<%=t1%>'
            valo = parseInt('<%=y%>', 10)
            x = parseInt('<%=x %>',10)
                eval("document.all.ss"+valo+x+"value=dato")
            </script>
        <%next%>   
</table>
<%
sub primero (dato1, dato2, pos, aDat)
    response.write("<tr bgcolor='gainsboro'>")
    response.write("<td class=style2>")
    response.write(dato1)
    response.write("</td>")
    response.write("<td class=style2>")
    response.write(dato2)
    response.write(" %  ")
    response.write("</td>")
    response.write("<td class=style1>")
    response.write("  -  ")
    response.write("</td><td class=style1>")
    response.write("  -  ")
    response.write("</td><td class=style1>")          
    response.write("  -  ")
    response.write("</td></tr>")

end sub
sub celda(dato, pos, dato2) 
    RESPONSE.Write("<tr bgcolor='white'>")
    response.write("<td></td><td></td>") 
    response.write("<td class=style1>")
    response.write(mid(letras,pos,1))
    response.write("</td><td class=style1>")
    response.write(dato)
    response.write("</td>")
    response.write("<td>")
    porcen = dato*100/dato2
    
    'response.write(dato2)
    'formatnumber(porcen,2,,,true))
    response.write("</td>")
    response.write("</tr>")

end sub
%>
</form>
</body>
</html>
