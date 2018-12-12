<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
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
'*********************** OJO **********************
igv			= TRIM(Request.form("IGV"))
POR		    = TRIM(Request.form("POR"))
VMIN		= TRIM(Request.form("VMIN"))
DBK		    = TRIM(Request.form("DBK"))
COB		    = TRIM(Request.form("COB"))
IMPU		= TRIM(Request.form("IMPU"))
FC1			= TRIM(Request.form("FC1"))
FC2			= TRIM(Request.form("FC2"))
AIR			= TRIM(Request.form("AIR"))
SEA			= TRIM(Request.form("SEA"))
DHL			= TRIM(Request.form("DHL"))


	CAD =	" UPDATE  "&OWNER&".TB_CTRL set					" & _
				" PORCvALpRE	= isnull("&POR&",null) ,	" & _
                " PORigv        = isnull("&IGV&",null) ,	" & _
				" VALORMIN		= isnull("&VMIN&",null),	" & _
				" DBACK		    = isnull("&DBK&",null),	    " & _
				" COBERTURA	    = isnull("&COB&",null),		" & _
				" RENTA		    = isnull("&IMPU&",null),	" & _
				" FACTOR1	    = isnull("&FC1&",null),	    " & _
				" FACTOR2	    = isnull("&FC2&",null),		" & _
                " AIR	        = isnull("&AIR&",null),		" & _
                " SEA	        = isnull("&SEA&",null),		" & _
				" DHL	        = isnull("&DHL&",null)		"  
				
Response.Write(cad)
'response.end
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
Cnn.Execute(CAD)

if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing
%>

<SCRIPT>
window.location.replace('../parametros.asp')</SCRIPT>
</BODY>
</HTML>
