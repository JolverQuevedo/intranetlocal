<!--#include file="JSON_2.0.4.asp"-->
<%
'	Libreria	: QueryToJSON
'	Autor		: Alex Peña Vargas
'	Fecha		: 03/03/2017

'Function QueryToJSON(dbcomm, params)
'        Dim rs, jsa
'        Set rs = dbcomm.Execute(,params,1)
'        Set jsa = jsArray()
'        Do While Not (rs.EOF Or rs.BOF)
'                Set jsa(Null) = jsObject()
'                For Each col In rs.Fields
'                        jsa(Null)(col.Name) = col.Value
'                Next
'        rs.MoveNext
'        Loop
'        Set QueryToJSON = jsa
'        rs.Close
'End Function

Function QueryToJSON(dbcomm)
        Dim rs, jsa
        Set rs = dbcomm.Execute
        Set jsa = jsArray()
        Do While Not (rs.EOF Or rs.BOF)
                Set jsa(Null) = jsObject()
                For Each col In rs.Fields
                        jsa(Null)(col.Name) = col.Value
                Next
        rs.MoveNext
        Loop
        Set QueryToJSON = jsa
        rs.Close
End Function

%>
<% 
  'Response.ContentType = "application/json; charset=utf-8"
  'strConn = "DRIVER={SQL Server};SERVER=APVSOFT-PC;UID=sa;PWD=sistemas;DATABASE=modelador"
  'Set conn = Server.CreateObject("ADODB.Connection")
  'conn.Open strConn
  'usuario = trim(Request.QueryString("usuario"))
  'password = trim(Request.QueryString("password"))
  'Set cmd = Server.CreateObject("ADODB.Command")
  'cmd.CommandText = "spUsuarios2 '"&usuario&"','"&password&"'" 
  'Set cmd.ActiveConnection = conn
  'QueryToJSON2(cmd).Flush
  'conn.Close : Set Conn = Nothing
%> 