<%@ Language=VBScript %>
<% Response.Buffer = true %>

<%
'***********************************************************************************************************************************		
' ABRE OBJETO CONEXION Y LE PASA LOS PARAMETROS PARA 
' CONECTARSE AL SQL
'***********************************************************************************************************************************		
Set cnn = Server.CreateObject("ADODB.Connection")
Cnn.CommandTimeout = 900
txtConexion= "Provider=SQLOLEDB.1;Data Source=192.168.3.37;Initial Catalog=MODELADOR; User id=SA; Password=c4r4m3l1t0;"
Cnn.Open txtConexion
'***********************************************************************************************************************************		
' ABRE UN OBJETO RECORDSET PARA PODER MOSTRAR LOS REGISTROS
' Y  LE ASIGNA EL OBJETO CONEXIÓN
'***********************************************************************************************************************************		
Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = Cnn
	RS.CursorType       = 3 'CONST adOpenStatic = 3
	RS.LockType         = 1 'CONST adReadOnly = 1
	
'***********************************************************************************************************************************		
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'***********************************************************************************************************************************		
CAD =	" SELECT * from telas " 
'***********************************************************************************************************************************		
' PARA EJECUTAR LA CONSULTA SE ASIGNA LA CADENA AL OBJETO RECORDSET		
'***********************************************************************************************************************************		
	RS.Open CAD, Cnn
	IF RS.RECORDCOUNT >0 THEN
	RS.MOVEFIRST%>
	<%ELSE%>
<SCRIPT>
	alert('nada que mostrar')
</SCRIPT>		
<%END IF %>


<HEAD>

<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>


<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000">

<% do while not rs.eof%>
	 <%FOR I=0 TO RS.FIELDS.COUNT- 1%>
     	<%=RS.FIELDS(I)%>
     <%NEXT%>
     <BR>
	 <%RS.MOVENEXT%>
<%LOOP%>
<%' COMO YA NO NECESITO LA CONEXION, PORQUE YA TENGO MI RECORDSET EN MEMORIA
' LA CIERRO Y ASI AHORRO RECURSOS DEL SERVIDOR
set txtConexion = nothing
set rs = nothing%>
</BODY>
</HTML>
