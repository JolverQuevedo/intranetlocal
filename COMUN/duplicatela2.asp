<%@ Language=VBScript %>
<% Session.LCID = 2058 'Puntos y comas%>
<%  Response.Buffer = true %>
<!--#include file="../includes/rutinas.asp"-->

<%
usr = REQUEST.Cookies("USER")
COD	= TRIM(Request.querystring("COD"))

%>
<!--#include file="../includes/Cnn.inc"-->
<% 		
cnn.BeginTrans
CAD = "EXEC TL_Copia_Tela '" & COD & "', '" & USR & "'   "
		cnn.execute(CAD)		
RESPONSE.WRITE(CAD)	
	If cnn.Errors.Count = 0 Then
		cnn.CommitTrans
	Else
		cnn.RollbackTrans
		'Muestro el mensaje de que se produjo un error al intentar realizar la operación
		Response.Write(mensaje("Error: No se pudieron grabar los datos, intente mas adelante"))
		Response.Write(NavegaHistory(-1)) ' volvemos al formulario
	End if

	cad = "select max(tela) as telas from telas where left(tela,3) = left('"&cod&"',3)"
   
rs.open cad
cod = rs("telas")
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing
'response.end

%>
<script language="jscript" type="text/jscript">
parent.window.location.replace('../RECTIL.asp?pos='+ '<%=COD%>')
</script>
