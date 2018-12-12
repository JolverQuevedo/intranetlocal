<!--#include file="../includes/cnn.inc"-->
<%
'****************************************************************************
' Recupera imagenes desde una base de datos
' ESTE ES EL QUE VALEEEEEEEEEEEEEEEEEEEEEEEE Y QUE SE COLOCA EN EL SRC
' DEL OBJETO <IMG> Y FUNKAAAAAAA
'****************************************************************************
Response.Buffer = True

CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp  = REQUEST.cookies("spe")
vr  = right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")

CAD = " select FOTO1, CONTENIDO from SPECS_head where SPEC = '"&Sp&"' and VER = '"&Vr&"'    " 
'response.write(cad)
rs.Open CAD, cnn

'response.end
If rs.recordcount > 0 Then
    rs.movefirst
     if  isnull(trim(rs("foto1"))) then
        Response.ContentType ="image/jpeg"
        rs.close
        rs.open "select foto from TB_CTRL", cnn
        Response.BinaryWrite rs("FOTO")
    else
        Response.ContentType = rs("CONTENIDO")
        Response.BinaryWrite rs("FOTO1")
    end if
End If

rs.Close
Set rs = Nothing
%>
