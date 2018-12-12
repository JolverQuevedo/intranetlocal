<!--#include file="../includes/cnn.inc"-->
<%
'****************************************************************************
' Recupera imagenes desde una base de datos
' ESTE ES EL QUE VALEEEEEEEEEEEEEEEEEEEEEEEE Y QUE SE COLOCA EN EL SRC
' DEL OBJETO <IMG> Y FUNKAAAAAAA
'****************************************************************************
Response.Buffer = True
SPE = Request.querystring("SPE")
VER = Request.querystring("VER")
ORD = Request.querystring("ORD")
GRU = Request.querystring("GRU")

CAD = " select FOTO, CONTENIDO from SPECS_GRUPOS where SPEC = '"&Spe&"' " & _
      " and VER = '"&Ver&"' AND ORDEN = '"&Ord&"' AND GRUPO='"&Gru&"'   " 
'response.write(cad)
rs.Open CAD, cnn

'response.end
If rs.recordcount > 0 Then
    rs.movefirst
     if  isnull(trim(rs("foto"))) then
        Response.ContentType ="image/jpeg"
        rs.close
        rs.open "select foto from TB_CTRL", cnn
        Response.BinaryWrite rs("FOTO")
    else
        Response.ContentType = rs("CONTENIDO")
        Response.BinaryWrite rs("FOTO")
    end if
End If

rs.Close
Set rs = Nothing
%>
