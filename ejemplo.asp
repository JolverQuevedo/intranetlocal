<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>



<body>
<%
'***********************************************************************************************************************************		
' ABRE OBJETO CONEXION Y LE PASA LOS PARAMETROS PARA 
' CONECTARSE AL SQL
'***********************************************************************************************************************************		
Set cnn = Server.CreateObject("ADODB.Connection")
Cnn.CommandTimeout = 900
txtConexion= ""
Cnn.Open "Provider=SQLOLEDB.1;Data Source=192.168.3.37;Initial Catalog=MODELADOR; User id=SA; Password=c4r4m3l1t0;"'***********************************************************************************************************************************		
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
	RS.Open "SELECT * FROM AVIOS", Cnn
	IF RS.RECORDCOUNT >0 THEN
	RS.MOVEFIRST%>
	<%ELSE%>
<SCRIPT>
	alert('nada que mostrar')
</SCRIPT>		
<%END IF %>
<%CONT =1%>
<% do while not rs.eof %>
	<table align="center" width="50%" border="1" cellpadding="0" cellspacing="1">
    	<tr <%IF CONT MOD 2 = 0 THEN%> bgcolor="#FF00CC" <%else%> bgcolor="#999999" <%end if%>>
			<%for i=1 to rs.fields.count%> 		
            	<TD   <%IF I MOD 2 = 0 THEN %> class="TXTANIO" <%else%> class="REPORTESCENTER" 	<%end if%>>
			<%=LTRIM(RTRIM(rs.fields(i-1)))%>
            
            </TD>
		     <%next%>
        </tr>
	
    <%rs.movenext%>
    <%CONT = CONT + 1%>
<%loop%>    
</table>
</body>
<%SET CNN = NOTHING
  SET RS = NOTHING %>
</html>
