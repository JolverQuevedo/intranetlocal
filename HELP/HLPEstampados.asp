<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") %>
<script>
function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff)
	window.opener.window.thisForm.PED.value = trim(t.rows(pos).cells(0).innerText);
	window.opener.window.thisForm.COR.value = trim(t.rows(pos).cells(1).innerText);
	window.opener.window.thisForm.COL.value = trim(t.rows(pos).cells(3).innerText);
	window.opener.window.thisForm.DES.value = ltrim(t.rows(pos).cells(4).innerText);
	window.opener.window.thisForm.CAN.value = ltrim(t.rows(pos).cells(8).innerText);
	this.window.close();
}	
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;	
	dd(ff);
}
oldrow=1
</script>
<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT DISTINCT " & _
		" LC.PEDIDO, LC.NUMERO, LC.CODGIRO, LC.COLOR, " & _
		" CC.DESCRIPCION AS DESCOL, PROTOS.DESCRIPCION, " & _
		" LC.REAL0, LC.REAL1, LC.REAL2, LC.REAL3, LC.REAL4, LC.REAL5, LC.REAL6, LC.REAL7, LC.REAL8, LC.REAL9, " & _
		" LC.REAL0 + LC.REAL1 + LC.REAL2 + LC.REAL3 + LC.REAL4 + LC.REAL5 + LC.REAL6 + LC.REAL7 + LC.REAL8 + LC.REAL9 AS TOTAL, " & _
		" PEDIDOS.PRENDA " & _
		" FROM LIQUIDACIONCORTE LC INNER JOIN " & _
        " COLORES CC ON LC.COLOR = CC.CODIGO INNER JOIN " & _
        " PEDIDOS ON LC.PEDIDO = PEDIDOS.PEDIDO INNER JOIN " & _
        " PROTOS ON PEDIDOS.PROTO = PROTOS.PROTO AND PEDIDOS.VERSION = PROTOS.VERSION " & _
		" ORDER BY LC.PEDIDO desc"		%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNDOS.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
    <%
'*****************************************************************
'					PAGINACION
'*****************************************************************
IF NREG=0 THEN 	NREG = 0 ELSE NREG = NREG + 1 END IF
	NREG		 = RS.RECORDCOUNT 
	num_registros = 500
	num_bloques = 10
	num_max = 10
	num_pag = Cint(( NREG/num_registros)+0.5)
	num_min = 1
	pagina_actual = 1
	direccion_url = ""
	if (request.queryString("pag") <> "") then 
		pagina_actual = request.queryString("pag")
	else
		pagina_actual = 1
	end if

if RS.recordcount > 0 then
RS.pageSize = num_registros
if cInt(pagina_actual) <= 0 then
pagina_actual = 1
end if  
RS.absolutePage = pagina_actual
cantidad_campos = RS.Fields.Count
end if


if (left(pagina_actual,4) = "0000" ) then
	num_min = cInt(pagina_actual) + 1
	num_max = num_min + num_bloques - 1
	if num_max > RS.PageCount then
		num_max = RS.PageCount
	end if
	
elseif (left(pagina_actual,3) = "000") then	
	num_max = pagina_actual - 1
	num_min = pagina_actual - num_bloques	
else	
	if (len(pagina_actual) = 1) then
	num_min = 1
	num_max = 10
	else			
		if (len(pagina_actual) = 2) then
		tmpo = cInt(left(pagina_actual,1)) 		
		elseif (len(pagina_actual) = 3) then
		tmpo = cInt(left(pagina_actual,2)) 
		elseif (len(pagina_actual) = 4) then
		tmpo = cInt(left(pagina_actual,3)) 
		end if	
			
		num_min = num_max * tmpo + 1  
		num_max = num_min + num_bloques - 1	
		
		if (pagina_actual = 1) then 		
		num_min = 1
		end if
	
		if num_max > RS.PageCount then
		num_max = RS.PageCount
		end if
		
		if pagina_actual >=RS.PageCount and pagina_actual = 10 then
		num_min = 1
		num_max = 10						
		end if
			
	end if	
