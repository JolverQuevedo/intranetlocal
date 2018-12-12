
<%
'****************************************************************************
' Recupera imagenes desde una base de datos
' ESTE ES EL QUE VALEEEEEEEEEEEEEEEEEEEEEEEE Y QUE SE COLOCA EN EL SRC
' DEL OBJETO <IMG> Y FUNKAAAAAAA
'****************************************************************************
Response.Buffer = True
txtCn = Application("ConStr")

Set RS9 = Server.CreateObject("ADODB.Recordset")
	RS9.ActiveConnection = txtCn
	RS9.CursorType       = 3 'CONST adOpenStatic = 3
	RS9.LockType         = 1 'CONST adReadOnly = 1
	RS9.CursorLocation   = 3 'CONST adUseClient = 3



CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp  = REQUEST.cookies("spe")
vr  = right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")

CAD = " select FOTO1, CONTENIDO from SPECS_head where SPEC = '"&Sp&"' and VER = '"&Vr&"'    " 
'response.write(cad)
RS9.Open CAD, txtCn

'response.end
If RS9.recordcount > 0 Then
    RS9.movefirst
     if  isnull(trim(RS9("foto1"))) then
        Response.ContentType ="image/jpeg"
        RS9.close
        RS9.open "select foto from TB_CTRL", cnn
        Response.BinaryWrite RS9("FOTO")
    else
        Response.ContentType = RS9("CONTENIDO")
        Response.BinaryWrite RS9("FOTO1")
    end if
End If

rs9.Close
Set rs9 = Nothing
%>
