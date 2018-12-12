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
CHK		= Request.QueryString("chk")
COD		= TRIM(Request.QueryString("pos"))
gen		= TRIM(Request.QueryString("GEN"))
TIP		= TRIM(Request.QueryString("TIP"))
DES		= TRIM(Request.QueryString("DES"))
URL		= TRIM(Request.QueryString("URL"))
cli		= TRIM(Request.QueryString("CLI"))
FECHA ="{ fn NOW() }"
tbl = trim(application("owner"))+".ESTILOS"
'	busca el código a actualizar
	CAD =   " SELECT ESTILO FROM "&tbl&"	" & _
			" WHERE   ESTILO	= '"&COD&"'	" 
	rs.open cad,cnn
	if rs.recordcount <= 0 then 
    CAD =	" insert into "&tbl&"	                    " & _
			" (estilo, DESCRIPCION, tipoprenda, genero,	" & _
			"  cliente, ESTADO, usuario, fecha )		" & _
			" values('"&COD&"', upper('" & DES & "'),	" & _
			" '"&TIP&"', '"&GEN&"',  '"&CLI&"',			" & _
			"  'A', '"&USUARIO&"', "&fecha&" )			" 
	rs.close
else	
	if rs.recordcount <= 0 then response.end
	SELECT CASE CHK
			CASE "1"
				CAD =	" UPDATE "&tbl&"  SET		        " & _
						" USUARIO			= '"&USUARIO&"'," & _
						" FECHA				= "&fecha&" ,	" & _
						" ESTADO			= 'E'			" & _ 
						" WHERE   ESTILO	= '"&COD&"'		" 
						cod = ""
			CASE "0"
				CAD =	" UPDATE  "&tbl&"  set		            " & _
				        " DESCRIPCION	   = upper('"&DES&"'),	" & _ 
				        " TIPOPRENDA	   = upper('"&TIP&"'),	" & _ 
				        " GENERO    	   = upper('"&GEN&"'),	" & _ 
				        " ESTADO		   = 'A',			    " & _
				        " USUARIO		   = '"&USUARIO&"',     " & _
				        " FECHA			   = "&fecha&"		    " & _
				        " WHERE   ESTILO   = '"&COD&"'		    " 
				
		END SELECT
end if	
' Inicia transacción , para que los datos no queden a medias
response.write(cad)
'response.end
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
'Response.Write(CAD)
'Response.END


Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
URL =  URL + "POS=" + TRIM(Request.QueryString("pos")) + "&cli=" & trim(cli)
%>
<script>
window.parent.location.replace('<%=url%>')
</script>
</BODY>
</HTML>
