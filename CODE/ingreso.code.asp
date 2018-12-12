<!--#include file="../includes/rutinas.asp"-->
<!--#include file="../includes/Cnn.inc"-->
<%'response.end


If Request.Form.Count>0 Then
	Dim usr
	Dim pwd
	Dim str_SQL
	Dim cnn
	Dim rs
	Dim owner
	Response.Cookies("usuario")("usuario") = ""
	usr= Request.Form("txtusr")
	pwd= Request.Form("txtpwd")
	Response.Cookies("usuario")("usuario") = usr
	Response.Cookies("user") = usr 
	Response.Cookies("user").Expires = Date + 365
	Response.Cookies("usuario").Expires = Date + 365
	Response.Write(Date + 365)

	str_SQL="SELECT CLAVE,NOMBRES FROM USUARIOS WHERE USUARIO = '"&usr&"' AND CLAVE = '"&pwd&"';"
	
	rs.open str_SQL, cnn
	If rs.EOF  or rs.BOF Then
		rs.Close 
		cnn.Close
		set cnn = Nothing
		set rs = Nothing
		
		Response.Write(mensaje("El Usuario o el Password estan errados"))
		'direcciono con comando javascript
		response.write("El Usuario o el Password estan errados")
		'response.end
        response.Redirect("index.asp")
       'Response.End
	End if
	' Se crea el cookie con el nombre del usuario
	RESPONSE.COOKIES("usuario")("usuario") = usr
	 rs.Close 
	cnn.Close
	set cnn = Nothing
	set rs = Nothing
	
	' Se direciona a las opciones del menu
	 Response.Redirect "menu.asp"
    
End If
%>