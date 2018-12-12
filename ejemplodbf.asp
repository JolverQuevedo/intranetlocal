<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%
Dim Conn 
dim  Path 



Set Conn = CreateObject("ADODB.Connection")
'Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;" & _
'                   "Data Source=" & Path & ";" & _
'                   "Extended Properties=""DBASE IV;"";" 

Conn.Open "Provider=VFPOLEDB.1;Data Source=H:\ACOSTO;Collating Sequence=MACHINE"

Conn.execute("INSERT into ejemplo VALUES (350,'macel','asp', '01/01/10','tercer y piso', 123,'aa','sistemas','S')")
set Conn = nothing
Response.write("Registro Guardado")	   
%>