<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!--#include file="includes/Cnn.inc"-->
<%
pk	=	Request.QueryString("pk") 
ds	=	Request.QueryString("ds") 
tbl	=	Request.QueryString("tbl") 
tit	=	Request.QueryString("tit") 
CAD =	" select  right(codarticulo,5) as COD_REAL , NOMBRE   as CLIENTE                " & _
        " ,ESTCLI, DESCRIPCION from estilos                                             " & _
        " inner join cliente on cliente.codigo = estilos.cliente                        " & _
        " WHERE ESTILOS.ESTADO = 'A' AND  CODARTICULO <> ''  and (right(codarticulo,5)  " & _
        " in (select right(codarticulo,5) from estilos WHERE ESTILOS.ESTADO = 'A'       " & _
        " GROUP BY right(codarticulo,5)  HAVING COUNT(*) > 1))                          " & _
        " and (right(codarticulo,5) + CLIENTE.CODIGO NOT                                " & _
        " in (select right(codarticulo,5)+ESTILOS.CLIENTE from estilos                  " & _
        " WHERE ESTILOS.ESTADO = 'A'                                                    " & _
        " GROUP BY right(codarticulo,5)+ESTILOS.CLIENTE  HAVING COUNT(*) > 1))          " & _
        " order by 1  " 
		
		RS.OPEN CAD ,Cnn
		

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../estilos1.CSS" />

</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0">

<table width="100%" ALIGN="CENTER">
	<tr>
	    <td width="5%">&nbsp;</td>
		<td  align="center" class="TALASBLUE">ESTILOS DUPLICADOS PARA EL REAL</td>
		<td  align="right" width="5%"> 
		  	<img src="../imagenes/logo.GIF" alt="" border="0" />
		  </td>
        </tr>
	<tr><td  colspan="3"><hr /></td></tr>
</table>
<table id="TABLA" align="center"  cellpadding="3" cellspacing="3" bordercolor='<%=application("color2") %>' border="0" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<%cont = 0
If rs.RECORDCOUNT <= 0 then
	Response.Write("Tabla  Vacía")		
	Response.End
end if	
	IF NIVEL > 1 THEN
		LIMITE =  rs.fields.count - 3
	ELSE 
		LIMITE =  rs.fields.count - 1
	END IF	
rs.movefirst

%>
<tr bgcolor="<%=application("titulo") %>">
	<%for I=0 to LIMITE %>
		<td class="AMERICANwhite"><%=trim(RS.FIELDS(I).name)%>&nbsp;</td>
	<%next%>	
</tr>

<%do while not rs.eof%>
<tr bgcolor="<%IF CONT MOD 2 = 0 THEN RESPONSE.WRITE(application("color1")) ELSE RESPONSE.WRITE(application("color2"))%>">
	<%FOR i=0 TO limite%>
		<td class="DESCRIPTORnavy">
		    <%if UCASE(rs.fields(i).name) = "FECHA" THEN
		        RESPONSE.Write(LEFT(trim(RS.FIELDS.ITEM(I)),10))
		      ELSE
		        RESponse.Write(trim(rs.fields.item(i)))
		      end if%>
		</td>
	<%NEXT%>
</tr>
    <%RS.MOVENEXT%>
	<%if rs.eof then exit do%>
    <%CONT = CONT + 1%>
    <%if  cont mod 60 = 0 then%>	
    <tr>
	    <td  colspan="<%=LIMITE+1%>">
	        <table width="100%" style="page-break-before:always">
	            <tr>
	                <td  align="right" width="5%">&nbsp;</td>
		            <td  align="center" class="talasblue"><%=titulo%></td>
		            <td  align="right" width="5%"><img src="../imagenes/logo.GIF"  alt="" /></td>
	            </tr>
	            <tr>
	                <td  colspan="3"><hr /></td>
	            </tr>
            </table>
	    </td>
	</tr>
	<tr bgcolor="<%=application("titulo") %>">
	    <%for I=0 to LIMITE %>
		    <td  align="center" class="DESCRIPTORnavy"><%=trim(RS.FIELDS(I).name)%></td>
	    <%next%>	
    </tr>
    <%end if %>
 
<%loop%>
</table>
</body>
</html>
