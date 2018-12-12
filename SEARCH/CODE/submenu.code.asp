<!--#include file="../includes/rutinas.asp"-->
<%
Dim usuario
Dim perfil
Dim tipo_menu
Dim cnn
Dim rs
Dim str_SQL
Dim nom_menu
Dim sub_menu
Dim cont
usuario = Request.Cookies("Usuario")("USUARIO")
perfil = Request.Cookies("Usuario")("Perfil")

tipo_menu = prepara_str_sql(Request.QueryString("tipo"))

Set cnn = Server.CreateObject("ADODB.Connection")

cnn.Open "Provider=SQLOLEDB; Data Source =67.19.166.82; Initial Catalog = icresil; User Id = molina; Password=c4r4m3l1t0"
Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnn
	rs.CursorType       = 3
	rs.LockType         = 1
	
str_SQL = "SELECT DESMENU FROM "&OWNER&".[MENU] MENU WHERE MENU = '"&tipo_menu&"'"
'Response.write(str_SQL)
rs.Open str_SQL,cnn

If rs.RecordCount > 0 Then
	rs.MoveFirst
	nom_menu=rs("DESMENU")
Else
	Response.Write(direcionar("menu.asp"))
	Response.End
End If
rs.Close

str_SQL = "SELECT SM.SUBMENU, SM.DESCRIPCION,SM.PROGRAMA, "&_
		  "UOP.PERFIL, SM.PARAMETROS "&_
		  "FROM "&OWNER&".[USR-OPC] UOP "&_
		  "INNER JOIN "&OWNER&".SUBMENU SM ON UOP.MENU = SM.MENU "&_
		  "AND UOP.SUBMENU = SM.SUBMENU "&_
		  "WHERE UOP.USUARIO = '"&usuario&"' AND SM.ESTADO = 'A' AND SM.MENU = '"&tipo_menu&"' "&_
		  "ORDER BY SM.DESCRIPCION"
		  
'RESPONSE.WRITE(STR_SQL)
rs.Open str_SQL,cnn

If rs.RecordCount > 0 Then
	rs.MoveFirst
	cont=0
	sub_menu="<table cellspacing=""4"" id=""menu"" align=""center""><tr>"&vbCrLf
	Do While Not rs.EOF
		sub_menu=sub_menu&" <td onMouseOut=""this.style.backgroundColor='#99CC99'"" onMouseOver  =""this.style.backgroundColor='DarkOliveGreen'"">"&_ 
						" <a href='"&LCase(Trim(rs("PROGRAMA")))&"?perfil="&LCase(Trim(rs("PERFIL")))&Lcase(Trim(rs("PARAMETROS")))&"' ><b>"&UCase(Trim(rs("DESCRIPCION")))&"</b></a></td>"&vbCrLf
		If cont = 2 Then
			cont=0
			sub_menu=sub_menu&" </tr><tr>"&vbCrLf
		Else
			cont=cont+1
		End If
		rs.MoveNext
	Loop
	sub_menu=sub_menu&" </tr></table>"&vbCrLf
Else
	Response.Write(mensaje("Usted no tiene opciones disponiblespara este Modulo."))	
End If
rs.Close 
cnn.Close
Set cnn = Nothing
Set rs = Nothing	  
%>