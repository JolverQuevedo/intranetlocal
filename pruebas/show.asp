<!--#include file="../includes/cnn.inc"-->
<%' -- show.asp --
  ' Generates a list of uploaded files
  '****************************************************************************
  ' MUESTRA LA TABLA COMPLETA DE IMAGENES GUARDADAS .....
  ' USANDO EL OBJETO <IMG > Y SU PROPIEDAD SRC ASIGNANDOLE "RESUPERAR.ASP"
  ' FUNCIONA BIEN BONITO!!!!!
  '****************************************************************************
  Response.Buffer = True%>
<%'****************************************************************************%>
<%'ESTA ES LA LINEA DEL CODIGO QUE VALE TOOOODO!                               %>
<%'****************************************************************************%>
<img src="BAKE/recuperaFOTOESTILO.asp?ID=<%'=rs("ID")%>&CLI=<%=POS%>" width="100" /> 
<%'**************************************************************************** %>










<html>
<head>
   <title></title>
  
</head>
<body>
   
   
   <table  border="1" align="center">
<%
   ' Recordset Object
 
      rs.Open "select  [ID],[imagen],[Content Type] " & _
         " from prueba order by [ID] desc", cnn, 3, 4

      If Not rs.EOF Then
         Response.Write "<tr><td colspan=""7"" align=""center""><i>"
         Response.Write "No. of records : " & rs.RecordCount
         Response.Write ", Table : Files</i><br>"
         Response.Write "</td></tr>"
   
         DO While Not rs.EOF%>
            <tr><td>
            <%=rs("ID")%></td>
            <td><img src="recuperar.asp?ID=<%=rs("ID")%>" width="100" /></TD>
            <TD><%=rs("Content Type")%></TD>
            </tr>
            <%rs.MoveNext
         LOOP
      Else
         Response.Write "No Record Found"
      End If
      
      rs.Close
      Set rs = Nothing
%>
   </table>
</body>
</html>
