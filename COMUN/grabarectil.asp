<%@ Language=VBScript %>
<% Session.LCID = 2058 'Puntos y comas%>
<%  Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="../includes/rutinas.asp"-->

<%
usr = REQUEST.Cookies("USER")
COD		= TRIM(Request.querystring("COD"))
DES		= left(ucase(TRIM(Request.querystring("DES"))),60)
kgs	    = TRIM(Request.querystring("kgs"))
%>
<!--#include file="../includes/Cnn.inc"-->
<% cad = ""

'UPDATE
cad =	cad + "set dateformat dmy; update telas set	" & _
		" DESCRIPCION	= '"&DES&"',	            " & _
		" PESOUNI		= "&KGS&",		            " & _
		" FECHA			= getdate(),		        " & _
		" USUARIO		= '"&txtUsuario&"',	        " & _
		" ESTADO		= 'A'	                    " & _
		" where tela    = '"&cod&"';	            "
        
        ' EL CODIGO DEL REAL SE CAMBIA SOLO PARA CRUDO Y POR ESO TIENE LOS 0's AL FINAL....
        CODIGO = COD + +"0000000000"

CAD = CAD + " UPDATE RSFACCAR..AL0001ARTI       " &_
            " SET AR_CDESCRI = '"&DES&"'	    " & _
            " WHERE AR_CCODIGO = '"&CODIGO&"'   "
				
 

response.write(cad)
'response.Write("<BR>")
' Inicia transacción , para que los datos no queden a medias
'RESPONSE.WRITE(cad)
'rESPONSE.END
'*****************************
'		ENVIO DE MENSAJES
'*****************************
cnn.BeginTrans
	'On Error Resume Next
	cnn.Execute(CAD)
	
	If cnn.Errors.Count = 0 Then
		cnn.CommitTrans
		
		
	Else
		cnn.RollbackTrans
		'Muestro el mensaje de que se produjo un error al intentar realizar la operación
		Response.Write(mensaje("Error: No se pudieron grabar los datos, intente mas adelante"))
		Response.Write(NavegaHistory(-1)) ' volvemos al formulario
	End if
	

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing


%>
<script type="text/jscript" language="jscript">
  //  alert('<%=trim(cod)%>')
parent.window.location.replace('../rectil.asp?pos='+'<%=trim(cod)%>')
</script>
