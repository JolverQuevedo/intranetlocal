<!--#include file="../includes/rutinas.asp"-->
<%
Dim usuario
'Dim perfil
Dim str_SQL
Dim cnn
Dim rs
Dim cont
Dim menu

usuario = Request.Cookies("Usuario")("USUARIO")
'txtPerfil = Request.Cookies("Usuario")("Perfil")
	
Set cnn = Server.CreateObject("ADODB.Connection")

cnn.Open "Provider=SQLOLEDB; Data Source =67.19.166.82; Initial Catalog = icresil; User Id = molina; Password=c4r4m3l1t0"

Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnn
	rs.CursorType       = 3 'CONST adOpenStatic = 3
	rs.LockType         = 1 'CONST adReadOnly = 1

str_SQL	= " SELECT menu.menu,MENU.DESMENU AS DESMENU, MENU.PROGRAMA, " & _ 
		" MENU.FOTO FROM "&OWNER&".[USR-OPC] [USR-OPC] LEFT OUTER JOIN " & _
		" "&OWNER&".MENU MENU ON [USR-OPC].MENU = MENU.MENU " & _
		" WHERE USUARIO = '"&usuario&"' AND MENU.ESTADO='A' " & _
		" GROUP BY MENU.DESMENU, MENU.PROGRAMA, MENU.FOTO, MENU.MENU "  & _
		" ORDER BY MENU.DESMENU"

rs.Open str_SQL, cnn
				
If rs.RecordCount>0 then
	rs.MoveFirst
	cont=0
	menu="<table cellspacing=""4"" id=""menu"" align=""center""><tr>"&vbCrLf
	Do While Not rs.EOF	
		menu=menu&" <td onMouseOut=""this.style.backgroundColor='#99CC99'"" onMouseOver  =""this.style.backgroundColor='DarkOliveGreen'"" >"&_
					"<a href='"&LCase(Trim(rs("PROGRAMA")))&"' ><b>"&UCase(Trim(rs("DESMENU")))&"</b></a></td>"&vbCrLf
		If cont = 2 Then
			cont=0
			menu=menu&" </tr><tr>"&vbCrLf
		Else
			cont=cont+1
		End If
		rs.MoveNext
	Loop
	menu=menu&" </tr></table>"&vbCrLf
Else
	Response.Write(mensaje("Usted no tiene opciones disponibles."))
End If
rs.Close 
cnn.Close
Set cnn = Nothing
Set rs = Nothing
%>