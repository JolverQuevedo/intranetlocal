<%
Set cnn = Server.CreateObject("ADODB.Connection")
cnn.CommandTimeout = 900

'***********************************************************************************************
'   ESTE ES EL QUE ESTOY USANDO EN LA CASA y en EL MODELADOR
'***********************************************************************************************
dim txtConexion 
txtConexion ="Provider=SQLOLEDB.1;Data Source=PC-JQUEVEDO\SQLEXPRESS;Initial Catalog=modelador; User id=SA; Password=123456;"
'txtConexion ="Provider=SQLOLEDB.1;Data Source=SERVSQL\MSSQLSERVER1;Initial Catalog=modelador; User id=SA; Password=F3QY17;"
 Cnn.Open txtConexion

Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = Cnn
	RS.CursorType       = 3 'CONST adOpenStatic = 3
	RS.LockType         = 1 'CONST adReadOnly = 1
	RS.CursorLocation   = 3 'CONST adUseClient = 3
set txtConexion = nothing


Application("color1")       = "#F0F0F0" 	' gris
Application("color2")       = "#FFFFFF"  	' blanco
Application("BARRA")        = "#DDEBC6"		' VERDE CLARO
Application("head")         = "#0087d1"		' AZULINO CLARO
Application("BORDE")        = "#999999"		' GRAFITO
Application("titulo")       = "#3366CC"		' AZULINO OSCURO
Application("resalte")      = "#FF6600"		' NARANJA OSCURO
Application("fondito")      = "#f7d975"     ' NARANJA CLARO
Application("contraste")    = "#009900"		' VERDE OSCURO
Application("subtot")       = "#c4c4c4"     ' GAINSBORO
Application("owner")        = "dbo"
Application("BARRA2")        = "red"		' rojo
%>
