<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla

pag		= Request.QueryString("pagesize")
tabla	= Request.QueryString("tbl")
cod		= Request.QueryString("cod")
des		= Request.QueryString("des")
url		= Request.QueryString("url")
pk		= Request.QueryString("PK")
KK		= Request.QueryString("KK") 
cli		= Request.QueryString("cli") 
cliente	= Request.QueryString("descli") 
mark	= Request.QueryString("MARK") 
perfil  = Request.QueryString("perfil")
Response.Write(kk)
Response.Write("<br>")
	CAD =   " SELECT top "&pag&" "&cod&", "&des&"   from "&tabla&" " & _
			" where " 
	CAD = CAD + "  "&des&" like  '%"&kk&"%' "
if len(trim(cli)) > 0 then
	cad = cad + "and  cliente = '"&cli&"'"
end if
	CAD = CAD+	" order by "&COD&" "		
Response.Write (cad)	
'Response.end
	RS.Open CAD, CNN
	if not rs.EOF then
		rs.movefirst
		registro = rs.FIELDS(0)
	else
		registro = "0"
		msg="Lo sentimos, Resultado sin registros coincidentes"
	end if	
rs.Close
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
cad = url & "?pos=" & (registro )&"&perfil="&perfil
if len(trim(cli)) > 0 then
	cad = cad & "codcli=" & cli
	cad = cad & "cliente=" & cliente
end if
if len(trim(MARK)) > 0 then
	cad = cad & "&COSTO=" & MARK
end if
response.write(cad)
'Response.End
Response.Redirect(cad)
%>
</BODY>
</HTML>
