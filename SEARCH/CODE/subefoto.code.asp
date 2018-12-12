<!--#include file="../includes/xelupload.asp"-->
<!--#include file="../includes/rutinas.asp"-->
<%
If UCase(Request.ServerVariables("REQUEST_METHOD"))= "POST" Then
	Dim up, fich
	Dim usuario
	
	
	set up = new xelUpload
	up.Upload()
	
	usuario = Request.Cookies("Usuario")("TELA")
	directorio = Request.Cookies("Usuario")("directorio")

	'Response.Write("Número de ficheros subidos: " & up.Ficheros.Count & "<br>")
	Response.Flush	
	For each fich in up.Ficheros.Items
		If (fich.TipoContenido="image/jpeg" or fich.TipoContenido="image/gif") and FormatNumber(fich.Tamano / 1024)<= 1600 Then
			'Response.Write("<ul>")
			'Response.Write("<li>Nombre: <b>" & fich.Nombre & "</b></li>")
			'Response.Write("<li>Tamaño: <b>" & fich.Tamano & "</b> bytes (" & FormatNumber(fich.Tamano / 1024) & " Kb)</li>")
			'Response.Write("<li>Tipo MIME: <b>" & fich.TipoContenido & "</b></li>")
			'Response.Write("</ul>")

			'Para guardarlo
			'	Con el nombre de fichero original:
			'	fich.Guardar Server.MapPath("fotos/")
			'	Con otro nombre:
			fich.GuardarComo ""&LCase(usuario)&".jpg", Server.MapPath(directorio)	
			Response.Write("<script language=""javascript"">window.opener.VeFoto("""&LCase(usuario)&".jpg"")</script>")
			
			
		'----------------------------------------------------------------
		Else
			
			Response.Write(mensaje("No se pudo grabar el Archivo solo se aceptan ""jpg"" y ""gif"" \ny que su tamaño sea menor o igual que 300 Kb"))
			Response.Write(direcionar("subefoto.asp"))
			Response.End
		End If
	Next

	'Limpiamos objeto
	set up = nothing
End If
%>


