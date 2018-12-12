<!--#include file="../includes/cnn.inc"-->
<%
'****************************************************************************
' Recupera imagenes desde una base de datos
' ESTE ES EL QUE VALEEEEEEEEEEEEEEEEEEEEEEEE Y QUE SE COLOCA EN EL SRC
' DEL OBJETO <IMG> Y FUNKAAAAAAA
'****************************************************************************
Response.Buffer = True
ID = Request.querystring("ID")
CLI= Request.querystring("CLI")
'response.Write(id)
'response.Write("<br>")
'response.Write(cli)
'response.end


If Len(ID) < 1 Then ID = 1
CAD = "select FOTO, CONTENIDO from ESTILOS where CLIENTE= '"&CLI&"' AND CODEST ='"&ID&"'"
rs.Open CAD, cnn

If Not rs.EOF Then
Response.ContentType = rs("CONTENIDO")
Response.BinaryWrite rs("FOTO")
End If

rs.Close
Set rs = Nothing
%>
