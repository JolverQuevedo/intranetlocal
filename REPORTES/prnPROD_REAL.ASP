<%@ Language=VBScript %>
<% Response.Buffer = true %>


<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<style type="text/css">
    table
    { font-size:7pt;
        COLOR: navy;
        FONT-FAMILY: Arial;
        
    }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<script type="text/jscript" language="jscript">
var aCod = Array() 

</script>
<%	anio= Request.QueryString("anio")
TITULO =" REPORTE ANUAL DE PRODUCTOS TERMINADOS --> " + anio	
    archivo = "%temp%"+"prod_" + trim(anio)+ ".xls"
%>


<% ' Response.Charset = "UTF-8"
   ' Response.ContentType = "application/vnd.ms-excel" 
   ' Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo  %>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<title><%=titulo%></title>

   
</head>
<body>

<table cellpadding="22" cellspacing="0" border="0" align="center" width="100%" bordercolorlight="#f7d975">
	<tr><td align="center" ><%=titulo%></td></tr>
</table> 
     
<table width="100%" cellspacing="0" border="1" cellpadding="1">   
    <tr valign="top" ><b>
        <td align="left">CODIGO</td> 
        <td align="left">DESCRIPCION</td>          
        <td align="center">GPO</td>
        <td align="center">FAM</td>
        <td align="center">ALM</td>
        <td align="center">MON</td>
        <td align="right">P. UNI</td>
        <td align="right">ENE</td>
        <td align="right">FEB</td>
        <td align="right">MAR</td>
        <td align="right">ABR</td>
        <td align="right">MAY</td>
        <td align="right">JUN</td>
        <td align="right">JUL</td>
        <td align="right">AGO</td>
        <td align="right">SEP</td>
        <td align="right">OCT</td>
        <td align="right">NOV</td>
        <td align="right">DIC</td>
        <td align="right">TOTAL</td></b>
    </tr>
          
<!-------------------------------------------------->
        <%CAD =   " exec sp_PRODUCCION_FACCAR '"&anio&"' " 
            
   ' response.Write(CAD)
   
	rs.open CAD, cnn

        
        IF RS.RECORDCOUNT > 0 THEN
		    RS.MOVEFIRST
    	END IF
        
        
        dim AMES(13) %>
        <%do while not RS.eof %>
            <%cod = RS("codigo")
            for i = 0 to 12
                ames(i) = 0
            next
            %>
            <tr>
                <td><%=trim(RS("codigo"))%></td>
                <td><%=trim(RS("DESCRI"))%>&nbsp;</td>
                <td align="center"><%=trim(RS("gpo"))%>&nbsp;</td>
                <td align="center"><%=trim(RS("FAM"))%>&nbsp;</td>
                <td align="center"><%=trim(RS("alm"))%></td>
                <td align="center"><%=trim(RS("mon"))%></td>
                <td align="right"><%=formatnumber(cdbl(trim(RS("unit"))),2,,true)%></td>
            <%DO WHILE NOT RS.EOF AND RS("codigo") = cod%>   
            <%  aMes(cint(rs("mes"))) = cdbl(rs("cant"))
                aMes(0) = aMes(0) + cdbl(rs("cant"))
                rs.movenext
                IF RS.EOF THEN EXIT DO
                loop %>
                <%FOR I = 1 TO 12%>
                    <td align="right"><%if aMes(i) > 0 then ccc = formatnumber(aMes(i),0,,true) else ccc = "-"%>
                            <%=ccc%></td>    
                <%NEXT%>
                    <td align="right"><%=formatnumber(aMes(0),0,,,true)%></td>
                </tr>
               <%'response.end %>
            <%IF RS.EOF THEN EXIT DO %>
        <%LOOP %>
         
    
</table>





<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>