
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />

<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%
Set cnn = Server.CreateObject("ADODB.Connection")
cnn.CommandTimeout = 900

'***********************************************************************************************
'   ESTE ES EL QUE ESTOY USANDO EN LA CASA y en EL MODELADOR
'***********************************************************************************************
dim txtConex
txtConex = Application("ConStr")
 Cnn.Open txtConex

Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.ActiveConnection = Cnn
	RS3.CursorType       = 3 'CONST adOpenStatic = 3
	RS3.LockType         = 1 'CONST adReadOnly = 1
	RS3.CursorLocation   = 3 'CONST adUseClient = 3
set txtConex = nothing

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body style="margin-top:0px">
<script ID=clientEventHandlersJS LANGUAGE=javascript>


</script>
<%CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp =  REQUEST.cookies("spe")
vr =  right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")

cad = "select * from specs_head WHERE SPEC= '"&SP&"' AND VER = '"&VR&"'; " 
'response.write(cad)
rs3.open cad,cnn
if rs3.recordcount > 0 then

    CLI = Rs3("CLI")
    TEM = Rs3("codtem")
    EST = Rs3("ESTilo")

end if
rs3.close
CAD = "SELECT * FROM CLIENTE_TEMP_EST_TALLA WHERE CLI= '"&CLI&"'  AND CODTEM= '"&TEM&"' AND ESTilo = '"&EST&"' "
'response.write(cad)
'response.write("<BR>")
rs3.OPEN CAD,CNN
IF rs3.RECORDCOUNT <= 0 THEN%>
<center>
	<font face="Arial, Helvetica, sans-serif" size="+1" color="red">
		NO HAY tallas REGISTRADAS para su seleccion.... 
        <%response.end%>
</center>

<%rs3.movefirst%>
<%end if%>
<TABLE width="100%" border="1" id="SERV" name="SERV" cellpadding="0" cellspacing="0">
<%cont = 0%>
	<tr bgcolor='<%=application("barra")%>'>
        <td width="4%" class="titulito" align="center" colspan="2">Medida</td>	
        <td width="1%" class="titulito" align="center" colspan="1">TOL +/-</td>	
		<%for i = 0 to 29 %>
        <%if len(trim(rs3.fields.item(i+3)))> 0 then %>
            <td class="TITULITO" align="center" ><%=trim(rs3.fields.item(i+3))%></td>
        <%else%>
            <% maxi= i
            exit for%>
        <%end if%>
		<%next%>
	</tr>		
    <% oor = request.cookies("orden")
       gru = request.cookies("grupo") 
    cad = "select * from view_spec_medidas where spec= '"&sp&"' and ver = '"&vr&"' and orden = '"&oor&"' and grupo ='"&gru&"' order by orden, lin "
        'response.Write(cad)
        rs3.close
        rs3.open cad, cnn
        if rs3.recordcount > 0 then rs3.movefirst
    %>
    
    <%do while not rs3.eof %>
        <%GRUPO = RS3("GRUPO") %>
        <tr>
            <td colspan='<%=(i+3)%>' class="TEXTOred"><%=trim(rs3("desgru"))%></td> 
        </tr>
        <%DO WHILE NOT rs3.EOF AND RS3("GRUPO") = GRUPO %>
            <tr>
               <input id="gru<%=cont%>" name="gru<%=cont%>"     value='<%=trim(rs3("grupo"))%>'  style="display:none">
                   <input id="med<%=cont%>" name="med<%=cont%>" value='<%=trim(rs3("medida"))%>' style="display:none">
                   <input id="ord<%=cont%>" name="ord<%=cont%>" value='<%=trim(rs3("orden"))%>'  style="display:none">
                   <input id="lin<%=cont%>" name="lin<%=cont%>" value='<%=trim(rs3("LIN"))%>'    style="display:none">
                
               <td><span  class="TEXTONAVYREADONLY">   <%=trim(rs3("grupo"))%>-<%=trim(rs3("medida"))%>&nbsp;</span></td> 
               <td><span  class="TEXTONAVYREADONLY">   <%=trim(rs3("desmed"))%>&nbsp;</span></td> 
               <td class="TEXTOblue100" align="center"><%=trim(rs3("tolera"))%>&nbsp;</td> 

		        <%for j=0 to i-1%>
                    <td width="2%" align="center" class="TEXTOblue100"> <%=trim(rs3.fields.item(j+9))%>&nbsp;</td>
                     
                <%next %>
	        </tr>
            <%cont = cont + 1%>
            <%rs3.movenext%>
             <%IF rs3.EOF THEN EXIT DO %>
        <%LOOP%>
        <%IF rs3.EOF THEN EXIT DO %>
    <%loop%>
</table>	

<%
set rs= nothing
set cnn=nothing
%>

<script>
</script>
</BODY>
</HTML>
