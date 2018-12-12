<!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/funcionesVBscript.asp"-->
<style type="text/css">
table.tablejolver {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        .tablejolver thead> tr {
            background:#333;
            color:#fff;
            text-transform:uppercase;
        }
        .tablejolver td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        .tablejolver tr:nth-child(even) {
            background-color: #dddddd;
        }</style>
<% 
set rsdata = RsNuevo
cad = "select * from [poestilosofiprotocolorytallas] where cliente ='00001' and ESTCLI='5475891'"
response.write(cad)
rsdata.open cad,cnn
%>
<% IF  request.QueryString("EXCEL") = "1" THEN
    archivo = "c:\temp\TNTexcel"&date&".xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
  END IF

 %>
<table class="tablejolver">
    <thead>
        <tr>
            <td>
                CLIENTE
            </td>
            <td>
                CODARTICULO
            </td>
            <td>
                AR_CDESCRI
            </td>
            <td>
                PO
            </td>
            <td>
                ESTCLI
            </td>
            <td>
                OFI
            </td>
            <td>
                proto
            </td>
            <td>
                COLOR
            </td>
            <td>
                CODIGO
            </td>
            <td>
                Prendas Totales
            </td>
            <td>
                Prendas Totales 5%
            </td>
            
            <% for i=0 to 9 %>
            <td>
                <%
                x = "T"&i
                response.write(rsdata(x)) %>
            </td>
            <% next %>
            <td>Total Cuellos</td>
            <% for i=0 to 9 %>
            <td>
                <%
                x = "T"&i
                response.write(rsdata(x)) %>
            </td>
            <% next %>
            <td>
                Total Puños
            </td>
            <% for i=0 to 9 %>
            <td>
                <%
                x = "T"&i
                response.write(rsdata(x)) %>
            </td>
            <% next %>
            <td>
                Total Cuellos 5%
            </td>
            <% for i=0 to 9 %>
            <td>
                <%
                x = "T"&i
                response.write(rsdata(x)) %>
            </td>
            <% next %>
            
            <td>
                Total Puño 5%
            </td>
        </tr>
    </thead>
    <tbody>
        <%IF NOT RSdata.EOF THEN%>
        <%DO WHILE NOT RSdata.EOF%>
        <tr >
            <%for i=0 to 10%>
            <td class="TEXTO">
                <%=response.Write(RSdata.fields(i)) %>
            </td>
            
            <%NEXT%>
            <%for i=21 to rsdata.fields.count-1%>
            <td class="TEXTO">
                <%=response.Write(RSdata.fields(i)) %>
            </td>
            <%NEXT%>
            <%RSdata.MOVENEXT%>
        </tr>
        <%loop%>
        <%end if %>
    </tbody>
</table>
