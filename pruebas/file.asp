<%
   ' -- file.asp --
   ' Retrieves binary files from the database.
   '****************************************************************************
   ' NO FUNCIONA, SOLO MUESTRA CHINO BASICO --> D E S E C H A R ......
   '****************************************************************************
   Response.Buffer = True
   ' ID of the file to retrieve
   Dim ID
      ID = Request("ID")
   If Len(ID) < 1 Then
      ID = 3
   End If%>
   
  <!--#include file="../includes/cnn.inc"-->
   
   <%' Connection String
     rs.Open "select [imagen],[Content Type] from prueba where ID = " & _
         ID, cnn, 2, 4

      If Not rs.EOF Then
         Response.ContentType = rs("Content Type")
         Response.BinaryWrite rs("IMAGEN")
      End If
      
      
      rs.Close
      Set rs = Nothing
%>
