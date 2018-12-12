<%
 Function RsNuevo
        Dim Connection, Recordset
        Set Recordset = Server.CreateObject("ADODB.Recordset")
        recordset.ActiveConnection = cnn
        Recordset.CursorType       = 3 'CONST adOpenStatic = 3
	    Recordset.LockType         = 1 'CONST adReadOnly = 1
	    Recordset.CursorLocation   = 3 'CONST adUseClient = 3
        Set RsNuevo = Recordset
    End Function
Function fnFileSize(cArchivo)
	On Error Resume Next
	Dim fso, f, cAppPhyPath
	cAppPhyPath=Request.ServerVariables("APPL_PHYSICAL_PATH")
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set f = fso.GetFile(cAppPhyPath&cArchivo)
	If Err.number = 0 Then
		fnFileSize = f.Size
	Else
		fnFileSize = 0
	End If
	Response.Write(err.number&" - "&f.Size)
End Function


Function decimaldocena(num)
	num =CDBL(num)
	nume = Int(num)
	VALOR = NUM - NUME
	VALOR= VALOR *12
	VALOR = CINT(abs(VALOR))
	CAD = TRIM(CSTR(NUME))
	decimaldocena= (CAD+ " " + LEFT(CSTR(VALOR),2))
end Function

function prepara_str_sql(str)
	IF NOT ISNULL(str) THEN
	    str = trim(str)
	    str = replace(str,"'","''")
	    str=replace(str,"--","")
	END IF
	prepara_str_sql = str
end function

function muestra_cadena(str)
	IF  NOT ISNULL(str) THEN
	str = trim(str)
	str = replace(str,"""","&quot;")
	str = replace(str,"<","&lt;")
	str = replace(str,">","&gt;")
	muestra_cadena = str
	END IF
end function
%>