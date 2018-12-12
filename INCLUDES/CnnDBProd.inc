<%
Set cnn = Server.CreateObject("ADODB.Connection")
cnn.CommandTimeout = 900

'***********************************************************************************************
'   ESTE ES EL QUE ESTOY USANDO EN LA CASA y en EL MODELADOR
'***********************************************************************************************
dim txtConexion 
'txtConexion = Application("ConStr")
txtConexion = "Provider=SQLOLEDB.1;Data Source=SERVSQL\MSSQLSERVER1;Initial Catalog=DBPROD; User id=SA; Password=F3QY17;"
'"Provider=SQLOLEDB.1;Data Source=APVSOFT-PC;Initial Catalog=DBPROD; User id=SA; Password=sistemas;"
 Cnn.Open txtConexion

Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = Cnn
	RS.CursorType       = 3 'CONST adOpenStatic = 3
	RS.LockType         = 1 'CONST adReadOnly = 1
	RS.CursorLocation   = 3 'CONST adUseClient = 3
set txtConexion = nothing

%>