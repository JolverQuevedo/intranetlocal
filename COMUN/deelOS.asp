<%@ Language=VBScript %>
<%  Response.Buffer = True
    txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<!--#include file="../includes/cnn.inc"-->
<html>
<head>
  <title></title>
</head>
<body>

  
  <% os= request.QueryString("os")
  
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	

cad =  " delete tempos where numord = '"&os&"' ; " 
 Response.Write(CAD)
 Cnn.Execute(CAD)
if  err.number <> 0 then
	    Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	    Cnn.RollbackTrans
	    Cnn.Abort
    else
	    Cnn.CommitTrans	
    end if
   
    'Response.END
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

%>
  
  
  
  
  
  

</body>
</html>