end if
'******************************************************************
'******************************************************************
%>
<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=10 rightmargin=10 border=0 text="#000000">
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=25%>
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;" 
			onclick="javascript: window.close();">
		</td>
		<td align= CENTER>
			<font face=arial size= 2 color=DarkBlue><B>
			PEDIDOS-CORTE
			</b></font>
		</td>
        </TR>
	</tr>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=2  cellspacing=1 bordercolor=White
	  bgcolor=NAVY border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>pedido</B></FONT></TD>
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>numero</B></FONT></TD>
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>corte</B></FONT></TD>
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>color</B></FONT></TD>
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>descol</B></FONT></TD>
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>descripcion</B></FONT></TD>
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>total</B></FONT></TD>	
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>prenda</B></FONT></TD>	
</TR>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE (Not RS.eof And registros_mostrados < num_registros) %>
<%registros_mostrados = registros_mostrados +1%>
<%	mayor = 0
	for i=0 to 9
		if mayor < rs("REAL"&I) then
			mayor = rs("REAL"&I)
		end if
	next%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor=#F8FEFB 
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
				ondblclick="REDIR('<%=(cont)%>')">
		<% else %>
			<tr bgcolor=#C5D6D9
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  
				ondblclick="REDIR('<%=(cont)%>')">
	<%end IF%>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("pedido")%></B></FONT></TD>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("numero")%></B></FONT></TD>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("codgiro")%>&nbsp;</B></FONT></TD>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("color")%></B></FONT></TD>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("descol")%></B></FONT></TD>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("descripcion")%></B></FONT></TD>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("total")%></B></FONT></TD>
		<TD><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=RS("prenda")%></B></FONT></TD>		
		<TD style="display:none"><FONT face=arial COLOR=MidnightBlue SIZE=1><B><%=mayor%></B></FONT></TD>		
	</TR>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>
<%'***************************************************
'				NUMERACION DE LA PAGINACION
'***************************************************%>
<TABLE border="0" cellpadding="0" cellspacing="0" align="center">
<TR>
<TD>
<%if registros_mostrados>0 then%>	
  <%if (num_min <> 1) then %>
  <a href="HLPESTAMPADOS.asp?pag=1" style="text-decoration:none; background-color:#FFFFCC; color:#000066"><< &nbsp</a>
  <a href="HLPESTAMPADOS.asp?pag=000<%=num_min%>" style="text-decoration:none background-color:#FFFFCC; color:#000066">< &nbsp</a>
  <%end if%>
  <%i=1
    if num_pag>num_max then num_total = num_max else num_total = num_pag end if
     for i = num_min to num_total
      if cInt(pagina_actual) = cInt(i) then%>
	      <font color="#FF0000"; font-weight:"bold"> <%=i%> </font>
      <%else%>
    	  <a href="HLPESTAMPADOS.asp?pag=<%=i%>" style="text-decoration:none; background-color:#FFFFCC; color:#000066"><%=i%></a>
      <%end if
     Next%>
 	<%if num_max < RS.PageCount then %>
      <a href="HLPESTAMPADOS.asp?pag=0000<%=num_max%>" style="text-decoration:none;background-color:#FFFFCC; color:#000066">&nbsp;></a>
      <a href="HLPESTAMPADOS.asp?pag=0000<%=RS.PageCount - 1%>" style="text-decoration:none;background-color:#FFFFCC; color:#000066">&nbsp;>></a>
    <% end if%>
<%END IF%>
    </TD>
   </TR>
</TABLE>
<%'********************************************************
'*********************************************************%>
<%end if%>
<script>
if ('<%=rs.recordcount%>' > 0 )
dd2('1');
</script>    
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</BODY>
</HTML>