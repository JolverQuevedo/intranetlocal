<%
Function OpenDBFConn(Path)
  Dim Conn 
  Set Conn = CreateObject("ADODB.Connection")
  Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;" & _
                   "Data Source=" & Path & ";" & _
                   "Extended Properties=""DBASE Iii;"";" 
  Set OpenDBFConn = Conn
End Function
%>