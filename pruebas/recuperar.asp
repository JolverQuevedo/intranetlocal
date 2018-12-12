<!--#include file="../includes/cnn.inc"-->
<%
'****************************************************************************
' Recupera imagenes desde una base de datos
' ESTE ES EL QUE VALEEEEEEEEEEEEEEEEEEEEEEEE Y QUE SE COLOCA EN EL SRC
' DEL OBJETO <IMG> Y FUNKAAAAAAA
'****************************************************************************
Response.Buffer = True
ID = Request.querystring("ID")
If Len(ID) < 1 Then ID = 1

rs.Open "select imagen,[content type] from prueba where ID = " & ID, cnn

If Not rs.EOF Then
Response.ContentType = rs("content type")
Response.BinaryWrite rs("imagen")
End If

rs.Close
Set rs = Nothing
%>
